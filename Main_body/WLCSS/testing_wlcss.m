%% ------- define ranges
r1 = round(243.468) - round(61.716);
r2 = round(397.288) - round(258.722);
r3 = round(363.026) - round(146.46);
r4 = round(581.654) - round(398.664);
r5 = round(283.698) - round(71.444);
r6 = round(560) - round(308.714);
r7 = round(446.65) - round(313.824);
r8 = round(466.836) - round(331.934);

%% ------- define all 8 templates 
% keep the templates equivilent to the shots used for SVM and KNN
fullData = load('PROJECT\WLCSS_data_stream\final_datastream.mat');
data = fullData.final_datastream;
data = data/100;





%% ------ assign all shots with labels using peakfind

dataTypes = {'short serve','long serve','fclear','bclear','fc smash','bc smash','fh flick','bh flick'};

totalTimestamps = [];
thresholds = [75,150,120,120,115,239,150,200];
starts = [0,r1,r1+r2,r1+r2+r3,r1+r2+r3+r4,r1+r2+r3+r4+r5,r1+r2+r3+r4+r5+r6,r1+r2+r3+r4+r5+r6+r7];
starts = (starts(1,:)/0.002) + 1;
ends = [r1,r1+r2,r1+r2+r3,r1+r2+r3+r4,r1+r2+r3+r4+r5,r1+r2+r3+r4+r5+r6,r1+r2+r3+r4+r5+r6+r7,r1+r2+r3+r4+r5+r6+r7+r8];
ends = (ends(1,:)/0.002) + 1;
poss = [false,false,true,true,false,false,false,false];
distance = 1000;
showPlots = false;


for i = 1:length(thresholds)

    label = dataTypes{i};
    locs = findTimestamps(data, starts(i), ends(i), thresholds(i), distance, poss(i), showPlots);
    labeledTimestamps = [num2cell(locs(:)), repmat({label}, length(locs), 1)];
    totalTimestamps = [totalTimestamps; labeledTimestamps];
end



template1 = data(totalTimestamps{2}-500:totalTimestamps{2}+500);
template2 = data(totalTimestamps{36}-500:totalTimestamps{36}+500);
template3 = data(totalTimestamps{65}-500:totalTimestamps{65}+500);
template4 = data(totalTimestamps{123}-500:totalTimestamps{123}+500);
template5 = data(totalTimestamps{178}-500:totalTimestamps{178}+500);
template6 = data(totalTimestamps{205}-500:totalTimestamps{205}+500);
template7 = data(totalTimestamps{245}-500:totalTimestamps{245}+500);
template8 = data(totalTimestamps{279}-500:totalTimestamps{279}+500);




templates = {'short serve','long serve','fclear','bclear','fc smash','bc smash','fh flick','bh flick'};
temptimes = [2,36,65,123,178,206,245,279];
thresholds = [-17200,-12000,-100000,-100000,-110000,-95000,-90000,-190000];
acceptdists = [15,40,20,20,20,25,20,20];

labeledPeaks = cell(8, 1);  
result = {};
row = 1;

%% Run x_ecg per template and match to true labels
for t = 1:8
    template = eval(['template' num2str(t)]);
    predictedLabel = templates{t};

    peaks = x_ecg(data, template, totalTimestamps, temptimes(t), thresholds(t), acceptdists(t));

    peakInfo = cell(size(peaks, 1), 3);

    for i = 1:size(peaks, 1)
        predX = peaks(i, 2);  % x-position
        score = peaks(i, 1);  % score

        % find closest
        minDiff = Inf;
        closestTS = NaN;
        closestLabel = '';

        for j = 1:size(totalTimestamps, 1)
            trueX = totalTimestamps{j, 1};
            trueLabel = totalTimestamps{j, 2};
            diff = abs(trueX - predX);

            if diff < minDiff && diff <= 700  % match within tolerance set based on shot lenght
                minDiff = diff;
                closestTS = trueX;
                closestLabel = trueLabel;
            end
        end

        % store result
        if ~isnan(closestTS)
            result{row, 1} = score;
            result{row, 2} = predictedLabel;
            result{row, 3} = predX;
            result{row, 4} = closestLabel;
            result{row, 5} = closestTS;
            result{row, 6} = predX - closestTS;
            row = row + 1;
        else
            disp(['no match at peak ', num2str(predX)]);
        end

        % save info for debug
        peakInfo{i, 1} = predX;
        peakInfo{i, 2} = score;
        peakInfo{i, 3} = predictedLabel;
    end

    labeledPeaks{t} = peakInfo;
end
%% secion
resultTable = cell2table(result, ...
    'VariableNames', {'Score', 'PredictedLabel', 'PredictedX', 'TrueLabel', 'TrueX', 'Offset'});

% make sure any repeated true labels are removed and highest score kept
[uniqueTrueX, ~, idxGroup] = unique(resultTable.TrueX);

filteredResult = [];

for i = 1:length(uniqueTrueX)
    groupIdx = find(idxGroup == i);
    groupRows = resultTable(groupIdx, :);

    % find max score
    [~, maxIdx] = max(groupRows.Score);
    filteredResult = [filteredResult; groupRows(maxIdx, :)];
end


%% metrics
knownCounts = [33, 30, 58, 55, 28, 20, 33, 33];
classes = {'short serve','long serve','fclear','bclear','fc smash','bc smash','fh flick','bh flick'};

metrics = struct();

for c = 1:length(classes)
    className = classes{c};
    totalShots = knownCounts(c);
    
    % tp
    isTP = strcmp(filteredResult.PredictedLabel, className) & strcmp(filteredResult.TrueLabel, className);
    TP = sum(isTP);
    
    % fp
    isFP = strcmp(filteredResult.PredictedLabel, className) & ~strcmp(filteredResult.TrueLabel, className);
    FP = sum(isFP);
    
    % fn
    FN = totalShots - TP;

    % tn
    totalSamples = sum(knownCounts);
    TN = totalSamples - TP - FP - FN;
    
    % store. removing spaces in class names
    sanitizedName = strrep(className, ' ', '_');
    metrics.(sanitizedName) = struct('TP', TP, 'FP', FP, 'FN', FN, 'TN', TN);
end

%% final results

% confusion matrix
hold off;
figure;
numClasses = length(classes);
confMat = zeros(numClasses, numClasses);
for i = 1:height(filteredResult)
    trueIdx = find(strcmp(classes, filteredResult.TrueLabel{i}));
    predIdx = find(strcmp(classes, filteredResult.PredictedLabel{i}));
    confMat(trueIdx, predIdx) = confMat(trueIdx, predIdx) + 1;
end

confusionchart(confMat, classes, 'Title', 'Confusion Matrix', 'RowSummary','row-normalized','ColumnSummary','column-normalized');

%%

% ppv = TP/(TP+FP) = 1 - FDR
% fdr = 1 - ppv

% tpr = TP/(TP+FN) = 1 - FNR
% fnr = 1 - tpr

numClasses = length(classes);

% Calculate metrics for each class
metrics1 = table();
for i = 1:numClasses
    TP = confMat(i,i);
    FP = sum(confMat(:,i)) - TP;
    FN = sum(confMat(i,:)) - TP;
    TN = sum(confMat(:)) - TP - FP - FN;
    
    
    PPV = TP / (TP + FP); % precision
    FDR = FP / (TP + FP); % 1 - PPV
    

    TPR = TP / (TP + FN); % recall/sensitivity
    FNR = FN / (TP + FN); % 1 - TPR
    
    % Store metrics
    metrics1.Class{i} = classes{i};
    metrics1.PPV(i) = PPV;
    metrics1.FDR(i) = FDR;
    metrics1.TPR(i) = TPR;
    metrics1.FNR(i) = FNR;
end


figure;
confusionchart(confMat, classes, ...
    'Title', 'Confusion Matrix', ...
    'RowSummary', 'row-normalized', ...  
    'ColumnSummary', 'column-normalized'); 
%%

% f1-score

% p = tp/(tp+fp)
% r = tp/(tp+fn)
% f1 = 2 x (p x r)/(p + r)

f1_scores = zeros(numClasses, 1);
precision = zeros(numClasses, 1);
recall = zeros(numClasses, 1);

for c = 1:numClasses
    TP = confMat(c, c);
    FP = sum(confMat(:, c)) - TP;
    FN = sum(confMat(c, :)) - TP;

    precision(c) = TP / (TP + FP + eps);  % eps to avoid divide-by-zero
    recall(c) = TP / (TP + FN + eps);
    f1_scores(c) = 2 * (precision(c) * recall(c)) / (precision(c) + recall(c) + eps);
end

macroF1 = mean(f1_scores);
TP_all = sum(diag(confMat));
FP_all = sum(sum(confMat, 1)) - TP_all;
FN_all = sum(sum(confMat, 2)) - TP_all;

micro_precision = TP_all / (TP_all + FP_all + eps);
micro_recall = TP_all / (TP_all + FN_all + eps);
microF1 = 2 * (micro_precision * micro_recall) / (micro_precision + micro_recall + eps);




% accuracy - for each class - and total

accuracy_per_class = zeros(numClasses, 1);
for c = 1:numClasses
    TP = confMat(c, c);
    totalTrue = sum(confMat(c, :));  % all samples with this true label
    accuracy_per_class(c) = TP / (totalTrue + eps);
end


total_correct = sum(diag(confMat));
total_predictions = sum(confMat(:));
overall_accuracy = total_correct / total_predictions;

% results table

f1_table = table(classes', precision, recall, f1_scores, accuracy_per_class, ...
    'VariableNames', {'Class', 'Precision', 'Recall', 'F1Score', 'Accuracy'});
disp(f1_table);
writetable(f1_table, 'f1_scores.csv');
% --
