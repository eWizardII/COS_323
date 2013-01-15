function [] = gsfun(S)
t = 1:length(S);
t = t';
y = S(:,3);
hold on;

% initial guess (these were the result of empirical experimintation with
% the cftool, we found out these would be good conditions to start with
% though the code is robust enough to handle other conditions)

a=100; b=100; c=5;
g=[100 100 5]';

% Define intial conditions also based on MATLAB's defaults in the cftool
n=size(t,1); 
i=0;
tol=.1;

while (i<100) && (tol>1E-6)
% Set the vaule of the function and perform u substituion the function we
% use is selected from the following site http://www.colby.edu/chemistry/PChem/scripts/lsExamples.pdf
% basically we sought out to find a type of exponential curve that we
% thought would be approriate for our problem in this case the one used in
% Gibb's free energy relationships seemed approriate this is because this
% function allows for both decaying exponentials in truth one could use any
% sort of exponential function they wanted, we just felt this one was more
% approraite to our task, we were also able to check it verse the cftool in
% MATLAB, in this same tool we find that the default tolerance is 1E-6 so
% we used the same one in our code, the default iterations used is 400 so
% we used the same amount

% Do u substitution
u=-t/b; 

f=a*exp(u)+c-y;

% Calculate the Jacobian (we performed this in advance by using MATLAB's
% symbolic notation solver so for example - jacobian(sym('a*exp(u)+c-y'),sym('b'))
% this tells us that J_2 should be 0s which we have implemented using the
% zeros function - we repeat this for the other three cases

% Here we store the vaules of the Jacobian
J=[exp(u) zeros(n,1) ones(n,1)];

% Unfortunately since our code didn't work properlly in assignment 2 we
% reintrepted how we would be allow to do GN in doing so we generate a
% working code that doesn't use SVD

% Perform the actual Gauss Newton calculation
delta=-J\f; 
g=g+delta;

% Adjust the tolerances and such with each iteration
tol=norm(delta); 
i=i+1;

a=g(1); b=g(2); c=g(3);
end

xx=(0:1:length(S))'; 
yy=a*exp(-(xx)/b)+c;
subplot(2,2,2),

% Append the legend information
hnew = plot(xx,yy);
% Get object handles
[~,~,OUTH,OUTM] = legend;

% Add object with new handle and new legend string to legend
legend([OUTH;hnew],OUTM{:},'GN FIT')
end