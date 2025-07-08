% Load your data (assuming it's in a variable called 'segmentedData')
% Initialize feature matrix (each row is a shot, columns are 501 accel_x values)
numShots = length(segmentedData);  % 37 shots
numTimesteps = 501;  % Fixed-length time series

features = zeros(numShots, numTimesteps);
labels = (1:numShots)'; % Shot labels (or use categories)

for i = 1:numShots
    accel_x = segmentedData{i}.accel_x;  % Extract accel_x column
    features(i, :) = accel_x';  % Store as a row vector
end

% Convert labels to categorical for SVM classification
labels = categorical(labels);

% Convert to table format for Classification Learner
featureTable = array2table(features);
featureTable.Labels = labels;


%% open the model

%classificationLearner


%-----------------

%% test model with testing data

% Load trained SVM model
trainedSVM = trainedModel2.ClassificationSVM;

% Predict on test data (assuming testData is formatted the same way)
predictedLabels = predict(trainedSVM, testData(:,1:end-1));

% Calculate accuracy
accuracy = sum(predictedLabels == testData.Labels) / length(testData.Labels) * 100;
fprintf('SVM Test Accuracy: %.2f%%\n', accuracy);



