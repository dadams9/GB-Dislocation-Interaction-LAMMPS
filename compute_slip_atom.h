/* -*- c++ -*- ----------------------------------------------------------
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

#ifdef COMPUTE_CLASS

ComputeStyle(slip/atom,ComputeSlipAtom)

#else

#ifndef LMP_COMPUTE_SLIP_ATOM_H
#define LMP_COMPUTE_SLIP_ATOM_H

#include "compute.h"

namespace LAMMPS_NS {

class ComputeSlipAtom : public Compute {
 public:
  ComputeSlipAtom(class LAMMPS *, int, char **);
  ~ComputeSlipAtom();
  void init();
  void init_list(int, class NeighList *);
  void compute_peratom();
  double memory_usage();

private:
  int nmax;
  double cutsq,btol;
  class NeighList *list;
  double **slip;
  char *id_fix;
  class FixStore *fix;
  
  
};

}

#endif
#endif

/* ERROR/WARNING messages:

E: Illegal ... command

Self-explanatory.  Check the input script syntax and compare to the
documentation for the command.  You can use -echo screen as a
command-line option when running LAMMPS to see the offending line.

E: Could not find compute displace/atom fix ID

Self-explanatory.

*/
