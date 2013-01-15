function [Stat] = szrfun(~,intial,beta,zeta,alpha,N)

% This function creates the SZR model differential equations to be solved
% by Matlabs ODE solver

% Initial Conditions
S=intial(1);
Z=intial(2);
R=intial(3);

% Differential Equations
Stat(1)=-beta*S*Z/N;
Stat(2)=beta*S*Z/N+zeta*R-alpha*S*Z;
Stat(3)=alpha*S*Z-zeta*R;
Stat=Stat';
end