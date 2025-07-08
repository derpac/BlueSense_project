function[segmentedData,peakTimestamps] = data2Segmented(dataPath,dataStart,dataEnd,peakLength,smoothSize, peakThreshold, peakDistance,pos)
    %load data
    load(dataPath);
    dataRaw = LOG87DBhand;  % serve raw data
    
    %define start and end times for data alignment
    dataStart = dataStart/0.002 + 1;
    dataEnd = dataEnd/0.002 + 1;
    alginedData = dataRaw(dataStart:dataEnd, :); % redefine data between limits
    
    windowSize = smoothSize; 
    smoothedData = movmean(alginedData.gyro_z, windowSize);
    %plot aligned data to make sure its correct:
    dt = 1/500;
    time = (0:dt:(height(alginedData)-1)*dt)';
    
    figure;
    plot(time,alginedData.gyro_z,'r')
    title('aligned data gyro_z');
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    legend('aligneddata');
    grid on;
    
    figure;
    plot(time,smoothedData,'r')
    title('smoothed data gyro_z');
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    legend('smootheddata');
    grid on;
    
    %extract the peaks using threshold
    segmentedData = {};
    threshold = peakThreshold;
    shotLength = peakLength; % somwhere between 1 and 2 seconds but likely closer to 1
    
    
    % find peaks using findpeak:
    
    minDistance = peakDistance; 
    
    if pos == true
    
        [pks, locs] = findpeaks(alginedData.gyro_z, 'MinPeakHeight', threshold, 'MinPeakDistance', minDistance);
            figure;
            plot(alginedData.gyro_z);
            hold on;
            plot(locs, pks, 'ro', 'MarkerFaceColor', 'r');
            title('Detected Peaks');
            xlabel('Time/Samples');
            ylabel('Amplitude');
            legend('Data', 'Peaks');
    else
        [pks, locs] = findpeaks(-alginedData.gyro_z, 'MinPeakHeight', threshold, 'MinPeakDistance', minDistance);
        figure;
        plot(-alginedData.gyro_z);
        hold on;
        plot(locs, pks, 'ro', 'MarkerFaceColor', 'r');
        title('Detected Peaks');
        xlabel('Time/Samples');
        ylabel('Amplitude');
        legend('Data', 'Peaks');
    end

  
    
    
    % now extract shots from the peaks.
    
shotLength = 251;  % ensure correct shot length

for i = 1:length(locs)
    % Center shot around the detected peak
    shotStart = locs(i) - floor((shotLength-1)/2);  
    shotEnd = locs(i) + ceil((shotLength-1)/2);  

   % deal with shots at start and end of data stream
    if shotStart < 1
        shotStart = 1;
        shotEnd = shotStart + shotLength - 1;  
    end

    
    if shotEnd > size(alginedData, 1)
        shotEnd = size(alginedData, 1);
        shotStart = shotEnd - shotLength + 1;  
    end

    
    segmentedData{i} = alginedData(shotStart:shotEnd, :);  
  
end
  
    peakTimestamps = [];

    adjustedLocs = locs + round(dataStart); 
    peakTimes = adjustedLocs * 0.002;

   
    peakTimestamps = peakTimes;

    figure;
    numPlots = min(10, length(segmentedData)); % so we don't exceed available segments
    
    for i = 1:numPlots
        subplot(10, 1, i);
        plot(segmentedData{i}.gyro_z, 'b', 'LineWidth', 1.5); 
        title(['Segmented Shot ' num2str(i)]);
        xlabel('Time (samples)');
        ylabel('Acceleration Z-axis');
        grid on;
    end
    
    
    %* with just algined data it will give you the table allowing for
    %.gyro_z,y,z and gyro but it wont be smoothed. Smoothed will only be
    %gyro_z or whatever is smoothed but it is atleast smoothed. 