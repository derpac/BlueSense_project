%plot the accel and gyro of both sensors but first the data must be
%analysed to identify where to start...

%first plot col 1 against accels
%M[35] 500Hz Acc (BW=184Hz) Gyro (BW=250Hz) Mag 100Hz x by the way

sense1 = LOG87DBhand;   
sense2 = LOG4065forearm;     
sense3 = LOG8557torso;
sense4 = LOG3FCDupperarm;

fs = 500;                 % Hz
dt = 1 / fs;              % period

% Find total time for each sensor with the number of rows of tables
time1 = (0:dt:(height(sense1)-1)*dt)'; % Time vector for sense1
time2 = (0:dt:(height(sense2)-1)*dt)'; % Time vector for sense2
time3 = (0:dt:(height(sense3)-1)*dt)'; % Time vector for sense3
time4 = (0:dt:(height(sense4)-1)*dt)'; % Time vector for sense4

% Plot all six signals (accel_x, accel_y, accel_z, gyro_x, gyro_y, gyro_z)
figure;

% Sensor 1
subplot(6, 4, 1);
plot(time1, sense1.accel_x, 'r');
title('Accel X - Sensor 1');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 2);
plot(time1, sense1.accel_y, 'g');
title('Accel Y - Sensor 1');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 3);
plot(time1, sense1.accel_z, 'b');
title('Accel Z - Sensor 1');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 4);
plot(time1, sense1.gyro_x, 'r');
title('Gyro X - Sensor 1');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

subplot(6, 4, 5);
plot(time1, sense1.gyro_y, 'g');
title('Gyro Y - Sensor 1');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

subplot(6, 4, 6);
plot(time1, sense1.gyro_z, 'b');
title('Gyro Z - Sensor 1');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

% Sensor 2
subplot(6, 4, 7);
plot(time2, sense2.accel_x, 'r');
title('Accel X - Sensor 2');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 8);
plot(time2, sense2.accel_y, 'g');
title('Accel Y - Sensor 2');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 9);
plot(time2, sense2.accel_z, 'b');
title('Accel Z - Sensor 2');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 10);
plot(time2, sense2.gyro_x, 'r');
title('Gyro X - Sensor 2');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

subplot(6, 4, 11);
plot(time2, sense2.gyro_y, 'g');
title('Gyro Y - Sensor 2');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

subplot(6, 4, 12);
plot(time2, sense2.gyro_z, 'b');
title('Gyro Z - Sensor 2');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

% Sensor 3
subplot(6, 4, 13);
plot(time3, sense3.accel_x, 'r');
title('Accel X - Sensor 3');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 14);
plot(time3, sense3.accel_y, 'g');
title('Accel Y - Sensor 3');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 15);
plot(time3, sense3.accel_z, 'b');
title('Accel Z - Sensor 3');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 16);
plot(time3, sense3.gyro_x, 'r');
title('Gyro X - Sensor 3');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

subplot(6, 4, 17);
plot(time3, sense3.gyro_y, 'g');
title('Gyro Y - Sensor 3');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

subplot(6, 4, 18);
plot(time3, sense3.gyro_z, 'b');
title('Gyro Z - Sensor 3');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

% Sensor 4
subplot(6, 4, 19);
plot(time4, sense4.accel_x, 'r');
title('Accel X - Sensor 4');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 20);
plot(time4, sense4.accel_y, 'g');
title('Accel Y - Sensor 4');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 21);
plot(time4, sense4.accel_z, 'b');
title('Accel Z - Sensor 4');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

subplot(6, 4, 22);
plot(time4, sense4.gyro_x, 'r');
title('Gyro X - Sensor 4');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

subplot(6, 4, 23);
plot(time4, sense4.gyro_y, 'g');
title('Gyro Y - Sensor 4');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

subplot(6, 4, 24);
plot(time4, sense4.gyro_z, 'b');
title('Gyro Z - Sensor 4');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
grid on;

