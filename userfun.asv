function [M,H] = userfun(i,M,Length,H)
% Controls the behavior of the users but zombie and non-zombie
% Random Walker movement
% Create two vectors
rx  = [M(i,1)-1,M(i,1),M(i,1)+1];
ry  = [M(i,2)-1,M(i,2),M(i,2)+1];

% Create the non extreme conditions that is make sure that the people are
% defined in the space in which we want them to move eliminate
% possibilities that would send them outside of the box or something weird
rx  = rx((rx >= 0) & (rx <= Length));
ry  = ry((ry >= 0) & (ry <= Length));

% Create all the possible permutations that they can move across
[px,py] = meshgrid(rx, ry);
pairs = [px(:) py(:)];

% Randomly select a movement to take by selecting across a normal
% distribution due to the fact that the rand function is not non-uniform
% thus by adding this distribution we have added drift to our simulation
dist1 = rand();
if dist1 > .843
    rm = randi(length(pairs),1);
elseif dist1 < .115
    rm = randi(length(pairs),1);
else
    rm = randi(length(pairs),1);
end

M(i,5) = pairs(rm,1); % Store new random x point
M(i,6) = pairs(rm,2); % Store new random y point

if M(i,4) == 0
    % You're a zombie free ride
    M(i,7) = 0;
else
    % Check for zombies
    Z = ismembc(M(:,1:2),pairs);
    
    % You can't infect yourself so set that to 0,0
    Z(i,:) = [0,0];
    
    % Are there zombies near the user
    zombieprob = sum(((Z(:,1) + Z(:,2) == 2) & (M(:,4) == 0)));

    % Compute if they can infect that user
    M(i,3) = (M(i,3) - zombieprob);
    
    % Check to see if they ran out of ammo if they do use life points
    if M(i,3) > 0
        % user survived check for supplies
        M(:,8) = M(:,8) + (Z(:,1) + Z(:,2) == 2 & (M(:,4) == 0)) * -1;
    else
        M(i,7) = M(i,7) + M(i,3);
        if M(i,7) > 0
            % user survived check for supplies
            M(:,8) = M(:,8) + (Z(:,1) + Z(:,2) == 2 & (M(:,4) == 0)) * -1;
            M(i,3) = 0;
        elseif  M(i,7) == 0
            % The user died
            H(M(i,1)+1,M(i,2)+1) = H(M(i,1)+1,M(i,2)+1) + 1;
            M(i,4) = 0;
            M(i,7) = 0;
            M(i,3) = 0;
        else
            % the user died
            H(M(i,1)+1,M(i,2)+1) = H(M(i,1)+1,M(i,2)+1) + 1;
            M(i,4) = 0;
            M(i,7) = 0;
            M(i,3) = 0;
        end
    end
end
end

