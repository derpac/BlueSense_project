%clear; clc; close all;

hand = LOG87DB;
forearm = LOG8557;
upperarm = LOG3FCD;
torso = LOG4007;


% ----- Define Start Indices with Proper Rounding -----
hstart = max(1, round(38.418 / 0.002) + 1);
fastart = max(1, round(49.82 / 0.002) + 1);
uastart = max(1, round(65.154 / 0.002) + 1);

% ----- Extract Data from Tables -----
hand = hand(hstart:end, :);
forearm = forearm(fastart:end, :);
upperarm = upperarm(uastart:end, :);

% ----- Convert Gyroscope Data from deg/s to rad/s -----
hand_gyro_x = hand.gyro_x * (pi / 180);
hand_gyro_y = hand.gyro_y * (pi / 180);
hand_gyro_z = hand.gyro_z * (pi / 180);

forearm_gyro_x = forearm.gyro_x * (pi / 180);
forearm_gyro_y = forearm.gyro_y * (pi / 180);
forearm_gyro_z = forearm.gyro_z * (pi / 180);

upperarm_gyro_x = upperarm.gyro_x * (pi / 180);
upperarm_gyro_y = upperarm.gyro_y * (pi / 180);
upperarm_gyro_z = upperarm.gyro_z * (pi / 180);

% ----- Define Link Lengths -----
upperarm_l = 0.3;
forearm_l = 0.3;
hand_l = 0.1;

% ----- Compute Relative Angles Using Complementary Filter -----
[theta_x, theta_y, theta_z] = complementaryFilter(hand_gyro_x, hand_gyro_y, hand_gyro_z, hand.accel_x, hand.accel_y, hand.accel_z);

% ----- Compute Joint Positions -----
shoulder_x = 0;
shoulder_z = 0;

elbow_x = upperarm_l * sin(theta_x);
elbow_z = upperarm_l * cos(theta_x);

wrist_x = elbow_x + forearm_l * sin(theta_x + theta_y);
wrist_z = elbow_z + forearm_l * cos(theta_x + theta_y);

hand_x = wrist_x + hand_l * sin(theta_x + theta_y + theta_z);
hand_z = wrist_z + hand_l * cos(theta_x + theta_y + theta_z);

% ----- Setup Animation -----
time = (1:length(hand_x)) / 500; % Assuming 500 Hz sampling rate
figure;
axis equal;
xlabel('X Position (m)');
ylabel('Z Position (m)');
title('Arm Motion Over Time (Side View)');
grid on;
hold on;

% ----- Define Plot Limits -----
xlim([min(hand_x) - 0.1, max(hand_x) + 0.1]);
ylim([min(hand_z) - 0.1, max(hand_z) + 0.1]);

% ----- Initialize Plot Elements -----
arm_segments = plot([shoulder_x, elbow_x(1), wrist_x(1), hand_x(1)], ...
                    [shoulder_z, elbow_z(1), wrist_z(1), hand_z(1)], 'k-', 'LineWidth', 2);
h = plot(hand_x(1), hand_z(1), 'bo', 'MarkerSize', 10, 'LineWidth', 2);
trajectory = plot(hand_x(1), hand_z(1), 'r', 'LineWidth', 1);

% ----- Animation Loop -----
for t = 1:length(time)
    % Update joint positions
    set(arm_segments, 'XData', [shoulder_x, elbow_x(t), wrist_x(t), hand_x(t)], ...
                      'YData', [shoulder_z, elbow_z(t), wrist_z(t), hand_z(t)]);
    
    % Update hand position
    set(h, 'XData', hand_x(t), 'YData', hand_z(t));

    % Update trajectory
    set(trajectory, 'XData', hand_x(1:t), 'YData', hand_z(1:t));

    % Refresh plot
    drawnow;

    % Pause for smooth animation
    pause(1/500); % Match the sampling rate
end

% ----- Function: Complementary Filter for Angle Calculation -----
function [theta_x, theta_y, theta_z] = complementaryFilter(gyro_x, gyro_y, gyro_z, accel_x, accel_y, accel_z)
    dt = 1 / 500; % 500 Hz sampling rate
    alpha = 0.98; % Complementary filter parameter (adjustable)
    
    % Initialize angles
    theta_x = zeros(size(gyro_x));
    theta_y = zeros(size(gyro_y));
    theta_z = zeros(size(gyro_z));

    % Compute initial angles from accelerometer (assuming small initial velocity)
    theta_x(1) = atan2(accel_y(1), accel_z(1));  
    theta_y(1) = atan2(-accel_x(1), sqrt(accel_y(1)^2 + accel_z(1)^2));  
    theta_z(1) = 0; % Gyroscopes usually don't measure Z tilt well

    % Apply complementary filter
    for t = 2:length(gyro_x)
        % Gyro-based angle estimation (integration)
        theta_x_gyro = theta_x(t-1) + gyro_x(t) * dt;
        theta_y_gyro = theta_y(t-1) + gyro_y(t) * dt;
        theta_z_gyro = theta_z(t-1) + gyro_z(t) * dt;
        
        % Accel-based angle estimation
        theta_x_acc = atan2(accel_y(t), accel_z(t));
        theta_y_acc = atan2(-accel_x(t), sqrt(accel_y(t)^2 + accel_z(t)^2));

        % Combine gyro & accel using complementary filter
        theta_x(t) = alpha * theta_x_gyro + (1 - alpha) * theta_x_acc;
        theta_y(t) = alpha * theta_y_gyro + (1 - alpha) * theta_y_acc;
        theta_z(t) = theta_z_gyro; % Gyro-only for Z
    end
end
