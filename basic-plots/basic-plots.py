import matplotlib.pyplot as plt
import numpy as np

from scipy.signal import savgol_filter
# first generate arrays of the data

text_file = open("LOG-87DB.003", "r")
lines = text_file.readlines()
print(lines)

accel = []

for line in lines:
    columns = line.strip().split(',')
    accel.append([columns[5],columns[6],columns[7]])
accel = [[int(x) for x in row] for row in accel]
print(accel)


# x   y   z
#[x,  y,  z],
#[x,  y,  z],

x_accel_data = [row[0] for row in accel]
y_accel_data = [row[1] for row in accel]
z_accel_data = [row[2] for row in accel]

plot_x_axis = np.arange(len(x_accel_data)) / 100.0

# attempt at smoothing the data:
# def moving_average(data, window_size):                   # moving average method 
#     return np.convolve(data, np.ones(window_size) / window_size, mode='valid')

# window_size = 5
# x_accel_smoothed = moving_average(x_accel_data, window_size)
# time_smoothed = plot_x_axis[:len(x_accel_smoothed)]

x_accel_smoothed = savgol_filter(x_accel_data, window_length=11, polyorder=3)    #Savitzky-Golay filter (much easier let python do the work :D)
y_accel_smoothed = savgol_filter(y_accel_data, window_length=11, polyorder=3) 
z_accel_smoothed = savgol_filter(z_accel_data, window_length=11, polyorder=3) 

print(x_accel_data)
y_min = min(z_accel_data)
y_max = max(z_accel_data)
                                                     
x_accel_ts = x_accel_data[0:1200]   # for a specific time/ range of samples use these
plot_time_ts = plot_x_axis[0:1200] 


plt.figure(figsize=(10, 6))

plt.plot(plot_x_axis, x_accel_smoothed, label="Accelrometer X-axis Data", color="b")
plt.plot(plot_x_axis, y_accel_smoothed, label="Accelrometer Y-axis Data", color="g")
plt.plot(plot_x_axis, z_accel_smoothed, label="Accelrometer Z-axis Data", color="r")

plt.ylim([y_min, y_max])
plt.title('X accel vs Time (100Hz Sampling Rate)')
plt.xlabel('Time (seconds)')
plt.ylabel('X axis accel')
plt.grid(True)
plt.legend()


plt.show()