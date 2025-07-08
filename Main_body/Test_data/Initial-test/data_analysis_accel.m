%plot the accel and gyro of both sensors but first the data must be
%analysed to identify where to start...

%first plot col 1 against accels
%M[35] 500Hz Acc (BW=184Hz) Gyro (BW=250Hz) Mag 100Hz x by the way

sense1 = LOG87DB;   %hand
sense2 = LOG8557;   %forearm      %change these with the suffix 1 to make change it to clear
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
plot(time1, sense1.accel_x, 'r'); hold on;
plot(time2, sense2.accel_x, 'b');
title('Accel X - Sensor 1 vs Sensor 2');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
legend('Sensor 1', 'Sensor 2');
grid on;
%--------------------
subplot(3,1,2);
plot(time1, sense1.accel_y, 'r'); hold on;
plot(time2, sense2.accel_y, 'b');
title('Accel Y - Sensor 1 vs Sensor 2');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
legend('Sensor 1', 'Sensor 2');
grid on;
%--------------------
subplot(3,1,3);
plot(time1, sense1.accel_z, 'r'); hold on;
plot(time2, sense2.accel_z, 'b');
title('Accel Z - Sensor 1 vs Sensor 2');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
legend('Sensor 1', 'Sensor 2');
grid on;
%--------------------


startIndex1 = 0;%54351;  %for x = 108.7      % this holds true for all serve data
startIndex2 = 0;%13067;  %for x = 26.132 

endIndex2 = 80000; %38405 ;   %for x = 76.808  % the end index is the same for both when the starts are aligned    
endIndex1 = 80000; %79490;   % for x = 158.978 
% the start indexes for are the peak of the first hit. This does mean that
% the data shown has the first hit half cut off. 

% Trim the data to synchronize the start
trimmedSense1 = sense1(startIndex1:endIndex1, :);
trimmedSense2 = sense2(startIndex2:endIndex2, :);

% Recalculate time vectors for the trimmed data
trimmedTime1 = (0:dt:(height(trimmedSense1)-1)*dt)';
trimmedTime2 = (0:dt:(height(trimmedSense2)-1)*dt)';

% Plot the synchronized signals
figure;
subplot(3,1,1);
plot(trimmedTime1, trimmedSense1.accel_x, 'r'); hold on;
plot(trimmedTime2, trimmedSense2.accel_x, 'b');
title('Accel X - Synchronized Signals');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
legend('Sensor 1', 'Sensor 2');
grid on;

subplot(3,1,2);
plot(trimmedTime1, trimmedSense1.accel_y, 'r'); hold on;
plot(trimmedTime2, trimmedSense2.accel_y, 'b');
title('Accel Y - Synchronized Signals');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
legend('Sensor 1', 'Sensor 2');
grid on;

subplot(3,1,3);
plot(trimmedTime1, trimmedSense1.accel_z, 'r'); hold on;
plot(trimmedTime2, trimmedSense2.accel_z, 'b');
title('Accel Z - Synchronized Signals');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
legend('Sensor 1', 'Sensor 2');
grid on;

