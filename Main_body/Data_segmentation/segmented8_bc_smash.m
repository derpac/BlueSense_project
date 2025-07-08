path = "D:\DERPAC\!university\Year 3\PROJECT\second-tests\Data\Smash\smash_data_17c.mat";
start = round(308.714);
dend = round(560);
thresh = 23900;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = false;

[segmented_bc_smash,peakTimestamps] = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\timestamps6','peakTimestamps')
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_bc_smash','segmented_bc_smash')