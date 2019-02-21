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

function PlotSolution(sol,model)

    n=model.n;

    x=sol.x;
    y=sol.y;
    xl=sol.xl;
    yl=sol.yl;
    xu=sol.xu;
    yu=sol.yu;
    
    xin=sol.xin;
    yin=sol.yin;
    xout=sol.xout;
    yout=sol.yout;
    
    XMIN=sol.XMIN;
    YMIN=sol.YMIN;
    XMAX=sol.XMAX;
    YMAX=sol.YMAX;
    
    Colors=hsv(n);
    
    for i=1:n
        
        Color=Colors(i,:);
        White=[1 1 1];
        
        Color=0.4*Color+0.6*White;
        
        X=[xl(i) xu(i) xu(i) xl(i)];
        Y=[yl(i) yl(i) yu(i) yu(i)];
        fill(X,Y,Color);
        hold on;
        
        text(x(i),y(i),num2str(i),...
            'FontSize',20,...
            'FontWeight','bold',...
            'HorizontalAlignment','center',...
            'VerticalAlignment','middle');
    end
    
    plot(xin,yin,'ko','MarkerSize',8);
    plot(xout,yout,'ko','MarkerSize',8,'MarkerFaceColor','black');
    
    plot([XMIN XMAX XMAX XMIN XMIN],[YMIN YMIN YMAX YMAX YMIN],'r-.');
    
    axis equal;
    grid on;

    xlim([0 model.W]);
    ylim([0 model.H]);
    
    hold off;

end