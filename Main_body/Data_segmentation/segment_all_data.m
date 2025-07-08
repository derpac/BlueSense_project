serve_path = 'second-tests\Data\Serves\serves_data_17c.mat';
smash_path = 'second-tests\Data\Smash\smash_data_17c.mat';
clear_path = 'third-tests\clears\clears_data.mat';
fh_flick_path = 'second-tests\Data\FH-Flick\FH_flick_data.mat';
bh_flick_path = 'second-tests\Data\BH-Flick\BH_flick_data.mat';

serve_filename = LOG4065forearm;
smash_filename = LOG4065forearm;
clear_filename = LOG4065forehand;
fh_flick_filename =;
bh_flick_filename =;

short_serve_segmented = data2Segmented()

%data2Segmented(dataPath,dataFileName,dataStart,dataEnd,sensorAxis,peakLength,smoothSize, peakThreshold, peakDistance)