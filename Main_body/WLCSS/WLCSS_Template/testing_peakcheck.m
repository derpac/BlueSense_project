%% prepare peaks data
% the wlcss will return peaks in the form of a x time stamp and y score
% value in   x,y;x,y;x,y... generate all of these with predicted shot based
% on template

% check this against true ground... to do this simply take the x value of
% the peak and compare against raw data and take the closest peak...

labeledPeaks = cell(8, 1);  
templates = {'short serve','long serve','fclear','bclear','fc smash','bc smash','fh flick','bh flick'};
temptimes = [2,36,65,123,178,206,245,278];

for t = 1:8
   
    peaks = x_ecg(data, template{t}, totalTimestamps, temptimes(t));
    
    tempLabels = cell(size(peaks, 1), 3);
    for i = 1:size(peaks, 1)
        tempLabels{i, 1} = peaks(i, 1);        % timestamp
        tempLabels{i, 2} = peaks(i, 2);        % score
        tempLabels{i, 3} = [templates{t}];     % label
    end

    labeledPeaks{t} = tempLabels;
end

%% compare


result = [];
for i = 1:length(labeledPeaks)
    val = labeledPeaks(i,1);    %this isn't correct
    minVal = val-125;
    maxVal = val+125;
    for j = 1:length(totalTimestamps)
        if totalTimestamps{j,1} > minVal && totalTimestamps{j} < maxVal
            result = [result;labeledPeaks(i,1),PREDICTOR,totalTimestamps{j,1},labeledPeaks(i,3),labeledPeaks(i,2)];
        else
            disp('next');
        end
    end
end

%% fix cross-over

% if any true grounds are repeated remove smallest scores...
