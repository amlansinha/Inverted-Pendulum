% Inverted Pendulum Equations of Motion
% author: Amlan Sinha

function dy = invPen_eom(y,u)

global L m M g

x = y(1);
dx = y(2);
theta = y(3);
dtheta = y(4);

dy(1) = dx;
dy(2) = (1/(M+m*(sin(theta))^2))*(u+m*sin(theta)*(L*dtheta^2-g*cos(theta)));
dy(3) = dtheta;
dy(4) = (1/(L*(-M-m*(sin(theta))^2)))*(u*cos(theta)+m*L*dtheta*sin(theta)*cos(theta)-(M+m)*g*sin(theta));

dy = dy';