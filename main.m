% Generate random
function [] = main(N,t,Length,Infected)
% N is number of persons
% t is time t to run
% Len in arbitrary units

% Generate life matrix
M = zeros(N,6);

% Initial set up

for i = 1:N
    M(i,1) = randi(Length,1,1); % random initial x
    M(i,2) = randi(Length,1,1); % random initial y
    M(i,3) = rand(1); % random immunity vaule
    M(i,4) = rand() < Infected; % is the user infected or not ( 0 - Not Infected, 1 - Infected)
    
    % Random Walker movement
    % Create two vectors
    
    rx  = [M(i,1)-1,M(i,1),M(i,1)+1];
    ry  = [M(i,2)-1,M(i,2),M(i,2)+1];
    
    % Generate random selection vector
    if ((M(i,1)-1 < 0) || (M(i,2)-1 < 0))
        randv = randi(3,2,2);
    elseif ((M(i,1)+1 > Length) || (M(i,2)-1 > Length))
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

for T = 2:t
    
    for i = 1:N
        % Random Walker movement
        % Create two vectors
        rx  = [M(i,1)-1,M(i,1),M(i,1)+1];
        ry  = [M(i,2)-1,M(i,2),M(i,2)+1];
        
        % Generate random selection vector
        if ((M(i,1)-1 < 0) || (M(i,2)-1 < 0))
            randv = randi(3,2,2);
        elseif ((M(i,1)+1 > Length) || (M(i,2)-1 > Length))
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
    
    scatter(M(:,1),M(:,2),50,M(:,4),'filled');
    xlim([0 Length]);
    ylim([0 Length]);
    pause(.0005)
    
    
end

end