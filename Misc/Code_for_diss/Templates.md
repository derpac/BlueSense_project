----

## Templates





**Serves:**

First template

```matlab
dataMatrix = (table2array(LOG87DBhand));
dataorg = dataMatrix(:,5);

%dataraw = fread(fid,inf,'int16');
%fclose(fid);

%------------

%------------

% Reshape the data

% Use channel 1 and a small portion of the data


%dataorg=dataorg(1,420:3000);
% Rescale the data
dataorg=dataorg/100;
% Downsample
ds=5;
%ds=20;
data=dataorg(30800:ds:end);
% Extract a template (we know a-priori where it is)
templateidx = round([9317/ds:10043/ds]);
template=data(templateidx);
```



Template 2:

```matlab
dataMatrix = (table2array(LOG87DBhand));
dataorg = dataMatrix(:,5);

%dataraw = fread(fid,inf,'int16');
%fclose(fid);

%------------

%------------

% Reshape the data

% Use channel 1 and a small portion of the data


%dataorg=dataorg(1,420:3000);
% Rescale the data
dataorg=dataorg/100;
% Downsample
ds=5;
%ds=20;
data=dataorg(30800:ds:end);
% Extract a template (we know a-priori where it is)
data = data(:).';
templateidx = round([15429/ds:15925/ds]);
template=data(templateidx);
template = template(:).';
reshape(template, 1, []);
```



**Long serve**:

```matlab
dataMatrix = (table2array(LOG87DBhand));
dataorg = dataMatrix(:,5);

% Rescale the data
dataorg=dataorg/100;
% Downsample
ds=5;
%ds=20;
data=dataorg(133884:ds:end);
% Extract a template (we know a-priori where it is)
data = data(:).';
templateidx = round([10859/ds:11197/ds]);
template=data(templateidx);
template = template(:).';
reshape(template, 1, []);

figure(1);
clf;
plot(data);
hold on;
h=plot(templateidx,template,'r-');
set(h,'LineWidth',2);


penalty=.5*16;
reward=2*16;
accepteddist=20;
threshold=5;
wfind=30;
ws=50;
```

> **Accept dist much larger to capture all the serves this will need to be tested agianst more data**