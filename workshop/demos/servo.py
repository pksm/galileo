
import mraa
import time
from numpy import arange
x = mraa.Pwm(6)
x.period_ms(7)
x.enable(True)
time.sleep( 3 )
while True:
  for i in arange(0.1, 0.38, 0.05): #best range for micro servo SG90 on Intel Galileo Gen2 
    print i
    x.write(i)
    time.sleep(3)
