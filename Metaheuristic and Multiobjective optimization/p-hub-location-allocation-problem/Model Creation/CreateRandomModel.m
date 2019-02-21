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

function model=CreateRandomModel(N)

    Pmin=ceil(0.15*N);
    Pmax=ceil(0.20*N);
    
    P=randi([Pmin Pmax]);

    M = ceil(sqrt(N));
    
    Xmin=0;
    Xmax=100;
    xx = linspace(Xmin,Xmax,M);
    dx = (Xmax-Xmin)/M;
    
    Ymin=0;
    Ymax=100;
    yy = linspace(Ymin,Ymax,M);
    dy = (Ymax-Ymin)/M;
    
    [XX, YY]=meshgrid(xx,yy);
    XX=XX(:)';
    YY=YY(:)';
    
    A=randsample(numel(XX),N)';
    X=XX(A) + 0.2*dx*randn(size(A));
    Y=YY(A) + 0.2*dy*randn(size(A));

    d=zeros(N,N);
    for i=1:N-1
        for j=i+1:N
            
            d(i,j)=sqrt((X(i)-X(j))^2+(Y(i)-Y(j))^2);
            
            d(j,i)=d(i,j);
            
        end
    end
    
    CostPerDistanceUnit=10;
    
    c=round(CostPerDistanceUnit*d);
    
    alpha=0.7;
    
    rmin=10;
    rmax=50;
    r=randi([rmin rmax],N,N);
    r=r-diag(diag(r));
    
    rc=r.*c;
    SumRC=sum(rc(:));
    
    fmean=SumRC/P;
    fmin=round(0.8*fmean);
    fmax=round(1.2*fmean);
    f=randi([fmin fmax],1,N);
    
    model.N=N;
    model.P=P;
    model.X=X;
    model.Y=Y;
    model.d=d;
    model.c=c;
    model.alpha=alpha;
    model.r=r;
    model.f=f;
    
end