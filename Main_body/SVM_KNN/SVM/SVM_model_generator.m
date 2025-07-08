%% Define and initialise data
% the data will be in the format of a 1xX cell each containing the 501 data
% points for a shot. The X may be 90 for example with 30 short serve, 30
% long serve and 30 Smashes...

short_serve_seg = load("D:\DERPAC\!university\Year 3\PROJECT\matlab_classificationLA\Data_segmentation\shortserve_segmented.mat");  % 37
long_serve_seg = load("D:\DERPAC\!university\Year 3\PROJECT\matlab_classificationLA\Data_segmentation\segmented_long_serve_data2.mat"); %28
fhflick_seg = load("D:\DERPAC\!university\Year 3\PROJECT\matlab_classificationLA\Data_segmentation\segemented_fh_flick2.mat"); %30

entireSegmentedData = [short_serve_seg.segmentedData, long_serve_seg.segmented_long_serve, fhflick_seg.segmented_fh_flick];
% defining the training data as such gives no room for testing data... To
% over come this i will simply take the first 10 of each type of shot to
% train with and the remaining shots to test the model..

%% Define labels and features

%in the example case the label definitions would be short serve 1:37,  long
%serve 38:64 and 65:100 fhflick. Define these lables determined a-priori
labels = categorical([repmat("short serve", 1, 37), repmat("long serve", 1, 28), repmat("fh flick", 1, 30)])';



%% Extract features from data
% in this case the features extracted from the data will just be the raw
% accel data this allows for easy switching between accel/gyro x,y,z...
% also doesnt confuse the project by introducing things the other
% algorithms won't

numShots = length(entireSegmentedData);  %100 shots
numTimesteps = 501;  

features = zeros(numShots, numTimesteps);


for i = 1:numShots
    accel_x = entireSegmentedData{i}.accel_x;  % Extract accel_x column
    features(i, :) = accel_x';  % Store as a row vector
end

trainFeatures = [features(1:10, :); features(38:47, :); features(65:74, :)];  
trainLabels = [labels(1:10); labels(38:47); labels(65:74)];  
% make sure the labels are catagorical!!!! seems to fix issue with SVM in
% CLA
trainLabels = categorical(trainLabels);

trainFeatureTable = array2table(trainFeatures);
trainFeatureTable.Labels = trainLabels;
%% Open the CLA and define and train the model

%classificationLearner 


%% test the exported model

% test the model with the rest of the data...

testFeatures = [features(11:37, :); features(48:64, :); features(75:95, :)];  % Remaining shots
testLabels = [labels(11:37); labels(48:64); labels(75:95)];  % Corresponding labels for the remaining shots


% Ensure the test labels are categorical


% Load the exported trained model
% Assuming you exported the model from the CLA app and saved it as 'trainedModel'
% For example, if you saved the model as 'trainedModel.mat', you can load it like this:
load('trainedModel_SVM_3shots2.mat');  


trainedModel = trainedModel_SVM_3shots.ClassificationSVM;
predictions = predict(trainedModel, testFeatures);

predictorNames = trainedModel.PredictorNames;
testFeatureTable = array2table(testFeatures, 'VariableNames', predictorNames);
testFeatureTable.Labels = testLabels;

% show confusion matrix
confMat = confusionmat(testLabels, predictions);
disp('Confusion Matrix:');
disp(confMat);

% accuracy
accuracy = sum(predictions == testLabels) / length(testLabels);
disp(['Test Accuracy: ', num2str(accuracy * 100), '%']);

%-------------
