import mraa, time, os
lm = mraa.Aio(1)
media = 0
try:
	for i in range(1,11):
		x =  (5.0 * lm.read() * 100)/1024
		time.sleep(0.5)
		print (round(x,2))
		media += x
	print "Tempratura media: %.2f oC, em %i leituras" %(media/10,i)
	cmd = "echo "+time.strftime('%X::%d/%m/%Y')+'::Reading::'+str(media/10)+ "oC >> logLM35.txt"
	os.system(cmd)	 
except KeyboardInterrupt:
	print "\nYou are now leaving the program"
except:
	 print ("\nThis exception was not treated")
