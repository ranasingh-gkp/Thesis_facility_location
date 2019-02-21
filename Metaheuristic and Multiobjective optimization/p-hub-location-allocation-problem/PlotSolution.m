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

function PlotSolution(sol,model)

    N=model.N;
    X=model.X;
    Y=model.Y;

    x=sol.x;
    h=sol.h;
    
    xii=diag(x)';
    
    Hubs=find(xii==1);
    nHubs = numel(Hubs);
    Clients=find(xii==0);
    
    Colors = hsv(nHubs)*0.85;
    
    for i=1:N
        ColorIndex = find(Hubs==h(i));
        Color = Colors(ColorIndex,:); %#ok
        plot([X(i) X(h(i))],[Y(i) Y(h(i))],'k:','LineWidth',2,'Color',Color);
        hold on;
    end
    
    plot(X(Hubs),Y(Hubs),'ks',...
        'MarkerFaceColor','yellow',...
        'MarkerSize',16);
    
    plot(X(Clients),Y(Clients),'ko',...
        'MarkerFaceColor','white',...
        'MarkerSize',10);
    
    hold off;
    
    axis equal;

end