import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import cumtrapz

text_file = open("basic-3d-plots\LOG-87DB_3d_2.000", "r")
lines = text_file.readlines()
print(lines)

accel = []
gravity_offset = 1990
for line in lines:
    columns = line.strip().split(',')
    accel.append([columns[5],columns[6],columns[7]])
accel = [[int(x) for x in row] for row in accel]
print(accel)


# x   y   z
#[x,  y,  z],
#[x,  y,  z],

x_accel_data = [row[0] for row in accel]
y_accel_data = [row[1] - gravity_offset for row in accel]
z_accel_data = [row[2] for row in accel]
print(y_accel_data)

plot_x_axis = np.arange(len(x_accel_data)) / 100.0
time_step = 1/100
# Numerical integration of acceleration to get velocity
velocity_x = cumtrapz(x_accel_data, dx=time_step, initial=0)
velocity_y = cumtrapz(y_accel_data, dx=time_step, initial=0)
velocity_z = cumtrapz(z_accel_data, dx=time_step, initial=0)

# Numerical integration of velocity to get displacement
displacement_x = cumtrapz(velocity_x, dx=time_step, initial=0)
displacement_y = cumtrapz(velocity_y, dx=time_step, initial=0)
displacement_z = cumtrapz(velocity_z, dx=time_step, initial=0)

# Plot the 3D displacement
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')

# Plot displacement in 3D space (x, y, z)
ax.plot(displacement_x, displacement_y, displacement_z, label='3D Displacement')

# Set labels and title
ax.set_xlabel('X Displacement')
ax.set_ylabel('Y Displacement')
ax.set_zlabel('Z Displacement')
ax.set_title('3D Displacement Over Time')

# Show grid and legend
ax.legend()
ax.grid(True)

# Show the plot
plt.show()
