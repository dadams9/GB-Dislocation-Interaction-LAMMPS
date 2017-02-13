%Calculate the transmissivity of GB - dislocation interactions

%%%---------------------------------------------%%%
%--Be sure to change the rotation matrix B and the impinging dislocation
%inoformation and the emitted slip system to calculate on before running
%the program.--%
%%%---------------------------------------------%%%
clc;
clear all

%Select the slip system for emitted dislocation in
%BCC to calculate the transmissivity.
%1 = (110)<111>
%2 = (211)<111>
%3 = (321)<111>
SlipSystem = 1;

%Rotation Matrix from lab to crystal in grain with emitted dislocation
% %Ta3
% B =  [0.8184   -0.2673   -0.5087
%    -0.1040    0.8018   -0.5885
%     0.5652    0.5345    0.6284];

% %Ta7
% B = [0.9886    0.1238   -0.0861
%    -0.0258    0.7017    0.7120
%     0.1486   -0.7017    0.6968];

% %Ta4
% B = [0.8971    0.4195   -0.1388
%    -0.2760    0.7773    0.5653
%     0.3450   -0.4689    0.8131];

%Ta5
B = [ 0.7937    0.4099   -0.4494
   -0.5849    0.7172   -0.3788
    0.1671    0.5635    0.8090];

%Grain 1 (left)
GB_Plane = [1 0 0];

%NOTE!!!  These are all in the LAB FRAME
e1  = [1 9 3]/norm([1 9 3]);    %Slip plane normal of piled up dislocation
g1  = [15 -2 1]/norm([15 -2 1]);    %Slip direction of pile up dislocation
L1 = cross(e1,GB_Plane);

%-------------------------------------------------------------------------


if SlipSystem == 1
    %Slip Directions for BCC crystal with a 211 slip plane
    gi(1,:)  = [-1 1 1]/norm([1 1 1]);
    gi(2,:)  = [1 -1 1]/norm([1 1 1]);
    gi(3,:)  = [1 1 1]/norm([1 1 1]);
    gi(4,:)  = [1 1 -1]/norm([1 1 1]);
    gi(5,:)  = [1 1 -1]/norm([1 1 1]);
    gi(6,:)  = [-1 1 1]/norm([1 1 1]);
    gi(7,:)  = [1 1 1]/norm([1 1 1]);
    gi(8,:)  = [1 -1 1]/norm([1 1 1]);
    gi(9,:)  = [1 1 -1]/norm([1 1 1]);
    gi(10,:) = [1 -1 1]/norm([1 1 1]);
    gi(11,:) = [1 1 1]/norm([1 1 1]);
    gi(12,:) = [-1 1 1]/norm([1 1 1]);
   
    %12 potential slip plane normals of the emitted dislocation
    ei(1,:) = [1 1 0]/norm([1 1 0]);  
    ei(2,:) = [1 1 0]/norm([1 1 0]);
    ei(3,:) = [1 -1 0]/norm([1 1 0]);
    ei(4,:) = [1 -1 0]/norm([1 1 0]);
    ei(5,:) = [1 0 1]/norm([1 1 0]);
    ei(6,:) = [1 0 1]/norm([1 1 0]);
    ei(7,:) = [1 0 -1]/norm([1 1 0]);
    ei(8,:) = [1 0 -1]/norm([1 1 0]);
    ei(9,:) = [0 1 1]/norm([1 1 0]);
    ei(10,:)= [0 1 1]/norm([1 1 0]);
    ei(11,:)= [0 1 -1]/norm([1 1 0]);
    ei(12,:)= [0 1 -1]/norm([1 1 0]);
end


if SlipSystem == 2
    %Slip Directions for BCC crystal with a 211 slip plane
    gi(1,:)  = [1 1 -1]/norm([1 1 -1]);
    gi(2,:)  = [1 -1 1]/norm([1 1 1]);
    gi(3,:)  = [-1 1 1]/norm([1 1 1]);
    gi(4,:)  = [1 1 1]/norm([1 1 1]);
    gi(5,:)  = [1 -1 1]/norm([1 1 1]);
    gi(6,:)  = [1 1 -1]/norm([1 1 1]);
    gi(7,:)  = [1 1 1]/norm([1 1 1]);
    gi(8,:)  = [-1 1 1]/norm([1 1 1]);
    gi(9,:)  = [-1 1 1]/norm([1 1 1]);
    gi(10,:) = [1 1 1]/norm([1 1 1]);
    gi(11,:) = [1 1 -1]/norm([1 1 1]);
    gi(12,:) = [1 -1 1]/norm([1 1 1]);
   
    %12 potential slip plane normals of the emitted dislocation
    ei(1,:) = [1 1 2]/norm([2 1 1]);  
    ei(2,:) = [-1 1 2]/norm([2 1 1]);
    ei(3,:) = [1 -1 2]/norm([2 1 1]);
    ei(4,:) = [1 1 -2]/norm([2 1 1]);
    ei(5,:) = [1 2 1]/norm([2 1 1]);
    ei(6,:) = [-1 2 1]/norm([2 1 1]);
    ei(7,:) = [1 -2 1]/norm([2 1 1]);
    ei(8,:) = [1 2 -1]/norm([2 1 1]);
    ei(9,:) = [2 1 1]/norm([2 1 1]);
    ei(10,:)= [-2 1 1]/norm([2 1 1]);
    ei(11,:)= [2 -1 1]/norm([2 1 1]);
    ei(12,:)= [2 1 -1]/norm([2 1 1]);
end

if SlipSystem == 3
    %Slip Directions for BCC crystal with a 123 slip plane
    gi(1,:)  = [1 1 -1]/norm([1 1 -1]);
    gi(2,:)  = [1 -1 1]/norm([1 1 1]);
    gi(3,:)  = [-1 1 1]/norm([1 1 1]);
    gi(4,:)  = [1 1 1]/norm([1 1 1]);
    gi(5,:)  = [1 -1 1]/norm([1 1 1]);
    gi(6,:)  = [1 1 -1]/norm([1 1 1]);
    gi(7,:)  = [1 1 1]/norm([1 1 1]);
    gi(8,:)  = [-1 1 1]/norm([1 1 1]);
    gi(9,:)  = [1 1 -1]/norm([1 1 1]);
    gi(10,:) = [1 -1 1]/norm([1 1 1]);
    gi(11,:) = [-1 1 1]/norm([1 1 1]);
    gi(12,:) = [1 1 1]/norm([1 1 1]);
    gi(13,:)  = [1 -1 1]/norm([1 1 1]);
    gi(14,:)  = [1 1 -1]/norm([1 1 1]);
    gi(15,:)  = [1 1 1]/norm([1 1 1]);
    gi(16,:)  = [-1 1 1]/norm([1 1 1]);
    gi(17,:)  = [-1 1 1]/norm([1 1 1]);
    gi(18,:)  = [1 1 1]/norm([1 1 1]);
    gi(19,:)  = [1 1 -1]/norm([1 1 1]);
    gi(20,:)  = [1 -1 1]/norm([1 1 1]);
    gi(21,:)  = [-1 1 1]/norm([1 1 1]);
    gi(22,:) = [1 1 1]/norm([1 1 1]);
    gi(23,:) = [1 1 -1]/norm([1 1 1]);
    gi(24,:) = [1 -1 1]/norm([1 1 1]);

    %Slip plane variants for the 123 plane in BCC
    ei(1,:) = [1 2 3]/norm([1 2 3]);  
    ei(2,:) = [-1 2 3]/norm([1 2 3]);
    ei(3,:) = [1 -2 3]/norm([1 2 3]);
    ei(4,:) = [1 2 -3]/norm([1 2 3]);
    ei(5,:) = [1 3 2]/norm([1 2 3]);
    ei(6,:) = [-1 3 2]/norm([1 2 3]);
    ei(7,:) = [1 -3 2]/norm([1 2 3]);
    ei(8,:) = [1 3 -2]/norm([1 2 3]);
    ei(9,:) = [2 1 3]/norm([1 2 3]);
    ei(10,:)= [-2 1 3]/norm([1 2 3]);
    ei(11,:)= [2 -1 3]/norm([1 2 3]);
    ei(12,:)= [2 1 -3]/norm([1 2 3]);
    ei(13,:) = [2 3 1]/norm([1 2 3]);  
    ei(14,:) = [-2 3 1]/norm([1 2 3]);
    ei(15,:) = [2 -3 1]/norm([1 2 3]);
    ei(16,:) = [2 3 -1]/norm([1 2 3]);
    ei(17,:) = [3 1 2]/norm([1 2 3]);
    ei(18,:) = [-3 1 2]/norm([1 2 3]);
    ei(19,:) = [3 -1 2]/norm([1 2 3]);
    ei(20,:) = [3 1 -2]/norm([1 2 3]);
    ei(21,:) = [3 2 1]/norm([1 2 3]);
    ei(22,:)= [-3 2 1]/norm([1 2 3]);
    ei(23,:)= [3 -2 1]/norm([1 2 3]);
    ei(24,:)= [3 2 -1]/norm([1 2 3]);
end

%Because we've defined the slip system for the emitted dislocation in the
%crystal frame, we need to rotate it back into the lab frame so that all of
%the planes and directions are in the same reference frame
for i=1:length(gi)
    dotp(i) = dot(ei(i,:),gi(i,:));
    ei(i,:) = B'*ei(i,:)';
    gi(i,:) = B'*gi(i,:)';
    
end
dotp = dotp';


%Calculate the line of intersection between the GB and the possible emitted
%dislocations then normalize the vectordislocations
for i=1:length(gi)
    Li(i,:) = cross(ei(i,:),GB_Plane);
    Li(i,:) = Li(i,:)/norm(Li(i,:));
end

%Criterion 2 from the shen wagoner paper for predictin emitted slip system
%Maximum M gives the corresponding slip system. Maximum M (magnitude) is 
%the predicted slip system
for i=1:length(gi)
    M(i) = (dot(Li(i,:),L1)*dot(g1,gi(i,:)));
end
M = M'




  


 