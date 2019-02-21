%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPAP109
% Project Title: Facility Layout Design using PSO in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function sol1=CreateRandomSolution(model)

    n=model.n;
    
    sol1.xhat=rand(1,n);
    sol1.yhat=rand(1,n);
    sol1.rhat=rand(1,n);

end