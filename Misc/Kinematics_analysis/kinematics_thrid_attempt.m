hand = LOG87DB;
forearm = LOG8557;
upperarm = LOG3FCD;
torso = LOG4007;

hstart = round(38.418 / 0.002) + 1;  
fastart = round(49.82 / 0.002) + 1;  
uastart = round(65.154 / 0.002) + 1;

hand2 = hand(hstart:end, :);  
forearm2 = forearm(fastart:end, :);  
upperarm2 = upperarm(uastart:end, :);

%----- convert to rad/s (may be redund)
hand_gyro_x = hand.gyro_x * (pi/180);
hand_gyro_y = hand.gyro_y * (pi/180);
hand_gyro_z = hand.gyro_z * (pi/180);

forearm_gyro_x = forearm.gyro_x * (pi/180);
forearm_gyro_y = forearm.gyro_y * (pi/180);
forearm_gyro_z = forearm.gyro_z * (pi/180);

upperarm_gyro_x = upperarm.gyro_x * (pi/180);
upperarm_gyro_y = upperarm.gyro_y * (pi/180);
upperarm_gyro_z = upperarm.gyro_z * (pi/180);

torso_gyro_x = torso.gyro_x * (pi/180);
torso_gyro_y = torso.gyro_y * (pi/180);
torso_gyro_z = torso.gyro_z * (pi/180);
%-----

%----- master function for plotting
% first define link lengths (approx)
upperarm_l = 0.3;
forearm_l = 0.3;
hand_l = 0.1;

% find relative position
[theta_x, theta_y, theta_z] = thetaCalc(hand_gyro_x,hand_gyro_y, hand_gyro_z); % change the inputs to this fcn to change sensor

hand_x = upperarm_l * sin(theta_x) + forearm_l * sin(theta_x + theta_y) + hand_l * sin(theta_x + theta_y + theta_z);
%hand_y
hand_z = upperarm_l * cos(theta_x) + forearm_l * cos(theta_x + theta_y) + hand_l * cos(theta_x + theta_y + theta_z);

% plot
time = hand.count/500;
figure;
axis equal; % Ensure equal scaling for x and z axes
xlabel('X Position (m)');
ylabel('Z Position (m)');
title('Arm Motion Over Time (Side View)');
grid on;
hold on;

% Define limits for the plot
xlim([min(hand_x) - 0.1, max(hand_x) + 0.1]);
ylim([min(hand_z) - 0.1, max(hand_z) + 0.1]);

% Initialize the plot
h = plot(hand_x(1), hand_z(1), 'bo', 'MarkerSize', 10, 'LineWidth', 2); % Plot the hand position
trajectory = line(hand_x(1), hand_z(1), 'Color', 'r', 'LineWidth', 1); % Plot the trajectory

% Animate the motion
for t = 1:length(time)
    % Update the hand position
    set(h, 'XData', hand_x(t), 'YData', hand_z(t)); % Use 'YData' instead of 'ZData' for 2D plots
    
    % Update the trajectory
    set(trajectory, 'XData', hand_x(1:t), 'YData', hand_z(1:t)); % Use 'YData' instead of 'ZData' for 2D plots
    
    % Refresh the plot
    drawnow;
    
    % Pause to control the speed of the animation
    pause(0.01); % Adjust the pause time as needed
end


%----- use integration to find the angles
function [theta_x,theta_y,theta_z] = thetaCalc(gyrodata_x, gyrodata_y, gyrodata_z);
    dt = 1/500; % 500Hz
    theta_x = cumsum(gyrodata_x) * dt;
    theta_y = cumsum(gyrodata_y) * dt;
    theta_z = cumsum(gyrodata_z) * dt;
end

%-----


%----- use quaternions to compute orientation (may be erroneous and redund)

function R = quat2rot(sensor)
    qs = sensor.qs; q1 = sensor.q1; q2 = sensor.q2; q3 = sensor.q3;
    R = [1 - 2*(q2^2 + q3^2), 2*(q1*q2 - q3*qs), 2*(q1*q3 + q2*qs);
         2*(q1*q2 + q3*qs), 1 - 2*(q1^2 + q3^2), 2*(q2*q3 - q1*qs);
         2*(q1*q3 - q2*qs), 2*(q2*q3 + q1*qs), 1 - 2*(q1^2 + q2^2)];
end

%-----