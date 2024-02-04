function  [ result ] = is_SOn( R )
% Prof. Oscar Ruiz Salguero
% 05 03 2017
% This function takes as imput a matrix R and decides whether
% or not it is a Special Orthogonal matrix. R is Special Orthogomal
% if all these contidions are satisfied: 
% (a) is square, (b) R*R'=I, (c) R'*R=I, (d) det(R) = 1.0 .
% 

global ROUND_ERROR

[r,c]= size( ROUND_ERROR );
if (c==0)|(r==0)
    'error is_SOn(): ROUND_ERROR not initialized'
    keyboard
end

result = false ;
[rows,cols] = size( R );
if ( rows == cols )
    I1 = R * R' ;
    I2 = R' * R ;
    if   is_equal( I1 , eye( rows ) , ROUND_ERROR )     
        if is_equal( I2 , eye( rows ) , ROUND_ERROR )        
            if ( abs( det( R ) - 1 ) < ROUND_ERROR )
                result = true;
            end            
        end
    end    
end
end