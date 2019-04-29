function [ midpopulation ] = crossoveract( midpopulation, popsize, probcross, d )
%CROSSOVERACT Summary of this function goes here
%   Detailed explanation goes here

pairs=randperm(popsize);

for i=1:popsize/2
    
        parent1idx=pairs(2*i-1);
        parent2idx=pairs(2*i);
        parent1=midpopulation(parent1idx,:);
        parent2=midpopulation(parent2idx,:);
            
        rs=unifrnd(0,1);
        
        if rs<probcross
            
            cpoint=unidrnd(d-1);
            dummy=parent1(cpoint+1:end);
            parent1(cpoint+1:end)=parent2(cpoint+1:end);
            parent2(cpoint+1:end)=dummy;

            midpopulation(parent1idx,:)=parent1;
            midpopulation(parent2idx,:)=parent2;
        end
end

end

