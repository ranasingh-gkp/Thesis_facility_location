clc
clear

customer_location = 'customer_location.xlsx';
facility_location = 'facility_location.xlsx';

Nc=31; % number of customer
Nh=50;  % number of Hub

Cposition = xlsread(customer_location)
%Cposition=unifrnd(1,100,Nc,2);
%Hposition=unifrnd(1,100,Nh,2);
Hposition= xlsread(facility_location)

dis=zeros(Nc,Nh);

for c=1:Nc
    for h=1:Nh
        dis(c,h)=norm(Cposition(c,:)-Hposition(h,:),2);
    end
end

demands = 'demands.xlsx';
demand=xlsread(demands)
%demand=randi([10 500],Nc,1);
% capacity=randi([10 500],Nh,1);


DisCost=22/40000;
FixCosts = 'FixCosts.xlsx';
FixCost=xlsread(FixCosts)
%FixCost=randi([2000 10000],1,Nh);




save data