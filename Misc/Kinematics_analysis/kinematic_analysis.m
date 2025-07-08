% the basic idea to carry out the kinematic analysis of the arm while playing badminton is as follows:
% Use the accelerometer, gyroscope and magnetometer data to understand the rotations, movement and forces acting
% on the arm

% The issue with this comes from the acceleration data. When an axis of the accelerometer points directly up it will read the
%equvilent of 1g in this case this is about 2000. When pointing directly down this reads -2000. This reading vaires with it
%being 0 at 90 deg this obviously varies at cos(theta) where theta is taken from the global Y (upwards) axis
% to account for this at every recording of acceleration the quaternions can be found to compare IMU axes against global
% find the angle they make with global Y and account for it with: 

% recorded acceleration - cos(theta)*2000. Where 2000 is the average maximum acceleration recorded when stationary. A calibration
%could be carried out to find this average maximum acceleration if needed however taking it as 2000 is good enough for a first draft


% define data
T = LOG87DB_hand;

% find quaternions for each point (this can be measured by the sensors so
% might be a bit redundant in the future)
scale_factor = 9.81 / 2000;

og_x_accel = T.accel_x;
og_y_accel = T.accel_y;
og_z_accel = T.accel_z;
% workout angles for each point and adjust acceleration 
% the quaternions are in form qr + q1i + q2j + q3k



s = 1;
globAxis = [0 1 0];
% to change the axis use [1 0 0] or [0 0 1]

% at every interval the rotation matrix needs to be found and q1,2,3 are defined
numRows = height(T); % where T is the result table 
for i = 1:numRows
    qr = T.qr(i);   % to allow this to work make sure to correctly label the columns
    qi = T.qi(i);
    qj = T.qj(i);
    qk = T.qk(i);
% next generate the rotation matrix:
    
    rotmat = [OTS(s,qj,qk) TS(s,qi,qj,qk,qr) TS(s,qi,qk,qj,qr);
              TS(s,qi,qj,qk,qr) OTS(s,qi,qk) TS(s,qj,qk,qi,qr);
              TS(s,qi,qk,qj,qr) TS(s,qj,qk,qi,qr) OTS(s,qi,qj)];
% next find the angle
    xAng = axisAngle(rotmat,'x', globAxis);
    yAng = axisAngle(rotmat,'y', globAxis);
    zAng = axisAngle(rotmat,'z', globAxis);
% next find the correction needed and adjust
    xCorrection = cos(xAng)*2000;
    yCorrection = cos(yAng)*2000;
    zCorrection = cos(zAng)*2000;
% adjust
    T.accel_x(i) = T.accel_x(i) - xCorrection;
    T.accel_y(i) = T.accel_y(i) - yCorrection;
    T.accel_z(i) = T.accel_z(i) - zCorrection;
end 

%To test that the code is working / doing something I will plot the
%acceleration before and after the corrections are made this is why I
%stored the og x,y,z accelerations...

% ---------------------------------------

time = (1:numRows) / 500;

figure;
subplot(3,1,1);
plot(time, og_x_accel, 'r', 'LineWidth', 1.2); hold on;
plot(time, T.accel_x, 'b', 'LineWidth', 1.2);
xlabel('Time (s)');
ylabel('X Accel (m/s²)');
title('X-Axis Acceleration Before & After Correction');
legend('Before', 'After');
grid on;

subplot(3,1,2);
plot(time, og_y_accel, 'r', 'LineWidth', 1.2); hold on;
plot(time, T.accel_y, 'b', 'LineWidth', 1.2);
xlabel('Time (s)');
ylabel('Y Accel (m/s²)');
title('Y-Axis Acceleration Before & After Correction');
legend('Before', 'After');
grid on;

subplot(3,1,3);
plot(time, og_z_accel, 'r', 'LineWidth', 1.2); hold on;
plot(time, T.accel_z, 'b', 'LineWidth', 1.2);
xlabel('Time (s)');
ylabel('Z Accel (m/s²)');
title('Z-Axis Acceleration Before & After Correction');
legend('Before', 'After');
grid on;

sgtitle('Comparison of Accelerations Before and After Correction'); 
disp('Acceleration correction and visualization completed.');

%----------------------------------

% The next task is to plot the displacment of the hand using a coordinate
% system.

%---------------------------------


initial_position = [0, 0, 0]; % Initial position [x0, y0, z0]
initial_velocity = [0, 0, 0]; % Initial velocity [vx0, vy0, vz0]
initial_orientation = [1, 0, 0, 0]; % Assuming initial quaternion [qr, qi, qj, qk]

% Time vector (from the sampling rate, assuming 500Hz)
time = (1:numRows) / 500; % Time vector (in seconds)

% Initialize arrays for position, velocity, and orientation
position = zeros(numRows, 3); % Store [x, y, z] position
velocity = zeros(numRows, 3); % Store [vx, vy, vz] velocity
orientation = zeros(numRows, 4); % Store quaternion for orientation [qr, qi, qj, qk]

% initial pos and vel 
position(1, :) = initial_position;
velocity(1, :) = initial_velocity;

for i = 2:numRows

    dt = time(i) - time(i-1);

    % accel data (corrected)
    ax = T.accel_x(i);
    ay = T.accel_y(i);
    az = T.accel_z(i);

    % gyroscope data (angular velocity in rad/s)
    gx = T.gyro_x(i); 
    gy = T.gyro_y(i); 
    gz = T.gyro_z(i); 

    % integrate acceleration to get velocity
    velocity(i, 1) = velocity(i-1, 1) + ax * dt;
    velocity(i, 2) = velocity(i-1, 2) + ay * dt;
    velocity(i, 3) = velocity(i-1, 3) + az * dt;

    % integrate velocity to get position 
    position(i, 1) = position(i-1, 1) + velocity(i-1, 1) * dt + 0.5 * ax * dt^2;
    position(i, 2) = position(i-1, 2) + velocity(i-1, 2) * dt + 0.5 * ay * dt^2;
    position(i, 3) = position(i-1, 3) + velocity(i-1, 3) * dt + 0.5 * az * dt^2;
end

% plot 
figure;
plot3(position(:, 1), position(:, 2), position(:, 3), 'LineWidth', 1.5);
xlabel('X Position (m)');
ylabel('Y Position (m)');
zlabel('Z Position (m)');
title('Sensor Movement Trajectory');
grid on;


%---------------------------------
function result = axisAngle(rotmat, axis, globAxis)
    if isequal(axis, 'x')
        axis = [1;0;0];
    elseif isequal(axis, 'y')
        axis = [0;1;0];
    else
        axis = [0;0;1];
    end
    rotatedVector = rotmat*axis;    
    cosTheta = (dot(rotatedVector,globAxis)/(norm(rotatedVector)*norm(globAxis)));
    result = acos(cosTheta);
end

function result = OTS(s,q1,q2)
    result = 1-2*s*(q1^2+q2^2);
end

function result = TS(s,q1,q2,q3,qr)
    result = 2*s*(q1*q2 - q3*qr);
end