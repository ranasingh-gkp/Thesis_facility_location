function [ midpopulation ] = mutationact( midpopulation, popsize,d, probmut )
%MUTATÝONACT Summary of this function goes here
%   Detailed explanation goes here

rs=unifrnd(0,1,[popsize,d]);

for i=1:popsize
    for j=1:d
        if(rs(i,j)<probmut)
           if midpopulation(i,j)==1
               midpopulation(i,j)=0;
           else
               midpopulation(i,j)=1;
           end
        end 
    end

end

end

