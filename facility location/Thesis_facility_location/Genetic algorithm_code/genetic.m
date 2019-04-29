function [ bestsupply bestvalue costiter cost idx t] = genetic( cities,supply,popsize,probcross,probmut,iteration,transcost,fixcost,dist,cusdemand)
%GENETÝC Summary of this function goes here
%   Detailed explanation goes here
tic
d=size(supply,1);
population=randi([0 1],popsize,d);
cost=zeros(popsize,1);
bestvalue=1000000;

cost  = objectivecalc( supply,cities, popsize, population,transcost,fixcost,dist,cusdemand);   

maxiter = 1000;
iter = 0;

while(iter < maxiter)
    [midpopulation]=selection(population, popsize,cost);
    [ midpopulation ] = crossoveract( midpopulation, popsize, probcross, d );
    population = mutationact( midpopulation, popsize, d, probmut );

    cost  = objectivecalc( supply,cities, popsize, population,transcost,fixcost,dist,cusdemand);

    for i=1:iteration
    
        if min(cost)<bestvalue
            bestvalue=min(cost);
            idx=find(cost==bestvalue);
            bestsupply=population(idx,:);
        end
    
        costiter(iteration)=bestvalue;
    end
 
    
    iter = iter + 1;
end

t=toc;

end










