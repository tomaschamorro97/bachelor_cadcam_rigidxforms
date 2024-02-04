
function [Set_f]=rotate_set_quaternion(e,th,Set_0)
% Oscar Ruiz 29-08-2015
% Function that rotates a mixed set of vectors or points
% around the axis 'e' crossing the origin by an angle 'theta'.
% This function must correctly handle either cartesian or
% homogeneous points / vectors in the data set 'S0'
% (and produce 'Sf' accordingly).
% e: (3x1) non unitary vector being the axis of rotation
% of the quaternion, anchored in the origin.
% theta: angle of rotation, positiv in the CCW orientation
% with respect to 'e'.
% S0: (4x_) or (3x_) matrix with a sequence of points
% or vectors mixed in arbitrary order. S0 is either
% homogeneous or cartesian.
% Sf: (4x_) or (3x_) the rotated version of S0.
% Note: the function must exactly keep the identity of
% points or vectors of S0 in Sf. It also must keep their
% cartesian or homogenoeus form.
% Use the following quaternion form:
% pf=po+(2*F(theta)*(e1 x po))+(2*e1 x (e1 x po))
% e: unitary axis of rotation
% theta: rotation angle in radians (CCW w.r.t. 'e')
% e1: sin(theta /2)*e
% F(theta):cos(theta /2 )

[ N_items ] = size(Set_0 , 2);
Set_f = Set_0;

if( norm(e) < 0.001 )
    'error rotate_set_quaternion(): NULL quaternion axis'
    keyboard
else
    e=e/norm(e);
end

for i = 1 : N_items
    p0 = Set_0( 1:3 , i );
    F = cos(th/2);
    e1 = sin(th/2)*e;
    pf = p0 + 2*F*cross( e1 , p0 ) + 2*cross( e1 , cross( e1 , p0 ));
    Set_f(1:3,i) = pf ;
end



