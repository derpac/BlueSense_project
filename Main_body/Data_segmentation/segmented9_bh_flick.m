path = "D:\DERPAC\!university\Year 3\PROJECT\second-tests\Data\BH-Flick\BH_flick_17c.mat";
start = round(331.934);
dend = round(466.836);
thresh = 20000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = false;

[segmented_bh_flick,peakTimestamps]= data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\timestamps8', 'peakTimestamps')
save('PROJECT\matlab_classificationLA\Data_segmentation\TotalData_Final\segmented_bh_flick','segmented_bh_flick')