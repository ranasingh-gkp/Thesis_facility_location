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

function newsol=Mutate(sol,Vars)

    newsol=sol;

    sigma=0.1*(Vars.xhat.Max-Vars.xhat.Min);
    j=randi([1 Vars.xhat.Count]);
    dxhat=sigma*randn;
    newsol.xhat(j)=sol.xhat(j)+dxhat;
    newsol.xhat=max(newsol.xhat,Vars.xhat.Min);
    newsol.xhat=min(newsol.xhat,Vars.xhat.Max);

    sigma=0.1*(Vars.yhat.Max-Vars.yhat.Min);
    j=randi([1 Vars.yhat.Count]);
    dyhat=sigma*randn;
    newsol.yhat(j)=sol.yhat(j)+dyhat;
    newsol.yhat=max(newsol.yhat,Vars.yhat.Min);
    newsol.yhat=min(newsol.yhat,Vars.yhat.Max);
    
end
