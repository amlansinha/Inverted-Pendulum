function drawMSD(y,u)

x = y(1);

%% System Parameters

% Dimensions
W = 2;   % mass width
H = 1;   % mass height

% Mass
y = H/2;

plot([-10 10],[0 0],'w','LineWidth',2)

hold on

% Draw the wall and the floor
plot([-10 -10 10],[2.5 0 0],'w','LineWidth',4);
% Draw the mass
rectangle('Position',[x-W/2,y-H/2,W,H],'Curvature',.1,'FaceColor',[1 0.1 0.1],'EdgeColor',[1 1 1]);
% Draw the spring
plot([-10, -9, -9:(9+x-(W/2))/9:x-(W/2), x-(W/2), x-(W/4)],0.75+[0 0 0 .25 -.25 .25 -.25 .25 -.25 .25 -.25 0 0 0],'r','LineWidth',2);
% Draw the damper
plot([-10 x-5],0.15+[0 0],'y',[x-5 x-5],0.15+[.10 -.10],'y',[x-20, x-W, x-W, x-20],0.15+[.1 .1 -.1 -.1],'g',[ x-W, x-(W/2)], [0.15 0.15],'g',[ x-(W/2), x-(W/2)], 0.15+[0.1 -0.1],'g','LineWidth',2);
% Draw the force
% plot([x x+u],[y y],'w','LineWidth',4)

% Setting up the window
xlim([-10 10]);
ylim([-2.5 2.5]);
set(gca,'Color','k','XColor','w','YColor','w')
set(gcf,'Position',[10 900 800 400])
set(gcf,'Color','k')
set(gcf,'InvertHardcopy','off')   

drawnow

hold off