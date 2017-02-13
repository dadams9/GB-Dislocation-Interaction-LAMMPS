close all
clear
clc
%For: Dr. Homer
%Date: 2/6/17
%From: Devin Adams
%Purpose: To find the RSS of dislocations transmitting through a GB
%TANTALUM 7 Sample


%% %Grain 1 Calculations
k = 1; %Counter for the number of files read in
for step=70000:500:200000
    BaseName='zzFinedump.Ta7_550_N12_StressVolumePress1L_';
    FileName=[BaseName,num2str(step),'.out'];

    %Skip the first 9 lines of the dumpfile, then start reading it
    dumpfile = dlmread(FileName, ' ', 9, 0);


    %Should be able to just start from here by loading the correct dump files
    %with the needed information
    stresses = dumpfile(:,8:13);         %6 components of the stress tensor for each atom, in the following order: xx, yy, zz, xy, xz, yz.
    volumes  = dumpfile(:,14);           %voronoi volume for each atom
    id       = dumpfile(:,1);            %id for each atom
    x        = dumpfile(:,3);            %x location for each atom
    y        = dumpfile(:,4);            %y location for each atom
    z        = dumpfile(:,5);            %z location for each atom
    sv1i     = dumpfile(:,16);           %slip direction 1 for each atom
    sv2i     = dumpfile(:,17);           %slip direction 2 for each atom
    sv3i     = dumpfile(:,18);           %slip direction 3 for each atom
    sv4i     = dumpfile(:,19);           %magnitude of slip direction for each atom


    
    j=1;
    for i=1:length(sv4i)
      if sv4i(i) ~=0
        sv1(j) = sv1i(i);       %slip direction 1 for each atom that's slipping
        sv2(j) = sv2i(i);       %slip direction 2 for each atom that's slipping
        sv3(j) = sv3i(i);       %slip direction 3 for each atom that's slipping
        sv4(j) = sv4i(i);       %magnitude of slip for each atom that's slipping
        sid(j) = id(i);         %id for each atom that's slipping
        xs(j)  = x(i);          %x location for each atom that's slipping
        ys(j)  = y(i);          %y location for each atom that's slipping
        zs(j)  = z(i);          %z location for each atom that's slipping
        j=j+1;
      end
    end

    
    slip_vectors = [sid ; xs; ys; zs; sv1; sv2; sv3; sv4]';
    slip_atomid   =  1524746;% 1601934;% %ID of the atom to get the location of that atom's information in the slip vector
                                  %For Ta3, Grain 1 use:1555490;%   1492188; %
                                           %For Ta3, Grain 2 use:2289641;% 2405363;%
                                           %For Ta3, GB use: 1502557;%
    %Find the location of the center of the box around the dislocation we're interested in    
    box_loc = find(id==slip_atomid);
    cent_x = x(box_loc);        %x coordinate of the atom used for the center of the box
    cent_y = y(box_loc);        %y coordinate of the atom used for the center of the box 
    cent_z = z(box_loc);        %z coordinate of the atom used for the center of the box


    
    %Find the volume of the box around the dislocation. Adjust the y-20 and
    %y+20 parameters to increase or decrease the size of the box. The sv4i
    %is there to filter out any atoms that aren't slipping. One can also
    %filter out any atoms that are not where the transmission occurs
    j=1;
    for i = 1:length(x)
        if y(i)>(cent_y-20) && y(i)<(cent_y+20) && sv4i(i)>0 && z(i)>10 && z(i)<160
            box_volumes(j) = volumes(i);        %volume of each atom in the box around the dislocation
            box_stress(j,1) = stresses(i,1);    %box_stress is the 6 components of the stress
            box_stress(j,2) = stresses(i,2);    %tensor for each atom in the box
            box_stress(j,3) = stresses(i,3);
            box_stress(j,4) = stresses(i,4);
            box_stress(j,5) = stresses(i,5);
            box_stress(j,6) = stresses(i,6);
            x_box(j) = x(i);
            y_box(j) = y(i);
            z_box(j) = z(i);
            SD1(j) = sv1i(i);                   %SD1-SD3 are the slip vector values for each of the atoms
            SD2(j) = sv2i(i);                   %These will be used to find the average slip vector later
            SD3(j) = sv3i(i);
            j=j+1;
        end
    end

    lab_stress   = sum(box_stress,1);           %sum of the box_stress, the box around the dislocation
    total_volume = sum(box_volumes);            %totals the volume of each atom in the box around the dislocation 
    stress_LF = lab_stress/(total_volume*10);   %Stress tensor in the Lab Frame
                                                %since LAMMPS outputs the stress as a stress*volume, we divide the 
                                                %box stress by the box volume to get just the actual stress. We then                    
                                                %divide by 10 to convert from bar to MPa
  
    %Create the stress tensor in the lab frame
    LF_Stress_Tensor=[stress_LF(1) stress_LF(4) stress_LF(5)    %[sigma_x  tau_xy  tau_xz
                      stress_LF(4) stress_LF(2) stress_LF(6)    % tau_yx   sigma_y tau_yz
                      stress_LF(5) stress_LF(6) stress_LF(3)];  % tau_zx   tau_zy  sigma_z]

                                                
% %     %Calculate the slip plane using least square for all atoms in slip
% %     %region
% %     for i=1:length(x_box)
% %         X(i,1) = 1;
% %         X(i,2) = x_box(i);
% %         X(i,3) = y_box(i);
% %         Z(i) = z_box(i);
% %     end
% %     
% %     u = inv(X.'*X)*X.'*(Z');
% %     
% %     U(k,1) = u(2);
% %     U(k,2) = u(3);
% %     U(k,3) = u(1);
% %     %Un-normalized normal vector coefficients
% %     N(1) = u(2);
% %     N(2) = u(3);
% %     N(3) = u(1); 
     
    
    %Find the index of the atom we're using to calculate the slip plane in
    %the sv matrix
    loc_slip = find(sid==slip_atomid);

    

    
   %direction vector of the slip plane
    d  = [sv1(loc_slip) sv2(loc_slip) sv3(loc_slip)];  %this is obtained from sv1, sv2, sv3 for the atom we're interested in, so it should be possible to get this if the id is known
        Ud(k,1) = d(1);
        Ud(k,2) = d(2);
        Ud(k,3) = d(3);
        
    %Normal vector to the slip plane manually determined by visualizing the
    %plane in OVITO   
    N  = [0 1 0];
          
    
    %Normalize the normal, slip, and y vectors of the slip plane
    N = [N(1)/norm(N) N(2)/norm(N) N(3)/norm(N)];
    d = [d(1)/norm(d) d(2)/norm(d) d(3)/norm(d)];

    %Y dimension of the slip plane, N cross d
    Y = cross(N,d);

        
    %Slip Plane Matrix using the single atom's slip vector as the slip
    %direction
    LF_SlipPlane = [d(1) d(2) d(3);
                 Y(1) Y(2) Y(3);
                 N(1) N(2) N(3)];
             
     
    L = [1 0 0; 0 1 0; 0 0 1];      %lab frame matrix
         
% %     for i=1:3
% %        for j=1:3
% %            C(i,j) = dot(LF_SlipPlane(i,:),L(j,:));
% %        end
% %     end
% %      C = C';    
     
    %Normalize the crystal frame matrix
    G1_Ta7 = [18 -12 -12; 2 20 -17; 444 282 384];

    G1_Ta7  = [G1_Ta7(1,1)/norm(G1_Ta7(1,:)) G1_Ta7(1,2)/norm(G1_Ta7(1,:)) G1_Ta7(1,3)/norm(G1_Ta7(1,:));   
               G1_Ta7(2,1)/norm(G1_Ta7(2,:)) G1_Ta7(2,2)/norm(G1_Ta7(2,:)) G1_Ta7(2,3)/norm(G1_Ta7(2,:));
               G1_Ta7(3,1)/norm(G1_Ta7(3,:)) G1_Ta7(3,2)/norm(G1_Ta7(3,:)) G1_Ta7(3,3)/norm(G1_Ta7(3,:))];
    
    %Find A which is the rotation matrix from
    %the lab frame into the crystal frame
    for i=1:3
       for j=1:3
           A(i,j) = dot(G1_Ta7(i,:),L(j,:));
       end
    end
        A = A';
        
        %Using A, rotate the slip plane and direction into the frame of the
        %crystal, i.e., the grain
        N2  = A*N';
        d2  = A*d';
        Y2  = A*Y';
    
        CF_SlipPlane =  [d2(1) d2(2) d2(3);
                         Y2(1) Y2(2) Y2(3);
                         N2(1) N2(2) N2(3)];  
      
    %A2 is the rotation matrix from the crystal frame into the slip plane
    %using the single atom's slip vector
    for i=1:3
       for j=1:3
           A2(i,j) = dot(CF_SlipPlane(i,:),L(j,:));
       end
    end
     A2 = A2';
 
     
% %     %Rotate the stress tensor from the lab frame straight into the slip plane of the crystal
% %     ResolvedSS=C*LF_Stress_Tensor*C.';
% %     ResolvedSS13(k) = ResolvedSS(1,3);
     
   
    %Find the stress tensor in the crystal frame using rotation matrix A to
    %rotate stresses from the Lab Frame
    CF_Stress_Tensor=A*LF_Stress_Tensor*A.';
        CF13(k) = CF_Stress_Tensor(1,3);

    %Find the stress tensor in the frame of the slip plane (RSS) using 
    %rotation matrix A2 to rotate stresses from the Crystal Frame        
    RSS = A2*CF_Stress_Tensor*A2.';  
        RSS11(k) = RSS(1,1);
        RSS12(k) = RSS(1,2);
        RSS13(k) = RSS(1,3);
        RSS21(k) = RSS(2,1);
        RSS22(k) = RSS(2,2);
        RSS23(k) = RSS(2,3);
        RSS31(k) = RSS(3,1);
        RSS32(k) = RSS(3,2);
        RSS33(k) = RSS(3,3);
              
        
    k=k+1
end
%% %Graphing Values for Grain 1
q = [1:length(RSS13)];

%Graph of the 13/31 component of RSS
figure(13311)
plot(q,RSS13,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('13/31 Component of RSS Grain 1')

%Graph of the 11 component of RSS
figure(111)
plot(q,RSS11,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('11 Component of RSS Grain 1')

%Graph of the 22 component of RSS
figure(221)
plot(q,RSS22,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('22 Component of RSS Grain 1')

%Graph of the 33 component of RSS
figure(331)
plot(q,RSS33,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('33 Component of RSS Grain 1')

%Graph of the 12/21 component of RSS
figure(12211)
plot(q,RSS12,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('12/21 Component of RSS Grain 1')

%Graph of the 23/32 component of RSS
figure(23321)
plot(q,RSS23,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('23/32 Component of RSS Grain 1')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%End of Grain 1 Calculations%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% %Grain 2 Calculations

k = 1; %Counter for the number of files read in
for step=86500:500:190000
    BaseName2='zzFinedump.Ta7_550_N12_StressVolumePress2R_';
    FileName2=[BaseName2,num2str(step),'.out'];
    %Skip the first 9 lines of the dumpfile, then start reading it
    dumpfile2 = dlmread(FileName2, ' ', 9, 0);
    
    
    stressesR = dumpfile2(:,8:13);         %6 components of the stress tensor for each atom, in the following order: xx, yy, zz, xy, xz, yz.
    volumesR  = dumpfile2(:,14);           %voronoi volume for each atom
    idR       = dumpfile2(:,1);            %id for each atom
    xR        = dumpfile2(:,3);            %x location for each atom
    yR        = dumpfile2(:,4);            %y location for each atom
    zR        = dumpfile2(:,5);            %z location for each atom
    sv1iR     = dumpfile2(:,16);           %slip direction 1 for each atom
    sv2iR     = dumpfile2(:,17);           %slip direction 2 for each atom
    sv3iR     = dumpfile2(:,18);           %slip direction 3 for each atom
    sv4iR     = dumpfile2(:,19);           %magnitude of slip direction for each atom
    
        j=1;
    for i=1:length(sv4iR)
      if sv4iR(i) ~=0
        sv1R(j) = sv1iR(i);       %slip direction 1 for each atom that's slipping
        sv2R(j) = sv2iR(i);       %slip direction 2 for each atom that's slipping
        sv3R(j) = sv3iR(i);       %slip direction 3 for each atom that's slipping
        sv4R(j) = sv4iR(i);       %magnitude of slip for each atom that's slipping
        sidR(j) = idR(i);         %id for each atom that's slipping
        xsR(j)  = xR(i);          %x location for each atom that's slipping
        ysR(j)  = yR(i);          %y location for each atom that's slipping
        zsR(j)  = zR(i);          %z location for each atom that's slipping
        j=j+1;
      end
    end
    

    slip_vectorsR = [sidR ; xsR; ysR; zsR; sv1R; sv2R; sv3R; sv4R]';
    
    %ID number of the atom in the simulation that is used to calculate the
    %slip direction and location of boxed region for analysis
    slip_atomidR  = 2312063 ;%2311945;% 2318687;%  
    
    %Find the location of the center of the box around the dislocation we're interested in       
    box_locR = find(idR==slip_atomidR);
    cent_xR = xR(box_locR);        %x coordinate of the atom used for the center of the box
    cent_yR = yR(box_locR);        %y coordinate of the atom used for the center of the box 
    cent_zR = zR(box_locR);        %z coordinate of the atom used for the center of the box
    

    
    %Find the volume of the box around the dislocation. Adjust the y-20 and
    %y+20 parameters to increase or decrease the size of the box. The sv4i
    %is there to filter out any atoms that aren't slipping. One can also
    %filter out any atoms that are not where the transmission occurs
    j=1;
    for i = 1:length(xR)
        if yR(i)>(cent_yR-5) && yR(i)<(cent_yR+5) && sv4iR(i)>0 %&& zR(i)>10 && zR(i)<160
            box_volumesR(j) = volumesR(i);        %volume of each atom in the box around the dislocation
            box_stressR(j,1) = stressesR(i,1);    %box_stress is the 6 components of the stress
            box_stressR(j,2) = stressesR(i,2);    %tensor for each atom in the box
            box_stressR(j,3) = stressesR(i,3);
            box_stressR(j,4) = stressesR(i,4);
            box_stressR(j,5) = stressesR(i,5);
            box_stressR(j,6) = stressesR(i,6);
            x_boxR(j) = xR(i);
            y_boxR(j) = yR(i);
            z_boxR(j) = zR(i);
            SD1R(j) = sv1iR(i);                   %SD1-SD3 are the slip vector values for each of the atoms
            SD2R(j) = sv2iR(i);                   %These will be used to find the average slip vector later
            SD3R(j) = sv3iR(i);
            j=j+1;
        end
    end

    lab_stressR   = sum(box_stressR,1);           %sum of the box_stress, the box around the dislocation
    total_volumeR = sum(box_volumesR);            %totals the volume of each atom in the box around the dislocation 
    stress_LFR = lab_stressR/(total_volumeR*10);  %Stress tensor in the Lab Frame
                                                  %since LAMMPS outputs the stress as a stress*volume, we divide the 
                                                  %box stress by the box volume to get just the actual stress. We then                    
                                                  %divide by 10 to convert from bar to MPa                                            
    
    %Create the stress tensor in the lab frame
    LF_Stress_TensorR=[stress_LFR(1) stress_LFR(4) stress_LFR(5)    %[sigma_x  tau_xy  tau_xz
                       stress_LFR(4) stress_LFR(2) stress_LFR(6)    % tau_yx   sigma_y tau_yz
                       stress_LFR(5) stress_LFR(6) stress_LFR(3)];  % tau_zx   tau_zy  sigma_z]
     
    %Find the index of the atom we're using to calculate the slip plane in
    %the sv matrix
    loc_slipR = find(sidR==slip_atomidR);
    
    %Slip direction as determined by SV compute in LAMMPS or manually
    %determined by visualizing the direction in OVITO
    dR = [sv1R(loc_slipR) sv2R(loc_slipR) sv3R(loc_slipR)];
            UdR(k,1) = dR(1);
            UdR(k,2) = dR(2);
            UdR(k,3) = dR(3);
    dR = [1 -1 0];
    
    
    %Normal vector to the slip plane manually determined by visualizing the
    %plane in OVITO         
    NR = [1 1 0];

    %Normalize the normal, slip, and y vectors of the slip plane
    NR = [NR(1)/norm(NR) NR(2)/norm(NR) NR(3)/norm(NR)];
    dR = [dR(1)/norm(dR) dR(2)/norm(dR) dR(3)/norm(dR)];
    
    %Y dimension of the slip plane, N cross d
    YR = cross(NR,dR);

    LF_SlipPlaneR = [dR(1) dR(2) dR(3);
                     YR(1) YR(2) YR(3);
                     NR(1) NR(2) NR(3)];  
                 
                 
    %Normalize the crystal frame matrix
    G2_Ta7 = [153 -4 23; 3 17 -17 ;-323 2670 2613];
    G2_Ta7  = [G2_Ta7(1,1)/norm(G2_Ta7(1,:)) G2_Ta7(1,2)/norm(G2_Ta7(1,:)) G2_Ta7(1,3)/norm(G2_Ta7(1,:));   
               G2_Ta7(2,1)/norm(G2_Ta7(2,:)) G2_Ta7(2,2)/norm(G2_Ta7(2,:)) G2_Ta7(2,3)/norm(G2_Ta7(2,:));
               G2_Ta7(3,1)/norm(G2_Ta7(3,:)) G2_Ta7(3,2)/norm(G2_Ta7(3,:)) G2_Ta7(3,3)/norm(G2_Ta7(3,:))];
    
    L = [1 0 0; 0 1 0; 0 0 1];      %lab frame matrix     
         
    
    %Find B which is the rotation matrix from
    %the lab frame into the crystal frame
    for i=1:3
       for j=1:3
           B(i,j) = dot(G2_Ta7(i,:),L(j,:));
       end
    end
        B = B';
        %Using B, rotate the slip plane and direction into the frame of the
        %crystal, i.e., the grain
        N2R  = B*NR';
        d2R  = B*dR';
        Y2R  = B*YR';
    
        %Slip Plane in the frame of the Crystal
        CF_SlipPlaneR =  [d2R(1) d2R(2) d2R(3);
                         Y2R(1) Y2R(2) Y2R(3);
                         N2R(1) N2R(2) N2R(3)];  
     
    %B2 is the rotation matrix from the crystal frame into the slip plane
    %using the single atom's slip vector
    for i=1:3
       for j=1:3
           B2(i,j) = dot(CF_SlipPlaneR(i,:),L(j,:));
       end
    end
     B2 = B2';
    
   
    %Find the stress tensor in the crystal frame using rotation matrix A to
    %rotate stresses from the Lab Frame
    CF_Stress_TensorR=B*LF_Stress_TensorR*B.';
        CF13R(k) = CF_Stress_TensorR(1,3);
    
        
    %Find the stress tensor in the frame of the slip plane (RSS) using 
    %rotation matrix A2 to rotate stresses from the Crystal Frame      
    RSSR = B2*CF_Stress_TensorR*B2.';  
        RSS11R(k) = RSSR(1,1);
        RSS12R(k) = RSSR(1,2);
        RSS13R(k) = RSSR(1,3);
        RSS21R(k) = RSSR(2,1);
        RSS22R(k) = RSSR(2,2);
        RSS23R(k) = RSSR(2,3);
        RSS31R(k) = RSSR(3,1);
        RSS32R(k) = RSSR(3,2);
        RSS33R(k) = RSSR(3,3);

    k=k+1
end

%% %Graphing Values for Grain 2
q = [1:length(RSS13R)];

%Graph of the 13/31 component of RSS
figure(13312)
plot(q,RSS13R,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('13/31 Component of RSSR Grain 2')

%Graph of the 11 component of RSS
figure(112)
plot(q,RSS11R,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('11 Component of RSSR Grain 2')

%Graph of the 22 component of RSS
figure(222)
plot(q,RSS22R,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('22 Component of RSSR Grain 2')

%Graph of the 33 component of RSS
figure(332)
plot(q,RSS33R,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('33 Component of RSSR Grain 2')

%Graph of the 12/21 component of RSS
figure(12212)
plot(q,RSS12R,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('12/21 Component of RSSR Grain 2')

%Graph of the 23/32 component of RSS
figure(23322)
plot(q,RSS23R,'k')
ylabel('Stress (MPa)')
xlabel('Step')
title('23/32 Component of RSSR Grain 2')
%%%-----------------------------------------------------------------
%%%End of Grain 2 Calculations
%%%-----------------------------------------------------------------
