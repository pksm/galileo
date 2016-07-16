import mraa, time
ldr = mraa.Aio(5)
try:
	while(1):
		x = ldr.read()
		print (x)
		time.sleep(0.3)
except KeyboardInterrupt:
	print "\nYou are now leaving the program"
except:
	 print ("\nThis exception was not treated")
