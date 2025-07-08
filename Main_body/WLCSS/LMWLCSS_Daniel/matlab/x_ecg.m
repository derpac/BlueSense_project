
function[peaks] = x_ecg(data,template,totalTimestamps,timetempval,threshold,acceptdist)
    %% prepare the data
    % Read data
    
    %dataMatrix = (table2array(LOG87DBhand));
    %dataorg = data(:,5);
    
    % Rescale the data
    %data = data/100;
    % Downsample
    ds=5;
    %ds=20;
   % data=data(1:ds:end);
    % Extract a template (we know a-priori where it is)
    %data = data/100;
    data = data(:).';
    templateidx = [totalTimestamps{timetempval}-500:totalTimestamps{timetempval}+500];
    %template=data(templateidx);
    %template=data(template);
    %template = template(:).';
    %disp(template);
    %reshape(template, 1, []);
    
    figure(1);
    clf;
    plot(data);
    hold on;
    h=plot(templateidx,template,'r-');
    set(h,'LineWidth',2);
    hold off;
    
    penalty=1*16;
    reward=1*16;
    accepteddist=acceptdist;
    threshold=threshold;
    wfind=500;
    ws=50;
    
    %% Test the different implementations
    
    
     tic;
     score = wlcss_double_nobt(template,data,penalty,reward,accepteddist);
     toc;
     peaks = findpeak(score,wfind,threshold);
     prettyplotmatch(data,templateidx,score,peaks,[],threshold);

end

%% other implementations


% 
% 
% tic;
% [score2,btrackall] = wlcss_double_bt(template,data,penalty,reward,accepteddist);
% toc;
% peaks2 = findpeak(score2,wfind,threshold);
% prettyplotmatch(data,templateidx,score2,peaks2,btrackall,threshold);
% 

%tic;
%[score3,btrackall,dbgscore,dbgsul,dbgsu,dbgsl] = wlcss_double_bt_dbg(template,data,penalty,reward,accepteddist);
%toc;
%peaks3 = findpeak(score3,wfind,threshold);
%prettyplotmatch(data,templateidx,score3,peaks3,btrackall,threshold);

% tic;
% score4 = wlcss_int_nobt(int16(template),int16(data),int16(penalty),int16(reward),int16(accepteddist),'int16');
% toc;
% peaks4 = findpeak(score4,wfind,threshold);
% peaks4
% prettyplotmatch(data,templateidx,score4,peaks4,[],threshold);
% 
% tic;
% [score5,btrackall5] = wlcss_int_bt(int16(template),int16(data),int16(penalty),int16(reward),int16(accepteddist),'int16');
% toc;
% peaks5 = findpeak(score5,wfind,threshold);
% prettyplotmatch(data,templateidx,score5,peaks5,btrackall5,threshold);
% 
% 
% tic;
% [score6,btrackall6,dbgscore,dbgsul,dbgsu,dbgsl] = wlcss_int_bt_dbg(int16(template),int16(data),int16(penalty),int16(reward),int16(accepteddist),'int16');
% toc;
% peaks6 = findpeak(score6,wfind,threshold);
% prettyplotmatch(data,templateidx,score6,peaks6,btrackall6,threshold);
% 
% 
% [score7,peaks7] = incwlcssfind_int_nobt(int16(template),int16(data),int16(penalty),int16(reward),int16(accepteddist),wfind,threshold,'int16');
% prettyplotmatch(data,templateidx,score7,peaks7,[],threshold)

