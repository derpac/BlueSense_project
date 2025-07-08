

sense1 = LOG87DB1;   %hand
sense2 = LOG40651;   %forearm  %change these with the suffix 1 to make change it to clear
%assign tables 
%assign cols
%plot cols against value1  

%

% Sampling frequency and time step
fs = 500;                 % Hz
dt = 1 / fs;              % period

% find total time for sensor 1 and sensor 2 with number of rows of tables
time1 = (0:dt:(height(sense1)-1)*dt)'; % Time vector for sense1
time2 = (0:dt:(height(sense2)-1)*dt)'; % Time vector for sense2

% plot
figure;
subplot(3,1,1);
plot(time1, sense1.gyro_x, 'r'); hold on;
plot(time2, sense2.gyro_x, 'b');
title('gyro X - Sensor 1 vs Sensor 2');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
legend('Sensor 1', 'Sensor 2');
grid on;
%--------------------
subplot(3,1,2);
plot(time1, sense1.gyro_y, 'r'); hold on;
plot(time2, sense2.gyro_y, 'b');
title('gyro Y - Sensor 1 vs Sensor 2');
xlabel('Time (s)');
ylabel('Gyroscope (deg/2)');
legend('Sensor 1', 'Sensor 2');
grid on;
%--------------------
subplot(3,1,3);
plot(time1, sense1.gyro_z, 'r'); hold on;
plot(time2, sense2.gyro_z, 'b');
title('gyro Z - Sensor 1 vs Sensor 2');
xlabel('Time (s)');
ylabel('Gyroscope (deg/s)');
legend('Sensor 1', 'Sensor 2');
grid on;
%--------------------