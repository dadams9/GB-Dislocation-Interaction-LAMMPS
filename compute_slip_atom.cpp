/* ----------------------------------------------------------------------
   LAMMPS - Large-scale Atomic/Molecular Massively Parallel Simulator
   http://lammps.sandia.gov, Sandia National Laboratories
   Steve Plimpton, sjplimp@sandia.gov
 
   Adapted from compute_displace_atom and compute_centro_atom
   Written by Eric Homer and Garritt Tucker.
   Based on slip vector by J. A. Zimmerman, C. L. Kelchner, P. A. Klein, 
      J. C. Hamilton, and S. M. Foiles. PRL, 2001, vol 87, 165507.

   Copyright (2003) Sandia Corporation.  Under the terms of Contract
   DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
   certain rights in this software.  This software is distributed under
   the GNU General Public License.

   See the README file in the top-level LAMMPS directory.
------------------------------------------------------------------------- */

#include "math.h"
#include "string.h"
#include "compute_slip_atom.h"
#include "atom.h"
#include "update.h"
#include "group.h"
#include "domain.h"
#include "modify.h"
#include "fix.h"
#include "fix_store.h"
#include "memory.h"
#include "error.h"
//#include "stdlib.h"
#include "neighbor.h"
#include "neigh_list.h"
#include "neigh_request.h"
#include "force.h"
#include "pair.h"
#include "comm.h"
#include "citeme.h"

using namespace LAMMPS_NS;

static const char cite_compute_slip_atom[] =
"compute slip/atom command:\n\n"
"@Article{Zimmerman01,\n"
" author = {J. A. Zimmerman, C. L. Kelchner, P. A. Klein, J. C. Hamilton, and S. M. FOILES},\n"
" title = {Surface step effects on nanoindentation},\n"
" journal = {Physical Review Letters},\n"
" year =    2001,\n"
" volume =  87,\n"
" pages =   {165507}\n"
"}\n\n";


/* ---------------------------------------------------------------------- */

ComputeSlipAtom::ComputeSlipAtom(LAMMPS *lmp, int narg, char **arg) :
  Compute(lmp, narg, arg)
{
  if (lmp->citeme) lmp->citeme->add(cite_compute_slip_atom);
  
  if (narg < 4) error->all(FLERR,"Illegal compute slip/atom command");
  
  btol = force->numeric(FLERR,arg[3]);
  
  //Set cutoff
  if (narg == 5) {
    cutsq = force->numeric(FLERR,arg[4]);
    cutsq = cutsq * cutsq;
  }
  else cutsq = -1;

  peratom_flag = 1;
  size_peratom_cols = 4;

  // create a new fix STORE style
  // id = compute-ID + COMPUTE_STORE, fix group = compute group

  int n = strlen(id) + strlen("_COMPUTE_STORE") + 1;
  id_fix = new char[n];
  strcpy(id_fix,id);
  strcat(id_fix,"_COMPUTE_STORE");

  char **newarg = new char*[5];
  newarg[0] = id_fix;
  newarg[1] = group->names[igroup];
  newarg[2] = (char *) "STORE";
  newarg[3] = (char *) "1";
  newarg[4] = (char *) "3";
  modify->add_fix(5,newarg);
  fix = (FixStore *) modify->fix[modify->nfix-1];
  delete [] newarg;

  // calculate xu,yu,zu for fix store array
  // skip if reset from restart file

  if (fix->restart_reset) fix->restart_reset = 0;
  else {
    double **xoriginal = fix->astore;

    double **x = atom->x;
    int *mask = atom->mask;
    int nlocal = atom->nlocal;

    for (int i = 0; i < nlocal; i++)
      if (mask[i] & groupbit)
        for (int j = 0; j < 3; j++)
          xoriginal[i][j] = x[i][j];
      else xoriginal[i][0] = xoriginal[i][1] = xoriginal[i][2] = 0.0;
  }

  // per-atom slip array

  nmax = 0;
  slip = NULL;
}

/* ---------------------------------------------------------------------- */

ComputeSlipAtom::~ComputeSlipAtom()
{
  // check nfix in case all fixes have already been deleted

  if (modify->nfix) modify->delete_fix(id_fix);

  delete [] id_fix;
  memory->destroy(slip);
}

/* ---------------------------------------------------------------------- */

void ComputeSlipAtom::init()
{
  // set fix which stores original atom coords

  int ifix = modify->find_fix(id_fix);
  if (ifix < 0) error->all(FLERR,"Could not find compute slip/atom fix ID");
  fix = (FixStore *) modify->fix[ifix];
  
  // check details of pair_style and copies of this compute style
  
  if (force->pair == NULL)
    error->all(FLERR,"Compute slip/atom requires a pair style be defined");
  
  int count = 0;
  for (int i = 0; i < modify->ncompute; i++)
    if (strcmp(modify->compute[i]->style,"slip/atom") == 0) count++;
  if (count > 1 && comm->me == 0)
    error->warning(FLERR,"More than one compute slip/atom");
  
  //check the cutoff value and set default if necessary
  if (cutsq > force->pair->cutforce * force->pair->cutforce)
    error->all(FLERR,"Compute slip/atom: invalid cutoff value");
  if (cutsq  < 0) {
    cutsq = force->pair->cutforce * force->pair->cutforce;
  }
  
  // need an occasional full neighbor list
  
  int irequest = neighbor->request((void *) this);
  neighbor->requests[irequest]->pair = 0;
  neighbor->requests[irequest]->compute = 1;
  neighbor->requests[irequest]->half = 0;
  neighbor->requests[irequest]->full = 1;
  neighbor->requests[irequest]->occasional = 1;
}

/* ---------------------------------------------------------------------- */

void ComputeSlipAtom::init_list(int id, NeighList *ptr)
{
  list = ptr;
}

/* ---------------------------------------------------------------------- */

void ComputeSlipAtom::compute_peratom()
{
  
  int i,j,k,ii,jj,inum,jnum;
  double xtmp,ytmp,ztmp,delx,dely,delz,rsq;
  int *ilist,*jlist,*numneigh,**firstneigh;
  
  invoked_peratom = update->ntimestep;

  // grow local slip array if necessary

  if (atom->nlocal > nmax) {
    memory->destroy(slip);
    nmax = atom->nmax;
    memory->create(slip,nmax,4,"slip/atom:slip");
    array_atom = slip;
  }
  
  // invoke full neighbor list (will copy or build if necessary)
  
  neighbor->build_one(list);
  
  inum = list->inum;
  ilist = list->ilist;
  numneigh = list->numneigh;
  firstneigh = list->firstneigh;

  // dx,dy,dz = slip of atom from original position
  // original unwrapped position is stored by fix
  // for triclinic, need to unwrap current atom coord via h matrix
  
  // compute slip vector for each atom in group
  // use full neighbor list

  double **xoriginal = fix->astore;

  double **x = atom->x;
  int *mask = atom->mask;
  imageint *image = atom->image;
  int nlocal = atom->nlocal;
  
  double del0[3],delf[3];
  
  int ns;
  
  for (ii = 0; ii < inum; ii++) {
    i = ilist[ii];
    for (k = 0; k < 4; k++) slip[i][k]=0.0;
    ns = 0;
    if (mask[i] & groupbit) {
      jlist = firstneigh[i];
      jnum = numneigh[i];
      
      // loop over list of all neighbors within force cutoff
      
      for (jj = 0; jj < jnum; jj++) {
        j = jlist[jj];
        j &= NEIGHMASK;
        
        for (k = 0; k < 3; k++)
          del0[k] = xoriginal[i][k] - xoriginal[j][k];
        domain->minimum_image(del0);
        
        rsq = 0;
        for (k = 0; k < 3; k++)
          rsq += del0[k] * del0[k];
        
        if (rsq < cutsq) {
          
          for (k = 0; k < 3; k++)
            delf[k] = x[i][k] - x[j][k];
          domain->minimum_image(delf);
          
          double slipmag = 0;
          double slipcheck[3];
          
          for (k = 0; k < 3; k++) {
            slipcheck[k] = del0[k] - delf[k];
            slipmag += slipcheck[k] * slipcheck[k];
          }
          
          if (slipmag > btol) {
            ns++;
            for (k = 0; k < 3; k++)
              slip[i][k] += slipcheck[k];
          }
        }
      }
          
      if (ns > 0) {
        //calculate final division and magnitude
        for (k = 0; k < 3; k++) {
          slip[i][k] /= -ns;
          slip[i][3] += slip[i][k] * slip[i][k];
        }
        slip[i][3] = sqrt(slip[i][3]);
      }
    }
  }
}

/* ----------------------------------------------------------------------
   memory usage of local atom-based array
------------------------------------------------------------------------- */

double ComputeSlipAtom::memory_usage()
{
  double bytes = nmax*4 * sizeof(double);
  return bytes;
}
