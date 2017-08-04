% Inverted Pendulum
% author: Amlan Sinha
% Find the optimal control for a linear quadratic regulator system

clf
close all
clear all
clc

%% System Parameters
% State: X = [x, xdot, theta, thetadot]

global L M m g

% constants
g = -9.81;
L = 1;
M = 5;
m = 1;

% The reference point about which the pendulum is linearized
% v = +1, if pendulum is inverted
% v = -1, if pendulum is not inverted
v = 1;

% Initial Conditions
x10 = -5;
x20 = 0;
x30 = pi+0.1;
x40 = 0;
X0 = [x10; x20; x30; x40];

% Final Conditions
x1f = 0;
x2f = 0;
x3f = pi;
x4f = 0;
XF = [x1f; x2f; x3f; x4f];

time = linspace(0,10,1000);

%% Linearize the system about the unstable equilibrium

% Setting up state space:
A = [0 1 0 0; 0 0 -m*g/M 0; 0 0 0 1; 0 0 -v*(M+m)*g/(M*L) 0];
B = [0; 1/M; 0; v*1/(M*L)];

%% Optimal Control Law for the linearized system

% Setting up Q & R matrices:
Q = [1 0 0 0; 0 1 0 0; 0 0 100 0; 0 0 0 100];
R = 0.0001;
N = 0;

%% Apply the control law to the non-linear system

% With Control Input

% K = Kalman Gain, P = Solution to matrix DRE, EV = eigen values 
[K,P,EV] = lqr(A,B,Q,R,N);

% Integrating with control input
[t_wu,y_wu] = ode45(@(t,y)invPen_eom(y,-K*(y-XF)),time,X0);

% Control Input
U = -K*y_wu';

% Extracting necessary states
x_wu = y_wu(:,1);
dx_wu = y_wu(:,2);
theta_wu = y_wu(:,3);
dtheta_wu = y_wu(:,4);

%% Original Non-linear system
% Without Control Input

% Integrating without control input
[t,y] = ode45(@(t,y)invPen_eom(y,0),time,X0);

% Extracting necessary states
x = y(:,1);
dx = y(:,2);
theta = y(:,3);
dtheta = y(:,4);

set(0,'DefaultFigureWindowStyle','docked')

%% Graphics

% With Control Input
figure(1)
hold on
subplot(2,1,1);
plot(t_wu,x_wu,'b.-',t_wu,dx_wu,'b--',t_wu,theta_wu,'g.-',t_wu,dtheta_wu,'g--');
legend({'${x}$','$\dot{x}$','${\theta}$','$\dot{\theta}$'},'Interpreter','latex')
subplot(2,1,2);
plot(t_wu,U,'r');
legend({'${u}$'},'Interpreter','latex')
title('Response with control input, U');
xlabel('$t/s$','Interpreter','latex');
ylabel('$response$','Interpreter','latex');
hold off

figure(3)
for k1=1:5:length(t_wu)
    drawPend(y_wu(k1,:));
    Mov1(k1) = getframe(gcf);
end

xlabel('$x/m$','Interpreter','latex')
ylabel('$y/m$','Interpreter','latex')

% Without Control Input
figure(4)
plot(t,x,'b.-',t,dx,'b--',t,theta,'g.-',t,dtheta,'g--');
legend({'${x}$','$\dot{x}$','${\theta}$','$\dot{\theta}$'},'Interpreter','latex')
title('Response without control input, U');
xlabel('$t/s$','Interpreter','latex');
ylabel('$response$','Interpreter','latex');

figure(5)
for k2=1:5:length(t)
    drawPend(y(k2,:));
    Mov2(k2) = getframe(gcf);
end
xlabel('$x/m$','Interpreter','latex')
ylabel('$y/m$','Interpreter','latex')