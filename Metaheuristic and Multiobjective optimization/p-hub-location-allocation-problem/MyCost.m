%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPAP110
% Project Title: Hub Location Allocation using PSO in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function [z, sol]=MyCost(xhat,model)

    sol=ParseSolution(xhat,model);

    w1=5;
    w2=1;
    
    z=w1*sol.SumOCR+w2*sol.SumXF;

end