% Mass Spring Damper System
% author: Amlan Sinha
% Find the optimal control for the mass to reach equilibrium 

clf
close all
clear all
clc

%% System Parameters
% State: X = [x, xdot]

global c k m

% constants
c = 0.5;
k = 5;
m = 10;

% Initial Conditions
x10 = 5; 
x20 = -1;
X0 = [x10; x20];

% Setting up the time vector
tfinal = 20;

%% Dynamics of the system with controls

% Setting up state space with controls:
AA = [0 1; -k/m -c/m];
BA = [0; 1/m];
CA = [1 1];
DA = 1;

%% Optimal Control Law for the system

% Setting up Q & R matrices
Q = [1 0; 0 10];
R = 1;
N = 0;

% K = Kalman Gain, P = Solution to matrix DRE, EV = eigen values 
[K,P,EV] = lqr(AA,BA,Q,R,N);

% Setting up a dummy B matrix for the initial command
B_kal = [0;0];

% With Control Input
SYSA = ss(AA-K*BA,B_kal,CA,DA);

% initial state response
[YA,tA,XA] = initial(SYSA,X0,tfinal);

% extracting necessary states
x1_o = XA(:,1);
x2_o = XA(:,2);
u_o = -K*XA';

%% Dynamics of the original system

% Setting up state space without controls
BB = [0;0];
DB = 0;

% Without Control Input
SYSB = ss(AA,BB,CA,DB);

% initial state response
[YB,tB,XB] = initial(SYSB,X0,tfinal);

% extracting necessary states
x1nou_o = XB(:,1);
x2nou_o = XB(:,2);

%% Graphics

% With controls

figure(1)
plot(tA,x1_o,'b.-',tA,x2_o,'b--',tB,x1nou_o,'c.-',tB,x2nou_o,'c--',tA,u_o,'r')
legend({'${x}$','$\dot{x}$','${x_{without U}}$','$\dot{x}_{without U}$','u'},'Interpreter','latex')
xlabel('$t/s$','Interpreter','latex');
ylabel('$response$','Interpreter','latex');
title('$J = \int_{t_0}^{t_f} 4x_1^2(t)+4x_1(t)x_2(t)+4x_2^2(t)+0.25u^2(t) dt$ ','interpreter','latex')

figure(2)
for k=1:1:length(tA)
    drawMSD(YA(k,:),u_o(k));
    Mov(k) = getframe(gcf);
end

% Without controls

figure(3)
for k=1:1:length(tB)
    drawMSD(YB(k,:),0);
    Mov(k) = getframe(gcf);
end