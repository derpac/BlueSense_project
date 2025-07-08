path = "D:\DERPAC\!university\Year 3\PROJECT\third-tests\clears\clears_data_17c.mat";
start = round(146.46);
dend = round(363.026);
thresh = 12000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = true;

[segmented_fc_clear,peakTimestamps] = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\timestamps3','peakTimestamps')
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_fc_clear','segmented_fc_clear')