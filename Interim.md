--- Intro

When the smartphone was introduced it soon started to fulfil use cases beyond that of a communication device. Users now had a device in their pockets containing an array of sensors, accelerometers, magnetometers, gyroscopes and GPS. This enabled the uptake of activity tracking applications and the phenomenon of "the quantified self", a term referring to the collection of extensive data about one's own body and activities[1]. This led to the development of more specialised wearable devices that could track biometrics such as oxygen saturation and heart rate. The introduction of such technologies has led to sports analytics becoming more of a quantitative science. This helps athletes avoid injury through refining technique and identifying effective warmups and training. 

Wearable technology has became more accessible and affordable. Where they used to be only for 'high-value applications', they are now approaching commodity [2]. Advances have now broadened their range of uses with it now being possible to collect data (in particular, inertial data) at a higher sample rate. This allows wearable sensors to be targeted to particular aspects of sports performance, allowing the refinement of techniques in response to more detailed analytics.

Badminton is a game that incorporates aspects of speed and strategy 

- talk about badminton explaining a few shots and talk about the movement of the person and the arm
- talk about rationale for badminton
- 



Kinematics is the study of the movement of an object in space. It can be used to predict the movement of

This project aims to use wearable sensors to classify shots in the game of badminton. Badminton was chosen as it incorporates aspects of speed and strategy with lots of rapid dynamic movements of the hand, wrist and arm to classify. 

badminton has many types of shots used in different circumstances throughout the game. Some of these shots such as the smash and clear take a lot of power to either go a long distance or to travel at a fast speed. In other situations it would be more appropriate to use a drop or net-shot to slow down the pace or catch the opponent of guard these shots are much slower. This project aims to use inertial sensors to generate data while performing these shots and analyse this data to successfully classify different shots. 

- smash - a fast overhead shot which sends the shuttlecock downward at a steep angle. This requires the shuttlecock to be high in the ai
- clear - a powerful shot designed to land the shuttlecock at the rear of the court concentrating more on distance than speed. 
- drop - a slow shot from the midcourt designed to drop the shuttlecock just over the net
- net-shot - a slow deceptive shot from the very front of the court intended to just roll the shuttlecock over the net
- serve - It is the first shot in a rally and must come from below the waist of the player this is to ensure it is not too powerful giving the opponent an opportunity to return it
- forehand + backhand - any of these shots can be executed forehand or backhand. This depends on the position of the player with respects the the shuttlecock. for a backhand shot the racket is held across the body and these shots are generally less powerful.







--- Literature Review

sports tracking with video, sensors for heart rate and so on and ofc IMUs. ---> studies that mention use of IMUs for tracking less-sporty activities and basic sports --> using IMUs for sports (tennis, kendo)... --> using sensors for tracking badminton ---> classification methods starting with least relevent like deep neural networks ---> then onto SVM and similar ---> finally onto a system that checks may different ways (MATLAB Learner) --> then onto kinematic analysis for sports in general and if possible for racket sport mention emphasis on working out the impact on the muscle.



___

Using technology to track sports has been a popular topic in recent years to aid in training and coaching and to get the upper hand in competitive sports. Some studies [https://ieeexplore-ieee-org.sussex.idm.oclc.org/document/9906970, https://www.redalyc.org/pdf/3010/301049620005.pdf, ] have implemented video analysis to better understand how athletes can improve their game. This method proves to be effective, however it can take lab like conditions and specialist technology [https://www.mdpi.com/1424-8220/20/6/1683]. The use of wearable biometric sensors has also grown. [these people*] have analysed physiological responses to sports such as heart rate and blood oxidisation in order to better understand an athletes performance. Various studies [<find one> ] have used inertial measurement units (IMUs) for motion tracking in a sports context. In light of a desire for wearability and commercial viability, primary considerations identified in these papers includes costs, intrusiveness, power consumption and communication with the IMU sensors. It is key for this project that the sensors worn by the players do not inhibit their ability to execute certain shots as this would affect the quality of the data. A low power consumption is also important as the sensors will need to be recording data for extended periods of time. [https://ieeexplore.ieee.org/abstract/document/7847813] Covers the design of an IMU to measure the movement and rotation of the elbow when playing badminton.

There are a range of IMUs such as the Xsens MTi-G-700,  Xsens MTw Awinda and ICM-20649 to name a few. They are designed for specific uses and to maintain good performance while at high dynamics and under vibrations and high-impacts [https://www.xsens.com/hubfs/3446270/Downloads/Manuals/MTwAwinda_WhitePaper.pdf]. The units are available with various sensors such as ITG-3200 MEMS,  LIS3MDL and ICM-20649 gyroscopes, ADXL345 triple-axis accelerometer and L3GD20H Magnetometer. In any case it is necessary for the IMUs to have all three components: accelerometer, gyroscope, and magnetometer to track motion in 3D space. This project will be making use of the BlueSense2 IMUs designed by Daniel Roggen in house at the University of Sussex. These units were designed for 'sensor-based human activity recognition' [https://www.ewsn.org/file-repository/ewsn-2018/177_178_roggen.pdf] with a non-intrusive design, 'minimised CPU power consumption' modes and high sample rate making them ideal for fast-paced sports. With specific mention of the use of the MPU925 for 3D accelerometer, gyroscope and magnetometer to provide a better sample rate than off the shelf solutions such as the Xsens MTw. 



Kinematics is a branch of physics concerned with the motion of objects. Kinematic analysis has been used widely from animation for movies and games,[https://ieeexplore.ieee.org/abstract/document/4057202, https://journals.sagepub.com/doi/full/10.1177/1754337120965444 ] to designing rehabilitation methods and injury prevention [https://www.jospt.org/doi/abs/10.2519/jospt.1996.23.5.294, https://ieeexplore.ieee.org/abstract/document/8009339, https://ieeexplore.ieee.org/abstract/document/7460890, https://www.sciencedirect.com/science/article/pii/S2095254612000427 ]. Many of these papers use motion capture methods or video analysis, which, while effective, can be costly and challenging to implement. These methods often take novel setups and unique technology. This project will carry out a kinematic analysis of the arm while playing badminton. IMUs will be used to better understand the load on the arm and joints with the ultimate aim being to better understand how an athlete can change technique or train to reduce chance of injury. Recent advancements in IMU technology[https://www.xsens.com/hubfs/3446270/Downloads/Manuals/MTwAwinda_WhitePaper.pdf] and in kinematic analysis using IMUs have allowed for low cost and easy implementation for clinical evaluations on joints. [opening] up potential for analysis of the motion of top performing athletes [https://www.mdpi.com/1424-8220/20/6/1683]. Kinematic analyses of badminton in particular can be found in papers by M Kwan et al [https://link.springer.com/article/10.1007/s12283-010-0053-0] where the motion and responses of the players are studied while performing different shots. 

The ultimate aim of this project is to develop a method that can classify different badminton shots with a high accuracy. To do this various algorithms will be used and fine tuned. Common algorithms for analysing data from IMUs include Dynamic Time Warping (DTW) methods, and machine learning theory based algorithms such as Support Vector Machines (SVM),  and K-Nearest Neighbour (KNN) [https://ieeexplore.ieee.org/document/8231736, https://ieeexplore.ieee.org/document/7370311, https://ieeexplore-ieee-org.sussex.idm.oclc.org/document/8730861]. DTW Methods used by R Srivastava et al [ ] achieved 90% classification accuracy for tennis shots using IMUs, The key to this success was a novel method of 'Quaternions based Dynamic Time Warping (QDTW)' Using calculated quaternions from gyroscope data. A Similar method could be adopted for this project. Other papers use early adopted machine learning methods such as SVM and KNN. These methods, while effective, do have some downsides. Often, with machine learning, large data sets are needed to help the algorithms identify redundant patterns. The data set collected for this project will be relatively small and the presence of noise may cause these algorithms to misclassify. 







Various methods have been used to classify movement using data from IMUs. [these people] develop a system to classify different tennis shots from IMU accelerometer 



   







___

Progress to date:

**Initial stages** --- Calibration and setup

For this project the BlueSense2 units were provided. The first task was to understand the data that the sensors on the unit collect and how this data can be used. The unit contains the MPU-9250 Nine-Axis (Gyro + Accelerometer + Compass) MEMS from TDK InvenSense. the axes can be seen in figure.



![image-20241026153701101](C:\Users\Derry\AppData\Roaming\Typora\typora-user-images\image-20241026153701101.png)

The initial setup for this IMU consisted of formatting the SD card, setting the logging format, setting the ranges for the accelerometer and gyroscope, carrying out a correction for the magnetometer, and setting the quaternion filter parameters. This was key to do before using the sensors to log data. The setup guide was provided by Daniel Roggen and will be attached in the appendix. Two pieces of software developed by Daniel Roggen are key to this project. Firstly, the BlueSense Manager Application, this application allows for the testing and synchronisation of the sensors. Synchronisation is key when using multiple sensors for kinematic analysis and for identifying the quaternions. This app was used initially on the first day of the project to test sensors' ability to record data. The BlueSense Manager app allows you to run certain motion capture modes and outputs the results live to a terminal window. The second app developed with these IMUs in mind is the DScopeQT app developed by Daniel, this acts as digital oscilloscope of sorts and can be connected to the BlueSense2 IMUs to plot the accelerometer, gyroscope and magnetometer data live.

After initial testing with the BlueSense Manager and successfully setting up the IMUs, the next objective was to record some basic data and log it to the SD Cards. To do this a terminal was used, in this case the Termite App connected to the BlueSense through Bluetooth 2.0. The unit was designed with various motion sensing modes that record using different sensors,  sample rates, and bandwidths. Figure bl shows the details of the different motion sensing modes.

![image-20241026161241851](C:\Users\Derry\AppData\Roaming\Typora\typora-user-images\image-20241026161241851.png)

For the initial tests, mode 38 was chosen due to it having a relatively slow sample rate and thus smaller power consumption. It was sufficient as less data is required for initial tests. The first test carried out was to log the data directly to the terminal to identify how the unit displays the data. It was seen that the data logs in columns: the first four represent the packet counter, time stamp, battery voltage in mV, and label number. The next 9 represent the X, Y and Z axes for the accelerometer, the gyroscope, and the magnetometer respectively.  This is needed to identify what information is useful for data analysis. The final part of this initial test was to record the data to the SD card. Instructions for this can be found in the quick start guide (see appendix). To test the accelerometer and gyroscope the first motion tested was a simple rotation around an axis. This data was then plotted on a graph of accelerometer readings against time. The following figure shows the raw data along with the plot. 



<> 

It can be seen that the acceleration reaches maximum and minimums for the <> and <> axes 90 degrees out of phase as the unit is spun. The other axis is almost flat other than some predictable noise and vibrations. This makes sense as two axes are rotating up and down against gravity and the pivot axis is stable.

The next step was to test the maximum and minimum reading on each axis for the accelerometers to make sure both sensors are calibrated correctly. A even more simple motion sense mode was used for this task as it was only analysing the accelerometer reading. Mode 19 was used for a 100Hz sample rate using just the accelerometer. The results for both the sensors are shown in figure blah. 



It is clear from this data that one of the sensors seems to be generating values much higher than expected for the accelerometer readings. To help confirm this a plot was created to show the maximum, minimum, and range of the data. It is clear that the unit labelled [8BFA] had problems with the accelerometer having much larger results for the z axis and somewhat larger results for the x and y axes, with a large range of results. It can be seen from previous data collected that $\pm 1g$ is represented by $\pm 2000$ whereas the z axis on the faulty unit shows ~3600 for 1g and ~400 for -1g. To resolve this  the sensor was sent back to either be replaced or to be recalibrated. 





**Testing accelerometer** --- Basic plots and graphs

The next stage was to use the sensors to record some very basic movements and use the data to plot the motion of the unit in 3D space. The first of the two methods employed for this task was to use SUVATs to find the displacement and plot it against time. Use
$$
v = u +at
$$
to find how the velocity (v) changes with time, and to use this velocity along with:
$$
s = ut +\frac{1}{2}at^2
$$
to find the displacement. The data was recorded at 100hz, to find the velocity as it changes with time take U to initially be 0 and add the accelerometer reading multiplied 1/100, for the next reading take U as the previous velocity reading. This way an array of velocities can be generated at each timestamp. The next stage is to find the displacement using these velocities and equation 2. The displacement can be plotted on a tri-axis graph with each axis representing a dimension x,y and z direction. The result for this first method can be seen in the following figure:



The alternative method was to use integration to first find the velocity from accelerometer readings, and integrate this again to obtain the displacement. To do this the cumtrapz library was used with python and matplotlib to plot these results the graph for this can be seen in the following figure:



This task did not produce the expected results. When tracking the displacement with no respect to gyroscope data it is a challenge to track its movement in 3D space. When recording this data the units were not rotated for this reason yet the results still don't accurately show the displacement. 

 

**Testing gyroscope** --- DScopeQT 

The final task carried out with the units was to test the gyroscope data. It was hard to classify the gyroscope data by just logging it to the SD cards and plotting a static graph as the results represent a degree/second turn. The easiest way to test this would be to move the gyroscope and see the effect of this in real time. To do this the DScopeQT app was used. The units were connected and formatted to only log the gyroscope data to a scope. I then rotated the units to identify the gyroscope data. From this quick visual analysis it seemed that the gyroscopes were working correctly on both sensors.



___

Project plan:

There is many challenges to overcome and tasks to complete for the rest of this project, The main objectives can be broken down into just a few major categories:

- Calibration
- Data Acquisition
-  

 the first objective will be to complete the calibration of the two sensors. Once the faulty sensor issue is solved basic calibration will need to carried out on it just to confirm the limits of the gyroscope and accelerometer. After this the sensors will be synced using the BlueSense Manager.

 

IMU basic:



https://ieeexplore-ieee-org.sussex.idm.oclc.org/document/9684631

Kinematic good papers: 

https://www.sciencedirect.com/science/article/abs/pii/S0925231215001472

https://journals.sagepub.com/doi/abs/10.1177/1754337120965444











**[BO: J. Zenko, M. Kos and I. Kramberger, "Pulse rate variability and blood  oxidation content identification using miniature wearable wrist device", *International Conference on Systems Signals and Image Processing (IWSSIP)*, pp. 1-4, 2016.  **

**HR:   H. Fukushima, H. Kawanaka, M. S. Bhuiyan and K. Oguri, "Estimating heart  rate using wrist-type Photoplethysmography and acceleration sensor while running", *Annual International Conference of the IEEE Engineering in Medicine and Biology Society*, pp. 2901-2904, 2012. ]**  *





___



Various studies cover the use if IMUs for activity recognition mentioning the "compact size, low-power requirement and non-intrusiveness" ==something about the use of these sensors for tracking daily life== 



 in particular [cite] uses one inertial sensor attached to the wrist to classify shots in tennis. This paper mentions the limitations of using just one sensor in calculating spin, speed and trajectory of serve. <my project> will use .... The sampling rate used for this study was 25Hz this may work for tennis however badminton is faster... 



These papers [cite] use a SVM method for feature extraction and classification. They found that this algorithm gave the best accuracy ==various others methods for classification + machine learning (deep neural network) talk about how mine will be way less data. maybe talk about MATLAB Classification learner app.



Kinematic analysis 























___





___



[ https://ieeexplore.ieee.org/document/7370311]: 
