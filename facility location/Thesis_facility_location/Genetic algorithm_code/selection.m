function [midpopulation]=selection(population, popsize,cost)
%SELECTÝON Summary of this function goes here
%   Detailed explanation goes here

cost=1./cost;
sumcost=sum(cost);
probs=cost/sumcost;
cprobs(1)=probs(1);

for i=2:popsize
    cprobs(i)=cprobs(i-1)+probs(i);
end

rs=unifrnd(0,1,[popsize,1]);

   midpopulation=population;
    
    for i=1:popsize
        idx=find(rs(i)<cprobs,1);   
        midpopulation(i,:)=population(idx,:);
    end


end

