% with this code the change of the angles can be found and sub out the th1
% and th2. Similarly the lengths can be found however with only two sensors
% this is limited. 



% function for plotting with prev ee location

clc; clear; close all;


L1 = 1;
L2 = 5;

% Define joint angle trajectories (e.g., sine wave motion)
t = linspace(0, 2*pi, 100); % Time steps
th1 = pi/4 * sin(t); % Theta 1 varies sinusoidally
th2 = pi/6 * cos(t); % Theta 2 varies cosinusoidally


traj = []; 

figure; 
for i = 1:length(th1)
    clf;

    
    q = [th1(i), th2(i)];

    
    [pos1, pos2] = fwkine2link(L1, L2, q);

   
    traj = [traj; pos2];

  
    plotupt(pos1, pos2, traj);

    pause(0.05); 
end

pause(2); 





function plotupt(pos1,pos2,prev_traj)
% assemble X coords of 0, frame 1 and frame 2

X = [0, pos1(1), pos2(1)];
Y = [0 ,pos1(2), pos2(2)];

plot(X,Y,'LineWidth',2,'color','red','Marker','o','MarkerEdgeColor','black','MarkerFaceColor', 'White', 'MarkerSize',4);
 xlabel('X');
 ylabel('Y');
hold on
plot(prev_traj(:,1), prev_traj(:,2), 'b--', 'LineWidth', 1.5);
end


function [pos1,pos2] = fwkine2link(L1,L2,q)

%first extract q1 and q2 with q vector
q1 = q(1);
q2 = q(2);
% next find x1 and y1
x1 = L1*cos(q1);
y1 = L1*sin(q1);
% next find x2 and y2 
x2 = x1+L2*cos(q1+q2);
y2 = y1+L2*sin(q1+q2);
% define the pos

pos1 = [x1,y1,q1];
pos2 = [x2,y2,q1+q2];

end