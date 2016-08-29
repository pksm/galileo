'''
   'hello world!' of hardware projects
   Blink LED on pin #8 of Intel Galileo Gen 2
   
   Keyboard interrupt exception (CTRL+C) treated, so quiting the program should return the message 'Exiting program...' on terminal
'''
import mraa as m, time as t
led = m.Gpio(8)
led.dir(m.DIR_OUT)

try:
   while(1):
        led.write(1)
        t.sleep(1) #delay 1 second
        led.write(0)
        t.sleep(1)

except KeyboardInterrupt:
        print "\nExiting program..."
except Exception as ex:
        print "Exception not treated...\n"
        print ex
