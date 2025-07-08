%% Define and initialise data
% the data will be in the format of a 1xX cell each containing the 501 data
% points for a shot. The X may be 90 for example with 30 short serve, 30
% long serve and 30 Smashes...

short_serve_seg = load('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_short_serve.mat'); %33  
long_serve_seg = load('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_long_serve.mat'); %30

fc_clear_seg = load('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_fc_clear.mat'); %58
bc_clear_seg = load('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_bc_clear.mat'); %55

fc_smash_seg = load('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_fc_smash.mat'); %28
bc_smash_seg = load('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_bc_smash.mat'); %20

bhflick_seg = load('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_bh_flick.mat'); %33
fhflick_seg = load('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_fh_flick.mat'); %33


entireSegmentedData = [short_serve_seg.segmented_short_serve,long_serve_seg.segmented_long_serve,fc_clear_seg.segmented_fc_clear,bc_clear_seg.segmented_bc_clear,fc_smash_seg.segmented_fc_smash,bc_smash_seg.segmented_bc_smash,bhflick_seg.segmented_bh_flick,fhflick_seg.segmented_fh_flick];
% defining the training data as such gives no room for testing data... To
% over come this i will simply take the first 10 of each type of shot to
% train with and the remaining shots to test the model..

%% Define labels and features

%in the example case the label definitions would be short serve 1:33,  long
%Define these lables determined a-priori
labels = categorical([repmat("short serve", 1, 33), repmat("long serve", 1, 30), repmat("fc clear", 1, 58), repmat("bc clear", 1, 55),repmat("fc smash", 1, 28), repmat("bc smash", 1, 20), repmat("bh flick", 1, 33), repmat("fh flick", 1, 33)])';



%% Extract features from data
% in this case the features extracted from the data will just be the raw
% accel data this allows for easy switching between accel/gyro x,y,z...
% also doesnt confuse the project by introducing things the other
% algorithms won't

numShots = length(entireSegmentedData);  %290 shots
numTimesteps = 251;  

features = zeros(numShots, numTimesteps);

featureNames = arrayfun(@(x) sprintf('Feature_%d', x), 1:numTimesteps, 'UniformOutput', false);

for i = 1:numShots
    gyro_x = entireSegmentedData{i}.gyro_x;  % Extract gyro_x column
    disp(size(gyro_x));
   
    features(i, :) = gyro_x(:)'; % Store as a row vector
end

trainFeatures = [features(1:10, :); features(34:43, :); features(64:73, :); features(122:131, :); features(176:185, :); features(205:214, :); features(225:234, :); features(258:267, :)];  
trainLabels = [labels(1:10, :); labels(34:43, :); labels(64:73, :); labels(122:131, :);labels(176:185, :); labels(205:214, :); labels(225:234, :); labels(258:267, :)];
   
% make sure the labels are catagorical!!!! seems to fix issue with SVM in
% CLA
trainFeatureTable = array2table(trainFeatures, 'VariableNames', featureNames);
trainFeatureTable.Labels = trainLabels;  % Add labels as last column
%% Open the CLA and define and train the model

classificationLearner 


%% test the exported model

% test the model with the rest of the data...

testFeatures = [features(11:33, :); features(44:63, :); features(74:121, :); features(132:175, :); features(186:204, :); features(215:224, :); features(235:257, :); features(268:end, :)];

testLabels = [labels(11:33, :); labels(44:63, :); labels(74:121, :); labels(132:175, :);labels(186:204, :); labels(215:224, :); labels(235:257, :); labels(268:end, :)];

testFeatureTable = array2table(testFeatures, 'VariableNames', featureNames);
testFeatureTable.Labels = testLabels;  % add labels



