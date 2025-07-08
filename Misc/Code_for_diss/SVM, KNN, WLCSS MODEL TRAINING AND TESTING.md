# SVM, KNN, WLCSS MODEL TRAINING AND TESTING



[TOC]





## 1. DATA

### 1.1 DATA ALIGN

#### 1.1.1 Serves

**Short serve:**

IMU1-HAND:   61.716  → 243.468

```matlab
path = "D:\DERPAC\!university\Year 3\PROJECT\second-tests\Data\Serves\serves_data_17c.mat";
start = 61.716;
dend = 243.468;
thresh = 4000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = false;

segmented_short_serve = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);

```



**Long serve:**

IMU1-HAND: 267.348 → 413.056

```matlab
path = "D:\DERPAC\!university\Year 3\PROJECT\second-tests\Data\Serves\serves_data_17c.mat";
start = 258.722;
dend = 397.288;
thresh = 10000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = true;

segmented_long_serve = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);


%function[segmentedData] = data2Segmented(dataPath,dataStart,dataEnd,peakLength,smoothSize, peakThreshold, peakDistance,pos)

```



#### 1.1.2 Clears

**Front court:**

IMU1-HAND: 147.322 → 363.026

```matlab
path = "D:\DERPAC\!university\Year 3\PROJECT\third-tests\clears\clears_data.mat";
start = 147.322;
dend = 363.026;
thresh = 17000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = false;

segmented_fc_clear = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);

```



**Back court:**

IMU1-HAND: 398.664 → 581.654

```matlab
path = "D:\DERPAC\!university\Year 3\PROJECT\third-tests\clears\clears_data.mat";
start = 398.664;
dend = 581.654;
thresh = 17000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = false;

segmented_bc_clear = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);

```



#### 1.1.3 Smash

**Front court:**

IMU1-HAND: 71.444 → 283.698

```matlab
path = "D:\DERPAC\!university\Year 3\PROJECT\second-tests\Data\Smash\smash_data_17c.mat";
start = 71.444;
dend = 283.698;
thresh = 17000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = false;

segmented_fc_smash = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);

```



**Back court:**

IMU1-HAND: 308.714 → 560

```matlab
path = "D:\DERPAC\!university\Year 3\PROJECT\second-tests\Data\Smash\smash_data_17c.mat";
start = 308.714;
dend = 560;
thresh = 17000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = false;

segmented_bc_smash = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);

```



#### 1.1.4 FH-Flick

IMU1-HAND: 318.2 → 445.726

```matlab
path = "D:\DERPAC\!university\Year 3\PROJECT\second-tests\Data\FH-Flick\FH_flick_data.mat";
start = 313.824;
dend = 446.65;
thresh = 15000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = false;

segmented_fh_flick = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);


%data2Segmented(dataPath,dataFileName,dataStart,dataEnd,sensorAxis,peakLength,smoothSize, peakThreshold, peakDistance)


% for this segmentation the peaks are actually troughs and thus the data
% must be -data.... 
```



#### 1.1.5 BH-Flick

IMU1-HAND: 331.934 → 466.836

```matlab
path = "D:\DERPAC\!university\Year 3\PROJECT\second-tests\Data\BH-Flick\BH_flick_data.mat";
start = 71.444;
dend = 283.698;
thresh = 15000;
shotL = 500;
smoothSize = 100;
peakDist = 1000;
pos = true;

segmented_bh_flick = data2Segmented(path,start,dend,shotL,smoothSize,thresh,peakDist,pos);

```





## 2. KNN / SVM

### 

### Total shots:

**Short serve: 38**

**Long serve: 29**

**FC-Clear: 65**   

> Due to gyro limits this could be flipped to use the negative peaks...

**BC-Clear: 53**

> Same note

**FC-Smash: 26**

> Same note

**BC-Smash: 31**

> Same note

**FH-Flick: 33**

**BH-Flick: 41**



**Total: 316**











## 3. WLCSS