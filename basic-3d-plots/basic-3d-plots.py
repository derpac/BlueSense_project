import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
# from scipy.signal import savgol_filter
# first generate arrays of the data

text_file = open("basic-3d-plots\LOG-87DB_3d.000", "r")
lines = text_file.readlines()
print(lines)

gravity_offset = 2000
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
z_accel_data = [row[2]  - gravity_offset for row in accel]

plot_x_axis = np.arange(len(x_accel_data)) / 100.0
time_step = 1/100

def workout_vel_dis(acceleration_data, time_step):

    n = len(x_accel_data) # any array will do they are all the same length...
    velocity = np.zeros(n)
    displacement = np.zeros(n)
    # work out velocities
    # then work out displacements
    for i in range(1, n):
        # velocity: v = u + at
        velocity[i] = velocity[i-1] + acceleration_data[i-1] * time_step
        
        # displacement: s = ut + 1/2 * a * t^2
        displacement[i] = displacement[i-1] + (velocity[i-1] * time_step) + (0.5 * acceleration_data[i-1] * (time_step ** 2))
    return velocity, displacement

velocity_x, displacement_x = workout_vel_dis(x_accel_data, time_step)
velocity_y, displacement_y = workout_vel_dis(y_accel_data, time_step)
velocity_z, displacement_z = workout_vel_dis(z_accel_data, time_step)

# populate a 
# attempt at smoothing the data:
# def moving_average(data, window_size):                   # moving average method 
#     return np.convolve(data, np.ones(window_size) / window_size, mode='valid')

# window_size = 5
# x_accel_smoothed = moving_average(x_accel_data, window_size)
# time_smoothed = plot_x_axis[:len(x_accel_smoothed)]

# x_accel_smoothed = savgol_filter(x_accel_data, window_length=11, polyorder=3)    #Savitzky-Golay filter (much easier let python do the work :D)
# y_accel_smoothed = savgol_filter(y_accel_data, window_length=11, polyorder=3) 
# z_accel_smoothed = savgol_filter(z_accel_data, window_length=11, polyorder=3) 

time_array = np.arange(len(x_accel_data)) * time_step

fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')


ax.plot(displacement_x, displacement_y, displacement_z, label='3D Displacement')


ax.set_xlabel('X Displacement')
ax.set_ylabel('Y Displacement')
ax.set_zlabel('Z Displacement')
ax.set_title('3D Displacement')

ax.legend()
ax.grid(True)


plt.show()