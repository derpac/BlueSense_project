% quick look at a system for classification using the WLCSS algorithm...
% take the data and combine into a single data stream identify templates
% for all the data a-priori in this data stream and test the WLCSS with the
% given templates one at a time adjust the variables to supervise in its
% learning and to get the best accuracy....

% the first stage of the is the really tedious selection of correct unit,
% sensor and axis... This method is just long. It would be good if i made a
% system that tested all of these options and gave me the best result but
% thats almost paradoxically working back... 

%done. Now using the selected data streams collate one large data stream
%with breaks between to indicate changes in shot and the extract templates
%finally use the wlcss to test accuracy.

%easier said than done yet doable in a session.

%% Serve
% load the serve data and select sensor 2: gyro_z
clear;
load("PROJECT\second-tests\Data\Serves\serves_data_17c.mat");
serves_rawdata = LOG87DBhand;
serves_endr = serves_rawdata.gyro_z;
% trim the data 
sserve_start = round(61.716)/0.002 +1;
sserve_end = round(243.468)/0.002 +1;
sserves_endr_trim = serves_endr(sserve_start:sserve_end);

lserve_start = round(258.722)/0.002 + 1;
lserve_end = round(397.288)/0.002 + 1;
lserves_endr_trim = serves_endr(lserve_start:lserve_end);

% save the data 

save('PROJECT\WLCSS_data_stream\sserves_endr_trim',"sserves_endr_trim");
save('PROJECT\WLCSS_data_stream\lserves_endr_trim',"lserves_endr_trim");

%% Clear
% load the clears data (third tests) and select sensor 2: gyro_z

clear;
load("PROJECT\third-tests\clears\clears_data_17c.mat");
clears_rawdata = LOG87DBhand;
clears_endr = clears_rawdata.gyro_z;
% trim the data
fclear_start = round(146.46)/0.002 +1;
fclear_end = round(363.026)/0.002 +1;
fclears_endr_trim = clears_endr(fclear_start:fclear_end);

bclear_start = round(398.664)/0.002 +1;
bclear_end = round(581.654)/0.002 +1;
bclears_endr_trim = clears_endr(bclear_start:bclear_end);

%save the data

save('PROJECT\WLCSS_data_stream\fclears_endr_trim','fclears_endr_trim');
save('PROJECT\WLCSS_data_stream\bclears_endr_trim','bclears_endr_trim');

%% Smash
% load the smash data (second tests) and select sensor 1: gyro_z
clear;
load("PROJECT\second-tests\Data\Smash\smash_data.mat");
smash_rawdata = LOG87DBhand;
smash_endr = smash_rawdata.gyro_z;
% trim the data
fsmash_start = round(71.444)/0.002 +1;
fsmash_end = round(283.698)/0.002 +1;
fsmash_endr_trim = smash_endr(fsmash_start:fsmash_end);

bsmash_start = round(308.714)/0.002 +1;
bsmash_end = round(560)/0.002 +1;
bsmash_endr_trim = smash_endr(bsmash_start:bsmash_end);
%save data 
save('PROJECT\WLCSS_data_stream\fsmash_endr_trim','fsmash_endr_trim');
save('PROJECT\WLCSS_data_stream\bsmash_endr_trim','bsmash_endr_trim');

%% FH-Flick
% load the fh-flick data and select sensor 1: gyro_z
% be chopped to remove the initial (front court) data
clear;
load("PROJECT\second-tests\Data\FH-Flick\fh_flick_data_17c.mat");
fhflick_rawdata = LOG87DBhand;
fhflick_endr = fhflick_rawdata.gyro_z;
% trim the data
fh_start = round(313.824)/0.002 + 1;
fh_end = round(446.65)/0.002 + 1;
fhflick_endr_trim = fhflick_endr(fh_start:fh_end);
%save trimmed
save('PROJECT\WLCSS_data_stream\fhflick_endr_trim','fhflick_endr_trim');
%% BH-Flick
% load the bh-flick data and select sensor 1: gyro_z, This data needs to
% be chopped to remove the initial (front court) data
clear;
load("PROJECT\second-tests\Data\BH-Flick\BH_flick_17c.mat");
bhflick_rawdata = LOG87DBhand;
bhflick_endr = bhflick_rawdata.gyro_z;
% trim the data:
bh_start = round(331.934)/0.002 + 1;
bh_end = round(466.836)/0.002 + 1;
bhflick_endr_trim = bhflick_endr(bh_start:bh_end);
%save trimmed
save('PROJECT\WLCSS_data_stream\bhflick_endr_trim','bhflick_endr_trim');
clear;
%--------------
%% Compile into a single data stream

% load all the trimmed data and append together:
d1 = load("PROJECT\WLCSS_data_stream\sserves_endr_trim.mat");
d2 = load("PROJECT\WLCSS_data_stream\lserves_endr_trim.mat");
d3 = load("PROJECT\WLCSS_data_stream\fclears_endr_trim.mat");
d4 = load("PROJECT\WLCSS_data_stream\bclears_endr_trim.mat");
d5 = load("PROJECT\WLCSS_data_stream\fsmash_endr_trim.mat");
d6 = load("PROJECT\WLCSS_data_stream\bsmash_endr_trim.mat");
d7 = load("PROJECT\WLCSS_data_stream\fhflick_endr_trim.mat");
d8 = load("PROJECT\WLCSS_data_stream\bhflick_endr_trim.mat");

% bh -> serves -> smash -> fh -> clear
final_datastream = [d1.sserves_endr_trim;d2.lserves_endr_trim;d3.fclears_endr_trim;d4.bclears_endr_trim;d5.fsmash_endr_trim;d6.bsmash_endr_trim;d7.fhflick_endr_trim;d8.bhflick_endr_trim];

fs = 500;               
dt = 1 / fs;              
time = (0:dt:(height(final_datastream)-1)*dt)'; 
figure;
save('PROJECT\WLCSS_data_stream\final_datastream','final_datastream');
% Sensor 1
plot(time, final_datastream, 'r');
title('all the data in one stream');
xlabel('Time (s)');
ylabel('data');
grid on;