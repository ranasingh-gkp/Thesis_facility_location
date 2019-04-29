function sol=fitness(sol,data)

Nc=data.Nc;
dis=data.dis;
FixCost=data.FixCost;
DisCost=data.DisCost;

x=sol.x;


d=zeros(Nc,1);
IDX=zeros(Nc,1);

for i=1:Nc
    [d(i),IDX(i)]=min(dis(i,:)./x);
end


Z=sum(x.*FixCost)+sum(d*DisCost);



sol.fit=Z;
sol.x=x;
sol.info.d=d;
sol.info.IDX=IDX;






end