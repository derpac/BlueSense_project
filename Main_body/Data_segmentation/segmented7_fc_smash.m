path = "D:\DERPAC\!university\Year 3\PROJECT\second-tests\Data\Smash\smash_data_17c.mat";
start = round(71.444);
dend = round(283.698);
thresh = 11500;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = false;

[segmented_fc_smash,peakTimestamps] = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\timestamps5','peakTimestamps')
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_fc_smash','segmented_fc_smash')