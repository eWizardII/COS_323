% Princeton COS323
% Final Project
% Author: Solomon (sabiola), Daniel (dyeboah), Brandon (brhodes)
% This function calls the main function to determine the optimal amount of
% ammo to allocate to survive an attack
function [table] = zombieoptimizer(N,T,Length,ammo,randoammo,grapheron)
table = zeros(10,5);
parfor i = 1:1:10
[Su,Zo,~,Sui,Zoi] = mainzombie(N,T,Length,.8,i,randoammo,grapheron);
table(i,:) = [i Su Zo Sui Zoi];
disp(sprintf('ammo = %g', i));
end
end