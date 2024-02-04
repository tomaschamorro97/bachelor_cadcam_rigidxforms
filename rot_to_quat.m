function [e,th]=rot_to_quat( R )
% Oscar Ruiz 05-03-2016
% This function extracts the equivalent rotation axis and angle
% implicit in a Special Orthogonal matrix R in 3D space 
% (i.e. R is SO(3).  
% 

global ROUND_ERROR

e= [ 0 0 0 ]';
th = 0;

if  is_SOn( R )
    A0 = eye( 3 );
    Af = R * A0;  
else    
    'error rot_to_quat( R ): R is not a rotation'
    keyboard  
end

% Calculation of Rotation Axis 'e' and angle 'th'
[eVects,eVals]= eig(R);
eVals = diag( eVals );
axis_index = find( abs(eVals(:)-1.0) < ROUND_ERROR ) ;

switch (axis_index)
    case {1} 
        th = acos(real(eVals(2)));
    case {2} 
        th = acos(real(eVals(1)));
    case {3} 
        th = acos(real(eVals(1)));
    otherwise
        'error rot_to_quat( ): no eigenvalue equal to 1.0'
        keyboard
end

e = eVects(1:3,axis_index);
e = e/norm(e);

% Definition of sign for rotation angle 'th'
[ A_tempo ]=rotate_set_quaternion(e, th, A0);

if not( is_equal( A_tempo, Af , ROUND_ERROR ) )
    [ A_tempo ]=rotate_set_quaternion( e, -th, A0 );    
    if is_equal( A_tempo, Af  , ROUND_ERROR )
        th = -th;    
    else
        'error rot_to_quat( ): neither TH nor -TH'
        keyboard        
    end    
end
end
