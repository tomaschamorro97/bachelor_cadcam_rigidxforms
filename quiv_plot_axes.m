function []=quiv_plot_axes(coords, L, A, B, C,label_X,label_Y,label_Z,label_O)
% Prof.Oscar RUiz Salguero  13-02-2018 
%
% This function is a "quiver()" - based one to plot 3 vectors pivoted
% at an origin, with prescribed length and labels. This function seeks
% to be faster than the old plt_axes_str() and because of this reason
% this function does not, at this time, use the axes color.

% CAD CAM CAE LAboratory at EAFIT University. .
% This function draws a coordinate system, with controlable size
% and labels.
% INPUTS
% cords:	A coordinate system (3x4, cartesian) or (4x4, homogeneous) 
%           in this order [X,Y,Z,O].
% L:        scale factor (real number) 
% A, B,C:	colors for the X,Y,Z axes, respectively.
% label_x,label_y,label_z,label_o: labels for X,Y,Z axes and Origin.

X_ =1;
Y_ =2;
Z_ =3;
ORIG_ = 4;


Vx=coords(1:3,1);
Vy=coords(1:3,2);
Vz=coords(1:3,3);
O=coords(1:3,4);

u = L*[Vx(1) Vy(1) Vz(1)]';
v = L*[Vx(2) Vy(2) Vz(2)]';
w = L*[Vx(3) Vy(3) Vz(3)]';

OX = ones(3,1)*coords(X_,ORIG_);
OY = ones(3,1)*coords(Y_,ORIG_);
OZ = ones(3,1)*coords(Z_,ORIG_);

TipX = O + L * Vx;
TipY = O + L * Vy;
TipZ = O + L * Vz;

quiver3(OX,OY,OZ,u,v,w)

axis equal

text( O(X_), O(Y_), O(Z_) ,label_O )
text( TipX(X_), TipX(Y_), TipX(Z_), label_X )
text( TipY(X_), TipY(Y_), TipY(Z_), label_Y )
text( TipZ(X_), TipZ(Y_), TipZ(Z_), label_Z )


end

