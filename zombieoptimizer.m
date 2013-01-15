function [table] = zombieoptimizer()
table = zeros(20,3);
parfor i = 1:1:20
[Su,Zo,~] = mainzombie(1000,2500,25,i*.05,1,0,0);
table(i,:) = [i Su Zo];
end
end