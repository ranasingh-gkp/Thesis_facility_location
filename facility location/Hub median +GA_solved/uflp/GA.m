clc
clear
close all
format shortG

%% parameters setting

data=load('data.mat');

nvar=data.Nh;



popsize=40;
maxiter=100;

pc=0.6;
ncross=2*round((popsize*pc)/2);

pm=1-pc;
nmut=round(popsize*pm);



%% initial population algorithm
tic

emp.x=[];
emp.info=[];
emp.fit=[];

pop=repmat(emp,popsize,1);


for i=1:popsize
  
    pop(i).x=randi([0 1],1,nvar);
    pop(i)=fitness(pop(i),data);
    
end

[value,index]=min([pop.fit]);
gpop=pop(index);







%% main loop algorithm

BEST=zeros(maxiter,1);
MEAN=zeros(maxiter,1);

for iter=1:maxiter

   % crossover
   crosspop=repmat(emp,ncross,1);
   crosspop=crossover(crosspop,pop,data,ncross,nvar);
   
   
   % mutation
   mutpop=repmat(emp,nmut,1);   
   mutpop=mutation(mutpop,pop,data,nmut,popsize,nvar);
   
   
   [pop]=[pop;crosspop;mutpop]; 
   
   [value,index]=sort([pop.fit]); 
   
   pop=pop(index);
   gpop=pop(1);
   pop=pop(1:popsize); 
    
   
BEST(iter)=gpop.fit;
MEAN(iter)=mean([pop.fit]);

disp([' Iter = ' num2str(iter)  ' BEST = ' num2str(BEST(iter))])



end


%% results algorithm

disp([ ' Best Solution = '  num2str(gpop.x)])
disp([ ' Best Fitness = '  num2str(gpop.fit)])
disp([ ' Time = '  num2str(toc)])


figure(1)
plot(BEST,'r')
hold on
plot(MEAN,'b')
xlabel('Iteration')
ylabel('Fitness')
legend('BEST','MEAN')

title('GA-Hub-Median')















