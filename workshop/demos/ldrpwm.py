import mraa, time
ldr = mraa.Aio(5)
led = mraa.Pwm(3)
led.period_us(500)
led.enable(True)
try:
	while(1):
		x = ldr.read()
		print (x)
		print ("Tensao no sensor %.2f V" % (5-(x*(5.0/1023))))
		res = round(((x*0.5)/512),2)
		pwm = 1 - res
		led.write(pwm)
		time.sleep(0.5)
except KeyboardInterrupt:
	print "\nYou are now leaving the program"
except:
	print ("\nThis exception was not treated")
