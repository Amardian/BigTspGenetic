% Programmer :  Mahmoud Alimoradi
% Email : mahmoud.alimoradi@yahoo.CreateModel
% Genetic Algorithm (GA) for TSP problem ( Traveler samleman Problem)
% ACO developed for huge count of cities( 10000 cities ) 
% phone : 00989364656419


% ___________________________________________________________________________________________




clc
clear
close all
format shortG


%% Insert Data

data=InsertData();


%% parametres setting


npop=64;     % number of population

pc=1;       % percent of crossover
ncross=2*round(npop*pc/2);  % number of crossover offspring

pm=0.8;        %  percent of mutation
nmut=round(npop*pm);  % number of mutation offspring

maxiter=1000;



data.npop=npop;
data.ncross=ncross;
data.nmut=nmut;
data.maxiter=maxiter;

%% initialization
tic

[pop,emp]=CreateInitialPopulation(data);


%% main loop
BEST=zeros(maxiter,1);
MEAN=zeros(maxiter,1);

for iter=1:maxiter
    
    % crossover
    crosspop=repmat(emp,ncross,1);
    crosspop=crossover(crosspop,pop,data);
    
    % mutation
    mutpop=repmat(emp,nmut,1);
    mutpop=mutation(mutpop,pop,data);
    
    
    % Merged
    [pop]=[pop;crosspop;mutpop];
    
    
   

    % Sorting
    [value,index]=sort([pop.fit]);
    pop=pop(index);
    gpop=pop(1);
    
    % Select
    pop=pop(1:npop);
    

    
    BEST(iter)=gpop.fit;
    MEAN(iter)=mean([pop.fit]);
    
    disp([' Iter = ' num2str(iter)  ' BEST = ' num2str(BEST(iter))])
    
    
    
    
end

toc

figure(1)
semilogy(BEST,'r')
hold on
semilogy(MEAN,'b')

xlabel('Iteration ')
ylabel(' Fitness ')
legend('BEST','MEAN')
title('FOA')



