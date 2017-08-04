function drawPend(y)

global m M L

x = y(1);
th = y(3);

%% System Parameters

% Dimensions
W  =  1; % cart width
H  = .3; % cart height
wr = .1; % wheel radius
mr = .2; % mass radius

% Cart
y   = wr/2+H/2; % y position of the center of the cart      

% Wheels
w1x = x-.9*W/2; % x position of the left wheel
w1y = 0;        % y position of the left wheel  
w2x = x+.9*W/2; % x position of the right wheel
w2y = 0;        % y position of the right wheel

% Pendulum
px = x + L*sin(th);
py = y - L*cos(th);

plot([-10 10],[0 0],'w','LineWidth',2)

hold on
% Draw the cart
rectangle('Position',[x-W/2,y-H/2,W,H],'Curvature',.1,'FaceColor',[1 0.1 0.1],'EdgeColor',[1 1 1])
% Draw the left wheel
rectangle('Position',[w1x,w1y,wr,wr],'Curvature',[1 1],'FaceColor',[1 1 1],'EdgeColor',[1 1 1])
% Draw the right wheel
rectangle('Position',[w2x,w2y,wr,wr],'Curvature',[1 1],'FaceColor',[1 1 1],'EdgeColor',[1 1 1])
% Draw the rod
plot([x px],[y py],'w','LineWidth',2)
% Draw the mass
rectangle('Position',[px-mr/2,py-mr/2,mr,mr],'Curvature',[1 1],'FaceColor',[.3 0.3 1],'EdgeColor',[1 1 1])

% Setting up the window
% xlim([-10 10]);
ylim([-2.5 2.5]);
set(gca,'Color','k','XColor','w','YColor','w')
set(gcf,'Position',[10 900 800 400])
set(gcf,'Color','k')
set(gcf,'InvertHardcopy','off')   

drawnow

hold off