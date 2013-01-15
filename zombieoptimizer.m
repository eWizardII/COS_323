function [table] = zombieoptimizer(N,T,Length,ammo,randoammo,grapheron)
table = zeros(20,5);
parfor i = 1:1:20
[Su,Zo,~,Sui,Zoi] = mainzombie(N,T,Length,i*.05,ammo,randoammo,grapheron);
table(i,:) = [i Su Zo Sui Zoi];
disp(sprintf('iteration = %g', i));
end
end