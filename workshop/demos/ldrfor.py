import mraa, time
ldr = mraa.Aio(5)
media = 0
try:
	for i in range(1,6):
		x = ldr.read()
		print (x)
		time.sleep(0.3)
		media += x
	print "Media de %i leituras: %.0f" %(i,media/5) 
except KeyboardInterrupt:
	print "\nYou are now leaving the program"
except:
	 print ("\nThis exception was not treated")
