% deg/s -> rad/s

% accelerometer from 2000 -> 9.81

%-----------------------------------
g = 9.80665;
const = g/2000;
accel_adj = accel_data * const;
%-----------------------------------
gyro_adj = deg2rad(gyro_data);


