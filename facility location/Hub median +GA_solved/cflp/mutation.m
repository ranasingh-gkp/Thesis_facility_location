function  mutpop=mutation(mutpop,pop,data,nmut,popsize,nvar)


for n=1:nmut
    
i=randi([1 popsize]);  

p=pop(i).x;

j=randi([1 nvar]);

p(j)=1-p(j);

mutpop(n).x=p;
mutpop(n)=fitness(mutpop(n),data);

end

end