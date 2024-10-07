import pandas as pd
import numpy as np

# Load data from external file (assuming it's a CSV file)
file_path = 'basic-3d-plots\LOG-87DB_3d_2.000'  # Replace with the actual file path

# Load the data into a pandas DataFrame
df = pd.read_csv(file_path, header=None)
if df.shape[1] > 10:
    df = df.drop(df.columns[-1], axis=1)
# Assign column names
df.columns = ['sample_num', 'packet_sent', 'battery_percentage', 'file_num', 
              'acc_x', 'acc_y', 'acc_z', 'gyro_x', 'gyro_y', 'gyro_z']

# Convert relevant columns to numeric (they may load as strings initially)
df = df.apply(pd.to_numeric)

print(df.head())  # Display the first few rows to ensure correct loading

dt = 0.01  # Replace with the actual time interval between samples if available

# Velocity is the integral of acceleration
df['vel_x'] = np.cumsum(df['acc_x'] * dt)
df['vel_y'] = np.cumsum(df['acc_y'] * dt)
df['vel_z'] = np.cumsum(df['acc_z'] * dt)

# Position is the integral of velocity
df['pos_x'] = np.cumsum(df['vel_x'] * dt)
df['pos_y'] = np.cumsum(df['vel_y'] * dt)
df['pos_z'] = np.cumsum(df['vel_z'] * dt)

print(df[['pos_x', 'pos_y', 'pos_z']].head())  # Display computed positions

import matplotlib.pyplot as plt
import matplotlib.animation as animation

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Set up the plot limits
def init():
    ax.set_xlim([df['pos_x'].min(), df['pos_x'].max()])
    ax.set_ylim([df['pos_y'].min(), df['pos_y'].max()])
    ax.set_zlim([df['pos_z'].min(), df['pos_z'].max()])
    return ax,

# Update function to plot progressively
def update(num):
    ax.cla()  # Clear the plot
    ax.plot(df['pos_x'][:num], df['pos_y'][:num], df['pos_z'][:num])
    return ax,

# Create the animation
ani = animation.FuncAnimation(fig, update, frames=len(df), init_func=init, blit=False)

plt.show()