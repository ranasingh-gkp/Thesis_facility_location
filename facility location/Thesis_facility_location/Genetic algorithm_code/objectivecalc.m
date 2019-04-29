function [ cost ] = objectivecalc( supply,cities, popsize, population,transcost,fixcost,dist,cusdemand)
%OBJECTÝVE Summary of this function goes here

for i=1:popsize
    
    for j=1:size(supply,1)
        if population(i,j)==1
            sumfix(i,j)=population(i,j).*fixcost(j);
        end
    end
end

dist=dist';
for i=1:size(supply,1)
    for j=1:size(cities,1)
        transcost2(i,j)=transcost(i,j).*dist(j,i);
     end
end

cusdemand=cusdemand';

for i=1:size(supply,1)
    for j=1:size(cities,1)
        transcost3(i,j)=transcost2(i,j).*cusdemand(j,i);
     end
end

res = zeros(popsize,1);
for i=1:popsize
    aratop = 0;
    x=find(population(i,:)==1);
    if isempty(x)
        aratop = 10000000;
    else    
        for j=1:20
            dummy=min(transcost3([x],j));
            aratop = aratop+dummy ;
        end
    end
    res(i) = aratop;
end
    
for i=1:popsize
    cost1(i)=sum(sumfix(i,:));
    
end
cost=cost1'+res;
end






    
    
    
    



