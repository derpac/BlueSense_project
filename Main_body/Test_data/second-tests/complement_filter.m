% complementary filter ( low pass for accelerometer and high pass for
% gyroscope) fusion 

% assumptions made: This supposedly should work with the "static"
% accelerometer issues...


dt = 0.002;
alpha = 0.90; %this is to be tuned

samples = length(DATA);
pitch = zeros(samples, 1);
roll = zeros(samples, 1);

for i = 2:samples
    
    accel_pitch = atan2(ADATA(i,1), sqrt(ADATA(i, 2)^2 + ADATA(i, 3)^2));
    accel_roll = atan2(ADATA(i,2), sqrt(ADATA(i,1)^2 + ADATA(i,3)^2));

    gyro_pitch = pitch(i-1) + GDATA(i,2) * dt;
    gyro_roll = roll(i-1) + GDATA(i,1) * dt;

    pitch(i) = alpha * gyro_pitch + (1 - alpha) * accel_pitch;
    roll(i) = alpha * gyro_roll + (1 - alpha) * accel_roll;

end


time = (0:dt(samples-1)*dt)';


%plot
