function [x,y]=distance(a,b,c)
 
    position_A = [0,0];
    position_B = [0,1.8];
    position_C = [1.2,1.8];
    distanceA = a;
    distanceB = b;
    distanceC = c;
    %  a,b,c의 거리를 구해 tag의 좌표 구하기 
    % double A = ( (-2*position_self.x) + (2*position_B.x) );
    A = ( (-2*position_A(1)) + (2*position_B(1)) );
%   double B = ( (-2*position_self.y) + (2*position_B.y) );
    B = ( (-2*position_A(2)) + (2*position_B(2)) );
%   double C = (range_self*range_self) - (range_B*range_B) - (position_self.x*position_self.x) + (position_B.x*position_B.x) - (position_self.y*position_self.y) + (position_B.y*position_B.y);
    C = (distanceA*distanceA) - (distanceB*distanceB) - (position_A(1)*position_A(1)) + (position_B(1)*position_B(1)) - (position_A(2)*position_A(2)) + (position_B(2)*position_B(2));
%   double D = ( (-2*position_B.x) + (2*position_C.x) );
    D = ( (-2*position_B(1)) + (2*position_C(1)) );
%   double E = ( (-2*position_B.y) + (2*position_C.y) );
    E = ( (-2*position_B(2)) + (2*position_C(2)) );
%   double F = (range_B*range_B) - (range_C*range_C) - (position_B.x*position_B.x) + (position_C.x*position_C.x) - (position_B.y*position_B.y) + (position_C.y*position_C.y);
    F = (distanceB*distanceB) - (distanceC*distanceC) - (position_B(1)*position_B(1)) + (position_C(1)*position_C(1)) - (position_B(2)*position_B(2)) + (position_C(2)*position_C(2));
    x = double((C*E-F*B) / (E*A-B*D));
    y = double((C*D-A*F) / (B*D-A*E));


end

