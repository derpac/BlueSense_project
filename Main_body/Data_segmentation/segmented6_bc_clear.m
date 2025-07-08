path = "D:\DERPAC\!university\Year 3\PROJECT\third-tests\clears\clears_data_17c.mat";
start = round(398.664);
dend = round(581.654);
thresh = 12000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = true;

[segmented_bc_clear,peakTimestamps] = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\timestamps4','peakTimestamps')
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_bc_clear','segmented_bc_clear')