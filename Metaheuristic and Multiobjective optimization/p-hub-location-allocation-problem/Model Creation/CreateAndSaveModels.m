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

N=[20 30 40];

nProblem=numel(N);

for k=1:nProblem

    model=CreateRandomModel(N(k));

    ModelName=['phlap_' num2str(model.N)];

    save(ModelName,'model');

end