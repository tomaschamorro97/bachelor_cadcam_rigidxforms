function [R]=quat_to_rot( e,th )
% Prof. Oscar Ruiz Salguero 25-02-2017
% This function builds the rotation R SO(3) 3x3 matrix dictated by 
% a quaternion q=[e,th]. 
% INPUTS:  
%  e              (3x1) rotation axis vector
%  th             (real number) rotation angle (radians) in CCW 
%                   direction with respect to axis vector e. 
% OUTPUTS:  
% R             SO(3) Rotation (3x3) matrix of real numbers, which 
%                performs rotations about axis e (passing by the origin) 
%                by an angle th (CCW wrt e)

global ROUND_ERROR

R = eye(3);

if is_equal( e, [0,0,0]', ROUND_ERROR )
    'ERROR quat_to_rot( ): Null rotation vector'
    keyboard
else
    e = e / norm(e);
    A0 = eye(3);
    [Af]=rotate_set_quaternion(e,th,A0);
    R = Af * inv( A0 );
end

end