import serial
import numpy as np
from matplotlib import pyplot as plt
ser = serial.Serial('COM7',115200)
 
plt.ion() # set plot to animated
 
ydata = [1,5,4,7,896,35,2,14,5,8,6,4,6,96,26,4,684,41,564,65,4,546874,84,64]
ax1=plt.axes()  
 
# make plot
line, = plt.plot(ydata)
plt.ylim([10,40])
 
# start data collection
while True:  
        for i in range(1000):
            ydata.append(i)
            del ydata[0]
            line.set_xdata(np.arange(len(ydata)))
            line.set_ydata(ydata)  # update the data
            plt.draw() # update the plot
