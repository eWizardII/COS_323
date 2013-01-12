% Generate random
function [] = maininfection(N,T,Length,infected)
% N is number of persons
% t is time t to run
% Len in arbitrary units

% Generate persons matrix
M = zeros(N,8);

% Generate food matrix
F = zeros(N,2);

% Generate ammo matrix
A = zeros(N,2);

% Survivors
S = zeros(2,2);

% Initial set up

for i = 1:N
    M(i,1) = randi(Length,1,1); % random initial x
    M(i,2) = randi(Length,1,1); % random initial y
    
    F(i,1) = randi(Length,1,1); % random initial x
    F(i,2) = randi(Length,1,1); % random initial y
    
    A(i,1) = randi(Length,1,1); % random initial x
    A(i,2) = randi(Length,1,1); % random initial y
    

    M(i,4) = rand() <= infected; % is the user infected or not ( 0 - Not Infected, 1 - Infected)
    M(i,3) = 9 * M(i,4);                 % initial ammo 9 rounds    
    M(i,7) = 1 * M(i,4);       % user health 10 is for a single user * whether they are infected or not
end

for t = 1:T
    for i = 1:length(M(:,1))
        % Random Walker movement
        % Create two vectors
        
        rx  = [M(i,1)-1,M(i,1),M(i,1)+1];
        ry  = [M(i,2)-1,M(i,2),M(i,2)+1];
        
        % Create the non extreme conditions
        rx  = rx((rx >= 0) & (rx <= Length));
        ry  = ry((ry >= 0) & (ry <= Length));
        
        % Permutate
        [px,py] = meshgrid(rx, ry);
        pairs = [px(:) py(:)];
        
        % Randomly select a movement to take
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
            
            % Compute if they can infect that user
            M(i,3) = (M(i,3) - sum(((Z(:,1) + Z(:,2) == 2) & (M(:,4) == 0))));
            % Check to see if they ran out of ammo if they do use life points
            if M(i,3) > 0
                % user survived check for supplies
                M(:,8) = M(:,8) + (Z(:,1) + Z(:,2) == 2 & (M(:,4) == 0)) * -1;
                % Add health from food
                %Z = 0;
                %Z = ismembc(F(:,1:2),pairs);
                %M(i,7) = (M(i,7) + sum((Z(:,1) + Z(:,2) == 2)));
                % Add ammo
                %Z = 0;
                %Z = ismembc(A(:,1:2),pairs);
                %M(i,3) = (M(i,3) + sum((Z(:,1) + Z(:,2) == 2)));
            else
                M(i,7) = M(i,7) + M(i,3);
                if M(i,7) > 0
                    % user survived check for supplies
                    M(:,8) = M(:,8) + (Z(:,1) + Z(:,2) == 2 & (M(:,4) == 0)) * -1;
                    % Add health from food
                    %Z = 0;
                    %Z = ismembc(F(:,1:2),pairs);
                    %M(i,7) = (M(i,7) + sum((Z(:,1) + Z(:,2) == 2)));
                    % Add ammo
                    %Z = 0;
                    %Z = ismembc(A(:,1:2),pairs);
                    %M(i,3) = (M(i,3) + sum((Z(:,1) + Z(:,2) == 2)));
                    M(i,3) = 0;
                elseif  M(i,7) == 0
                    M(i,4) = 0;
                    M(i,7) = 0;
                    M(i,3) = 0;
                else
                    % the user/group died delete them we assume that only zombie
                    % comes from a group
                    M(i,4) = 0;
                    M(i,7) = 0;
                    M(i,3) = 0;
                end
            end
        end
        
        % Moving cost .1 life points
        %M(i,7) = (M(i,7) - .1) * M(i,4);
        
        
        
    end
    % Transfer movement vectors
    M(:,1) = M(:,5);
    M(:,2) = M(:,6);
    
    % Plot results
    subplot(2,2,1);
    gscatter(M(:,1),M(:,2),M(:,7),'bgrcmyk','o',5,'on')
    xlim([0 Length]);
    ylim([0 Length]);
    % Plot the number of survivors
    subplot(2,2,2);
    S(1,1)
    S(t,1) = sum(M(:,4));
    %S(t,2) = sum(M(:,7));
    S(t,2) = sum(M(:,4)==0);
    S(t,3) = sum(M(:,3));
    
    plot(S(:,1));
    xlim([0 t]);
    ylim([0 S(1,1)]);
    
    % Plot the total zombies
    subplot(2,2,3);
    plot(S(:,2));
    
        % Plot the total ammo of everyone who is living
    subplot(2,2,4);
    plot(S(:,3));
    
    pause(.0005)
    % Create new ammo and food at random places
    % Generate food matrix
%     F = zeros(N,2);
%     
%     % Generate ammo matrix
%     A = zeros(N,2);
%     for j = 1:N
%         F(j,1) = randi(Length,1,1); % random initial x
%         F(j,2) = randi(Length,1,1); % random initial y
%         
%         A(j,1) = randi(Length,1,1); % random initial x
%         A(j,2) = randi(Length,1,1); % random initial y
%     end
    
        % Remove the dead people
    M(any(M(:,8)<0,2),:)=[];
end
end