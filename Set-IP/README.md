##Setting a static connection between Intel(R) Galileo and PC

###### Why use this approach?
- Access to the Linux terminal of your embedded device
- Does not require the use of not so common cables like FTDI/USB
- Direct connection to the board

###### Requirements
* Ethernet Cable
* SSH Client (like PuTTY)
* ConnMan Network Manager (running on your embedded OS) 

**Please notice that the provided shell script was writed based on ConnMan as the network manager of Intel(R) Galileo Gen 2. If this is not your OS's network manager, some modifications in the *.sh file will be needed.**

#### Running shell script
The script is meant for embedded devices. You can clone the whole project or just paste&copy the script on your devices's editor.
Before running, you must assign 'Execute' permission to the *.sh file.
  ```shell
    chmod +x *.sh 
  ```
Where * is the name of your file. 
If you cloned this repo, it should be setFixedIP.sh

##### Script Options
    -help -> show usage and examples
    -version -> print version 
    -ipv4 -> requires one of the following:
                static -> requires input of ip_address, netmask, default_gateway
                dhcp -> change Ethernet settings to DHCP
                default -> set static IP with suggest settings by the script
    -show -> display current settings for the Ethernet interface
    -reconnect -> useful if the service stopped or did not started when Ethernet cable was plugged in

#### Running batch files
All provided .bat scripts were tested on Windows 8.1 and requires system elevation (Run as administrator).
When double clicking the bat file, you will be prompted to provide administrator privileges.

##### setStaticIP.bat
A static IP for the host system (in this case Windows) along with a static IP for the embedded device is necessary for creating a local network that can communicate through SSH.

This bat file, sets a static IP for the host and saves a copy of your previous Ethernet interface settings in a text file located on your Desktop.

When running this script you will be prompted to insert your Ethernet Adapter interface's name; you can check that info in the output of ipconfig command, that is provided in the code.

##### setDHCP.bat
Most of the Ethernet settings has DHCP enabled, which allows the computer to use a dynamic IP provided by the router. 
If that's your case, you can simply run this file to change back from static mode.

If not, you can run the following code on CMD using the previous saved settings of your Ethernet interface. Your old configuration is an *.txt file on your Desktop.
  ```batch
    netsh interface ip set address Ethernet static saved_ip_address saved_subnetmask saved_default_gateway
  ```
