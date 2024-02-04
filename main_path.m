%Tomás Chamorro
%Cod: 201610011014
%Date: 20/08/2020

clc
close all

%-------------------------Excercise 4.4.3
WORLD = eye(4);
AXES_SIZE = 5;
%Plotting World and initial position of the triangle
figure(1)
clf
hold on
quiv_plot_axes(WORLD, AXES_SIZE, "k", "b", "r", "Xw","Yw","Zw","Ow")
tri=[2, 1, 1, 2;

 1, 1.5, 1, 1;

 0, 0, 0.5, 0;

 1, 1, 1, 1];

S0 = [0 0 1 1;
      1 0 0 1;
      0 1 0 0;
      0 0 0 1];
  
quiv_plot_axes(S0, AXES_SIZE, "k", "b", "r", "X0","Y0","Z0","O0")
plot3(tri(1,:),tri(2,:),tri(3,:));

%--------------Translation to the origin
%Verifyng that the M1 is doing what is is supposed to do
M1 = [1 0 0 -1;
    0 1 0 -1;
    0 0 1 0;
    0 0 0 1];
S1 = M1*S0;
tri_to_origin = M1*tri;
figure(2)
hold on
quiv_plot_axes(WORLD, AXES_SIZE, "k", "b", "r", "Xw","Yw","Zw","Ow")
quiv_plot_axes(S1, AXES_SIZE, "k", "b", "r", "X1","Y1","Z1","O1")
plot3(tri_to_origin(1,:),tri_to_origin(2,:),tri_to_origin(3,:));


%---------Rotation of 90º about Y
%Rotating matrix
M2 = [cosd(90) 0 sind(90) 0;
      0 1 0 0;
      -sind(90) 0 cosd(90) 0;
      0 0 0 1];
%Verifying that M2 rotates a matrix about Y
S2 = M2*S1;
tri_rotated_aboutY = M2*tri_to_origin;
figure(3)
hold on
quiv_plot_axes(WORLD, AXES_SIZE, "k", "b", "r", "Xw","Yw","Zw","Ow")
quiv_plot_axes(S2, AXES_SIZE, "k", "b", "r", "X2","Y2","Z2","O2")
plot3(tri_rotated_aboutY(1,:),tri_rotated_aboutY(2,:),tri_rotated_aboutY(3,:));


%---------------Rotation about the Z axis by -90º
M3 = [cosd(-90) -sind(-90) 0 0;
      sind(-90) cosd(-90) 0 0;
      0 0 1 0;
      0 0 0 1];
S3 = M3*S2;
figure(4)
hold on
tri_rotated_aboutZ = M3*tri_rotated_aboutY;
quiv_plot_axes(WORLD, AXES_SIZE, "k", "b", "r", "Xw","Yw","Zw","Ow")
quiv_plot_axes(S3, AXES_SIZE, "k", "b", "r", "X3","Y3","Z3","O3")
plot3(tri_rotated_aboutZ(1,:),tri_rotated_aboutZ(2,:),tri_rotated_aboutZ(3,:));


%--- Translating the figure to the final position specified in the book
M4 = [1 0 0 0;
    0 1 0 1;
    0 0 1 1;
    0 0 0 1];
S4 = M4 * S3;
figure(5)
hold on
tri_final_translation = M4*tri_rotated_aboutZ;
quiv_plot_axes(WORLD, AXES_SIZE, "k", "b", "r", "Xw","Yw","Zw","Ow")
quiv_plot_axes(S4, AXES_SIZE, "k", "b", "r", "X4","Y4","Z4","O4")
plot3(tri_final_translation(1,:),tri_final_translation(2,:),tri_final_translation(3,:));

%Checking the total transformation of the solid
M_TOTAL = M4*M3*M2*M1;


%---------------------Exercise 4.6.1
global ROUND_ERROR
ROUND_ERROR = 0.00001;
MQ = S4*inv(S0);
RQ = MQ(1:3,1:3);

%Proving that RQ is SO3
Proof_RQ_SO3 = RQ*RQ'; %Identity Matrix
det(RQ) % Det = 1, then RQ is SO3

%Extracting equivalent rotation matrix of RQ
[rotation_axisRQ,angle_rotationRQ]=rot_to_quat(RQ);

[SQ]=rotate_set_quaternion(rotation_axisRQ,angle_rotationRQ,S1)
%Figure with SQ and S4
figure(6)
hold on
quiv_plot_axes(WORLD, AXES_SIZE, "k", "b", "r", "Xw","Yw","Zw","Ow")
quiv_plot_axes(S4, AXES_SIZE, "k", "b", "r", "X4","Y4","Z4","O4")
quiv_plot_axes(SQ, AXES_SIZE, "k", "b", "r", "XQ","YQ","ZQ","OQ")

%Figure with SQ and S4
figure(7)
hold on
quiv_plot_axes(WORLD, AXES_SIZE, "k", "b", "r", "Xw","Yw","Zw","Ow")
quiv_plot_axes(S1, AXES_SIZE, "k", "b", "r", "X1","Y1","Z1","O1")
quiv_plot_axes(SQ, AXES_SIZE, "k", "b", "r", "XQ","YQ","ZQ","OQ")

SF = M4*SQ;
M1Q = SQ*inv(S1);
 %Proof that M = M4*M1Q*M1
 M_FINALPROOF = M4*M1Q*M1
 
 %If the value of the following function is 1, then that means that those
 %matrices are the same.
 %As the result is 1, that shows that both matrices represent the same
 %total transformation of exercise 4.4.3 and 4.6.1
 is_equal(M_FINALPROOF,M_TOTAL,0.001);