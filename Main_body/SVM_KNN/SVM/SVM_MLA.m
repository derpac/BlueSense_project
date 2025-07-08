%load data
clear;
load("3rd_year_project\second_test\Data\Serves\serves_data_17c.mat")
dataRaw = LOG4065forearm;  % serve raw data

%define start and end times for data alignment
dataStart = round(53.15/0.002) + 1;
dataEnd = round(234.224/0.002) + 1;
alginedData = dataRaw(dataStart:dataEnd, :); % redefine data between limits

windowSize = 100; 
smoothedData = movmean(alginedData.accel_x, windowSize);
%plot aligned data to make sure its correct:
dt = 1/500;
time = (0:dt:(height(alginedData)-1)*dt)';

figure;
plot(time,alginedData.accel_x,'r')
title('aligned data accel_x');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
legend('aligneddata');
grid on;

figure;
plot(time,smoothedData,'r')
title('smoothed data accel_x');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
legend('smootheddata');
grid on;

%extract the peaks using threshold
segmentedData = {};
threshold = -300;
shotLength = 500; % somwhere between 1 and 2 seconds but likely closer to 1


% find peaks using findpeak:

minDistance = 1000; 

[pks, locs] = findpeaks(smoothedData, 'MinPeakHeight', threshold, 'MinPeakDistance', minDistance);


figure;
plot(smoothedData);
hold on;
plot(locs, pks, 'ro', 'MarkerFaceColor', 'r');
title('Detected Peaks');
xlabel('Time/Samples');
ylabel('Amplitude');
legend('Data', 'Peaks');


% now extract shots from the peaks.

for i = 1:length(locs)
    shotStart = max(1, locs(i) - floor(shotLength/2));
    shotEnd = min(size(smoothedData, 1), locs(i) + floor(shotLength/2));
    segmentedData{i} = alginedData(shotStart:shotEnd, :);  %changing this between alignedData and smoothedData changes this*
end

figure;
numPlots = min(10, length(segmentedData)); % Ensure we don't exceed available segments

for i = 1:numPlots
    subplot(10, 1, i); % Create subplots for visualization
    plot(segmentedData{i}.accel_x, 'b', 'LineWidth', 1.5); % Adjust to your data column (AccZ, AccX, GyroY, etc.)
    title(['Segmented Shot ' num2str(i)]);
    xlabel('Time (samples)');
    ylabel('Acceleration Z-axis');
    grid on;
end


%* with just algined data it will give you the table allowing for
%.accel_x,y,z and gyro but it wont be smoothed. Smoothed will only be
%accel_x or whatever is smoothed but it is atleast smoothed. 