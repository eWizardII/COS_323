% Generate random
function [M] = main(N,t,Length,Infected)
% N is number of persons
% t is time t to run
% Len in arbitrary units

% Generate life matrix
M = zeros(N,6);

% Initial set up

for i = 1:N
    M(i,1) = randi(Length,1,1); % random initial x
    M(i,2) = randi(Length,1,1); % random initial y
    M(i,3) = rand(1); % random immunity/recovery rate vaule
    M(i,4) = rand() < Infected; % is the user infected or not ( 0 - Not Infected, 1 - Infected)
    
    % Random Walker movement
    % Create two vectors
    
    rx  = [M(i,1)-1,M(i,1),M(i,1)+1];
    ry  = [M(i,2)-1,M(i,2),M(i,2)+1];
    
    % Generate random selection vector
    if ((M(i,1)-1 < 0) || (M(i,2)-1 < 0) || (M(i,1) == 0) || (M(i,1) == Length))
        randv = randi([2 3],1,2);
    elseif ((M(i,1)+1 > Length) || (M(i,2)+1 > Length)  || (M(i,2) == 0) || (M(i,2) == Length))
        randv = randi(2,1,2);
    else
        randv = randi(3,1,2);
    end
    
    M(i,5) = rx(randv(1)); % Store new random x point
    M(i,6) = ry(randv(2)); % Store new random y point
end

% Transfer movement vectors
M(:,1) = M(:,5);
M(:,2) = M(:,6);

% Infection matrix
I = zeros(N,1);
% Infection Heat Map
H = zeros(Length+1,Length+1);

for T = 2:t
    
    for i = 1:N
        
        % Random Walker movement
        % Create two vectors
        rx  = [M(i,1)-1,M(i,1),M(i,1)+1];
        ry  = [M(i,2)-1,M(i,2),M(i,2)+1];
        % Generate random selection vector and calculate infection status
        if ((M(i,1)-1 < 0) || (M(i,2)-1 < 0) || (M(i,1) == 0) || (M(i,1) == Length))
            randv = randi([2 3],1,2);
            % Generate all possible combinations
            [px,py] = meshgrid(rx(2:3), ry(2:3));
            pairs = [px(:) py(:)];
            % Check for which users are in cells near the main user
            Z = ismembc(M(:,1:2),pairs);
            
            % You can't infect yourself so set that to 0,0
            Z(i,:) = [0,0];
            
            % Compute if they can infect that user
            I(i) = (I(i) + (sum(((Z(:,1) == Z(:,2)))*rand() > M(i,3)) > 0)) > 0;
            
            
        elseif ((M(i,1)+1 > Length) || (M(i,2)+1 > Length) || (M(i,2) == 0)  || (M(i,2) == Length))
            randv = randi(2,1,2);
            % Generate all possible combinations
            [px,py] = meshgrid(rx(1:2), ry(1:2));
            pairs = [px(:) py(:)];
            % Check for which users are in cells near the main user
            Z = ismembc(M(:,1:2),pairs);
            
            % You can't infect yourself so set that to 0,0
            Z(i,:) = [0,0];
            
            % Compute if they can infect that user
            I(i) = (I(i) + (sum(((Z(:,1) == Z(:,2)))*rand() > M(i,3)) > 0)) > 0;
            
        else
            randv = randi(3,1,2);
            % Generate all possible combinations
            [px,py] = meshgrid(rx(1:3), ry(1:3));
            pairs = [px(:) py(:)];
            % Check for which users are in cells near the main user
            Z = ismembc(M(:,1:2),pairs);
            
            % You can't infect yourself so set that to 0,0
            Z(i,:) = [0,0];
            
            % Compute if they can infect that user
            I(i) = (I(i) + (sum(((Z(:,1) == Z(:,2)))*rand() > M(i,3)) > 0)) > 0;
            
        end
        
        % Add to heat map infection counter
        rx
        ry
        H(M(i,1)+1,M(i,2)+1) = H(M(i,1)+1,M(i,2)+1) + I(i);
        
        M(i,5) = rx(randv(1)); % Store new random x point
        M(i,6) = ry(randv(2)); % Store new random y point
    end
    
    % Transfer movement vectors
    M(:,1) = M(:,5);
    M(:,2) = M(:,6);
    
    % Transfer infection matrix
    M(:,4) = (I + M(:,4)) > 0;
    
    subplot(2,2,1);
    scatter(M(:,1),M(:,2),50,M(:,4));
    xlim([0 Length]);
    ylim([0 Length]);
    hold on
    
    
    subplot(2,2,2);
    HeatMap(H);
    xlim([1 Length+1]);
    ylim([1 Length+1]);
    
    pause(.0005)
end
hold off
end