
% fundamentally all that needs to be found is the time stamps for data in
% induvidual files for segmentation

% data is total data stream, lets do 1:ds:end and simply plot:

data = load("PROJECT\WLCSS_data_stream\final_datastream.mat");
data = data.final_datastream;
ds = 50;
%figure;
data = data(1:ds:end);
%plot(data);

% define starts and ends for example:
r1 = [243.468, 61.716, round((round(243.468) - round(61.716))/0.002)/ds];
r2 = [397.288, 258.722, round((round(397.288) - round(258.722))/0.002)/ds];
r3 = [363.026, 146.46 round((round(363.026) - round(146.46))/0.002)/ds];
r4 = [581.654, 398.664, round((round(581.654) - round(398.664))/0.002)/ds];
r5 = [283.698, 71.444, round((round(283.698) - round(71.444))/0.002)/ds];
r6 = [560, 308.714, round((round(560) - round(308.714))/0.002)/ds];
r7 = [446.65, 313.824, round((round(446.65) - round(313.824))/0.002)/ds];
r8 = [466.836, 331.934, round((round(466.836) - round(331.934))/0.002)/ds];

% define the ranges in terms of data:

r1data = data(1:r1(3));
r2data = data(r1(3):r1(3)+r2(3));
r3data = data(r1(3)+r2(3):r1(3)+r2(3)+r3(3));
r4data = data(r1(3)+r2(3)+r3(3):r1(3)+r2(3)+r3(3)+r4(3));
r5data = data(r1(3)+r2(3)+r3(3)+r4(3):r1(3)+r2(3)+r3(3)+r4(3)+r5(3));
r6data = data(r1(3)+r2(3)+r3(3)+r4(3)+r5(3):r1(3)+r2(3)+r3(3)+r4(3)+r5(3)+r6(3));
r7data = data(r1(3)+r2(3)+r3(3)+r4(3)+r5(3)+r6(3):r1(3)+r2(3)+r3(3)+r4(3)+r5(3)+r6(3)+r7(3));
r8data = data(r1(3)+r2(3)+r3(3)+r4(3)+r5(3)+r6(3)+r7(3):r1(3)+r2(3)+r3(3)+r4(3)+r5(3)+r6(3)+r7(3)+r8(3));

% %% plot the bunch:
% for i = 1:8
%     figure;
%     eval(['plot(r' num2str(i) 'data)']); 
% end


%%
% auto-generate templates for each section with pre-defined user input for
% thresholds:

thresholds = [4700,12000,7000,8000,9400,10000,10000,20000];
ranges = {-r1data,-r2data,r3data,r4data,-r5data,-r6data,-r7data,-r8data};
results = cell(8,1);

figure('Position', [100, 100, 1200, 800]);
sgtitle('Peak Detection in Each Range');

for i = 1:8
    [pks, locs] = findpeaks(ranges{i},'MinPeakHeight',thresholds(i),'MinPeakDistance',10);
    results{i} = locs';
    subplot(4,2,i); % 4 rows, 2 columns of subplots
    
    % Plot the data
    plot(ranges{i});
    hold on;
    
    % Plot the peaks
    plot(locs, pks, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
    
    % Add labels and title
    title(sprintf('Range r%d - %d peaks found', i, length(locs)));
    xlabel('Sample Index');
    ylabel('Amplitude');
    grid on;
    
    % Add legend
    legend('Data', 'Peaks', 'Location', 'best');
    
    hold off;
end

