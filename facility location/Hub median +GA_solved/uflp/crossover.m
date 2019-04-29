function  crosspop=crossover(crosspop,pop,data,ncross,nvar)

f=[pop.fit];
f=1./f;
f=f./sum(f);
f=cumsum(f);

for n=1:2:ncross

    i1=find(rand<=f,1,'first');
    i2=find(rand<=f,1,'first');
    

p1=pop(i1).x;
p2=pop(i2).x;

j=randi([1 nvar-1]);


o1=[p1(1:j) p2(j+1:end)];
o2=[p2(1:j) p1(j+1:end)];



crosspop(n).x=o1;
crosspop(n)=fitness(crosspop(n),data);

crosspop(n+1).x=o2;
crosspop(n+1)=fitness(crosspop(n),data);
end

end



















