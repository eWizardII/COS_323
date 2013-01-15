% This is the sub main function which when called will simulate a zombie
% attack situation
% Princeton COS323
% Final Project
function [Su,Zo,S,Sui,Zoi] = mainzombie(N,T,Length,infected,ammo,randoammo,grapheron)
% N is number of persons
% t is time t to run in arbitrary units
% Length in arbitrary units
% Infected is the amount of persons who will start in the infected state
% ammo defines how much ammo each user should start with
% randoammo is a boolean sets a random amount of ammo to be assigned to
% each user up to the limit set by ammo

% Enlarge the display screen
if grapheron == 1
h=figure;
set(h,'Position',[1 1 1920 1080]);
end

% Generate persons matrix
M = zeros(N,8);

% Survivors
S = zeros(1,2);

% Infection Heat Map
H = zeros(Length+1,Length+1);

% Initial set up
for i = 1:N
    
    M(i,1) = randi(Length,1,1);     % random initial x
    M(i,2) = randi(Length,1,1);     % random initial y
    
    % Make the probability of infection normally distributed
    dist0 = rand();
    if dist0 > .843
        M(i,4) = randn() <= infected;
    elseif dist0 < .115
        M(i,4) = randn() <= infected;
    else
        M(i,4) = randn() <= infected;
    end
    
    if randoammo == 0
        M(i,3) = ammo * M(i,4);             % initial ammo rounds
    else
        M(i,3) = randi(ammo,1) * M(i,4);    % assign random ammo rounds
    end
    
    % user health is 1, because if you are bitten you are converted into
    % a zombie state of course you could modify this but we weren't trying
    % to explore that property, so we have it hardcoded here as the
    % constant vaule 1
    M(i,7) = 1 * M(i,4);
end

for t = 1:T
    
    % Determine subject behaviors and interactions in this loop
    for i = 1:length(M(:,1))
        [M,H] = userfun(i,M,Length,H);
    end
    
    % Transfer movement vectors
    M(:,1) = M(:,5);
    M(:,2) = M(:,6);
    
    % SZR Model Implementaiton
    time=(0:.1:N/10);
    beta= .05;
    zeta = 5;
    alpha = .05*ammo;
    % Set initial conditions
    Param=[S(1,1) N-S(1,1) 0];
    options=[ ];
    [~,Stat]=ode15s(@szrfun, time, Param, options, beta, zeta,alpha,N);
    Sur=Stat(:,1);
    Zom=Stat(:,2);
    
    % Collect the data on the dynamics of the system, the users who are
    % zombies and who aren't, etc.
    S(t,1) = sum(M(:,4));
    S(t,2) = sum(M(:,4)==0);
    S(t,3) = sum(M(:,3));
    
    % Plot results
    if grapheron == 1
    grapher(M,H,T,N,Sur,Zom,Length,S,t);
    end
    
    % Remove the dead people
    M(any(M(:,8)<0,2),:)=[];
end
hold on;
% Grab the vaules from GN solver for graphing
if grapheron == 1
gsfun(S);
end

% Return the number that survived and the number that died
Su = S(t,1);
Zo = S(t,2);

% Return back intial starting conditions
Sui = S(1,1);
Zoi = S(1,2);
end