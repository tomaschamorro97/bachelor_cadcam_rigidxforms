function r = is_equal( a , b , error_dist )

% Prof. Oscar Ruiz Salguero
% 05 03 2016
% This function takes as imput 2 matrices or scalars and
% decides  whether or not they are the same cell - wise
% (within a deviation error).
% INPUTS:
% a,b   : scalars, vectors or matrices to be compared.
% error_dist:   real number. expresses the tolerance between
%               data a vs. b beyond which a and b are considered
%               as not equal.
% OUTPUTS:
% r:      boolean result telling whether or not a and b can be
%         considered as equal.


if ( size(a,1) == size(b,1) ) & (  size(a,2) == size(b,2) ) 
    if ( max(max(abs( a - b ))) > error_dist )
       r = false;
    else   
       r = true;
    end
else
    'ERROR: is_equal( ): incompatible data dimensions'
    keyboard
end
