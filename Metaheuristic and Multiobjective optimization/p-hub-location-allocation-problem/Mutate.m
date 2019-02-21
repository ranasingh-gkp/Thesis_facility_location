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

function xhat2=Mutate(xhat1, model)

    xhat1=TurnOffUnusedHub(xhat1, model);
    
    Q=randi([1 7]);
    switch Q
        case 1, xhat2=SwapRows(xhat1);
        case 2, xhat2=SwapCols(xhat1);
        case 3, xhat2=SwapElements(xhat1);
        case 4, xhat2=SwapDiagElements(xhat1);
        case 5, xhat2=ReverseDiagElements(xhat1);
        case 6, xhat2=TurnOffHub(xhat1);
        case 7, xhat2=TurnOnHub(xhat1);
    end

end


function xhat2=SwapRows(xhat1)

    N=size(xhat1,1);
    
    i=randsample(N,2);
    
    i1=i(1);
    i2=i(2);
    
    xhat2=xhat1;
    xhat2([i1 i2],:)=xhat1([i2 i1],:);

end

function xhat2=SwapCols(xhat1)

    N=size(xhat1,2);
    
    i=randsample(N,2);
    
    i1=i(1);
    i2=i(2);
    
    xhat2=xhat1;
    xhat2(:,[i1 i2])=xhat1(:,[i2 i1]);

end

function xhat2=SwapElements(xhat1)

    [M, N]=size(xhat1);
    
    i=randi([1 M],1,2);
    j=randi([1 N],1,2);
    
    i1=i(1);
    j1=j(1);
    
    i2=i(2);
    j2=j(2);
    
    xhat2=xhat1;
    xhat2(i1,j1)=xhat1(i2,j2);
    xhat2(i2,j2)=xhat1(i1,j1);
    
end

function xhat2=SwapDiagElements(xhat1)

    N=size(xhat1,1);
    
    i=randsample(N,2);
    
    i1=i(1);
    i2=i(2);
    
    xhat2=xhat1;
    xhat2(i1,i1)=xhat1(i2,i2);
    xhat2(i2,i2)=xhat1(i1,i1);

end

function xhat2=ReverseDiagElements(xhat1)

    N=size(xhat1,1);
    
    i=randsample(N,2);
    
    i1=min(i);
    i2=max(i);
    
    xhat2=xhat1;
    
    A=i1:i2;
    B=i2:-1:i1;
    for k=1:numel(A)
        xhat2(A(k),A(k))=xhat1(B(k),B(k));
    end

end

function xhat2=TurnOffHub(xhat1)

    xii = diag(xhat1);
    A = find(xii>=0.5);
    
    if ~isempty(A)
        i = randsample(A,1);
        xhat2 = xhat1;
        xhat2(i,i) = xhat1(i,i)/2;
    else
        xhat2=SwapDiagElements(xhat1);
    end

end

function xhat2=TurnOnHub(xhat1)

    xii = diag(xhat1);
    A = find(xii<0.5);
    
    if ~isempty(A)
        i = randsample(A,1);
        xhat2 = xhat1;
        xhat2(i,i) = xhat1(i,i)*2;
    else
        xhat2=SwapDiagElements(xhat1);
    end

end

function xhat2=TurnOffUnusedHub(xhat1, model)

    sol=ParseSolution(xhat1,model);
    
    xhat2 = xhat1;
    for h=sol.Hubs
        if sum(sol.x(h,:)) <= 2
            xhat2(h,h) = xhat1(h,h)/2;
            break;
        end
    end
    
end
