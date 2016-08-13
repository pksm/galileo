import mraa, time, os
lm = mraa.Aio(1)
media = 0
try:
   while(True):
	x = (5.0 * lm.read() * 100.0)/1024
	#x = lm.readFloat()
	print ("%.2f") %x
	time.sleep(1)
except KeyboardInterrupt:
	print "\nYou are now leaving the program"
except:
	 print ("\nThis exception was not treated")
