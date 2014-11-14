# -*- coding: cp1250 -*-
import serial
import numpy as np
from matplotlib import pyplot as plt

ser = serial.Serial('COM7', 115200)

plt.ion() # set plot to animated

ydata = [0]*128

ax1=plt.axes()  

# Now we start the plot. To make matplotlib aware of more incoming data don’t forget the comma after ‘line': 
# make plot
#line = plt.plot(ydata)
plt.ylim([10,40]) # set the y-range to 10 to 40

# start data collection
while True:  
    data = ser.readline()        # read data from serial 
   
    
    print("----------------------------------------------------------")

    ydata = [int(x) for x in data.split(',')[1:-1]]
    print(ydata)
    print ("\n")
    print(len(ydata))
    ymin = 0
    ymax = 50000
    plt.ylim([ymin,ymax])
    line.set_xdata(len(ydata))
    line.set_ydata(ydata)  # update the data
    plt.draw() # update the plot
    
ser.close()    
