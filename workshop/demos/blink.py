import mraa as m, time as t
led = m.Gpio(8)
led.dir(m.DIR_OUT)

try:
   while(1):
        led.write(1)
        t.sleep(1) #delay de 200ms
        led.write(0)
        t.sleep(1)

except KeyboardInterrupt:
        print "\nExiting program..."
except Exception as ex:
        print "Exception not treated...\n"
        print ex
