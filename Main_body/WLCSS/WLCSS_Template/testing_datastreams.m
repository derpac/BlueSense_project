fullData = load('PROJECT\WLCSS_data_stream\final_datastream.mat');

data = fullData.final_datastream;

r1 = (round(243.468) - round(61.716))/0.002;
r2 = round(397.288) - round(258.722);
r3 = round(363.026) - round(146.46);
r4 = round(581.654) - round(398.664);
r5 = round(283.698) - round(71.444);
r6 = round(560) - round(308.714);
r7 = round(446.65) - round(313.824);
r8 = round(446.836) - round(331.934);


stream1 = data(1:r1);
stream2 = data(r1:r1+r2);
stream3 = data(r1+r2:r1+r2+r3);
stream4 = data(r1+r2+r3:r1+r2+r3+r4);
stream5 = data(r1+r2+r3+r4:r1+r2+r3+r4+r5);
stream6 = data(r1+r2+r3+r4+r5:r1+r2+r3+r4+r5+r6);
stream7 = data(r1+r2+r3+r4+r5+r6:r1+r2+r3+r4+r5+r6+r7);
stream8 = data(r1+r2+r3+r4+r5+r6+r7:r1+r2+r3+r4+r5+r6+r7+r8);