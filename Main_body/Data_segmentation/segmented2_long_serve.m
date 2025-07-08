path = "D:\DERPAC\!university\Year 3\PROJECT\second-tests\Data\Serves\serves_data_17c.mat";
start = round(258.722);
dend = round(397.288);
thresh = 15000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = false;

[segmented_long_serve,peakTimestamps] = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\timestamps2','peakTimestamps');
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_long_serve','segmented_long_serve');

%function[segmentedData] = data2Segmented(dataPath,dataStart,dataEnd,peakLength,smoothSize, peakThreshold, peakDistance,pos)
