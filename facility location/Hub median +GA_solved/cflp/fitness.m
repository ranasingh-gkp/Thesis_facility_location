function sol=fitness(sol,data)

Nc=data.Nc;
dis=data.dis;
FixCost=data.FixCost;
DisCost=data.DisCost;
demand=data.demand;
capacity=data.capacity;
unusedCost=data.unusedCost;

x=sol.x;


d=zeros(Nc,1);
IDX=zeros(Nc,1);
Rcap=capacity;%Remained Capacity
Rcap=Rcap.*x;






for i=1:Nc
    
    q=Rcap-demand(i);
    q(q<0)=0;
    x2=x.*q;
    
    [d(i),IDX(i)]=min(dis(i,:)./x2);
    Rcap(IDX(i))=Rcap(IDX(i))-demand(i);
end


Z=sum(x.*FixCost)+sum(d*DisCost)+sum(unusedCost*Rcap);



sol.fit=Z;
sol.x=x;
sol.info.d=d;
sol.info.IDX=IDX;
sol.info.Rcap=Rcap;





end