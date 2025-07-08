% define templates based off the totalTimestamps

% totalTimestamps = 309x2
% 
% template1 = data(totalTimestamps{})

disp(totalTimestamps{2});

%2, 35, 65, 123, 178, 206, 245, 278

template1 = data(totalTimestamps{2}-125:totalTimestamps{2}+125);
template2 = data(totalTimestamps{35}-125:totalTimestamps{35}+125);
template3 = data(totalTimestamps{65}-125:totalTimestamps{65}+125);
template4 = data(totalTimestamps{123}-125:totalTimestamps{123}+125);
template5 = data(totalTimestamps{178}-125:totalTimestamps{178}+125);
template6 = data(totalTimestamps{206}-125:totalTimestamps{206}+125);
template7 = data(totalTimestamps{245}-125:totalTimestamps{245}+125);
template8 = data(totalTimestamps{278}-125:totalTimestamps{278}+125);