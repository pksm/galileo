#! /usr/bin/python
import mraa as m, time as t
led = m.Gpio(8)
btn = m.Gpio(2)
led.dir(m.DIR_OUT)
btn.dir(m.DIR_IN)
try:
   state = False
   while(1):
        #led.write(state)
        if (btn.read()):
                state = not state
        led.write(state)
        t.sleep(0.1)

except KeyboardInterrupt:
        print "\nExiting program..."
        led.write(0)
except Exception as ex:
        print "Exception not treated...\n"
        print ex
