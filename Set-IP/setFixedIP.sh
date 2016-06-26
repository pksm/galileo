#! /bin/sh
#
# Set static IP for Intel Galileo Gen 2 that uses Connman as its Network Manager
#
# Author: pksm
# Date: 23 Jun 2016
#

MAC="$(cat /sys/class/net/enp0s20f6/address | cut -d':' -f1-6 --output-delimiter='')"
ip=192.168.99.10
netmask=255.255.255.0
gateway=192.168.99.1
PROGRAM=`basename $0`
VERSION=1.0

#functions
error()
{
        echo "$@" 1>&2
        usage_and_exit 1
}
usage()
{
        echo "Usage: $PROGRAM [--ipv4] [--help] [--version] [static |dhcp | default] [ip_adress] [netmask] [gateway]"; echo
        echo "Examples:" ; echo
        echo $'\t' "scriptName -ipv4 static 192.168.35.12 255.255.255.0 192.168.35.1"; echo
        echo $'\t' "scriptName -ipv4 dhcp"; echo
        echo $'\t' "scriptName -ipv4 default"; echo
}
usage_and_exit()
{
        usage
        exit $1
}
version()
{
        echo "$PROGRAM version $VERSION"
}
dhcp_connect()
{
        connmanctl config ethernet_"$(echo $MAC)"_cable --ipv4 dhcp
        connect
}
static_connect()
{
        connmanctl config ethernet_"$(echo $MAC)"_cable --ipv4 manual "$(echo $ip)" "$(echo $netmask)" "$(echo $gateway)"
        connect
}
connect()
{
        connmanctl disconnect ethernet_"$(echo $MAC)"_cable 2> /dev/null
        connmanctl connect ethernet_"$(echo $MAC)"_cable
}

# Check if at least one argument is passed 
if [ -z "$1" ]; then
        usage_and_exit
fi

# Check if given first argument is valide
case $1 in
        --help | --h | -help | -h )
                usage_and_exit 0
                ;;
        --version | -version | --v | -v )
                version
                exit 0
                ;;
        --ipv4 | -ipv4 )
                if test -z "$2"; then
                        echo Insufficient parameters supplied to the command
                        usage_and_exit
                elif [ "$2" = "static" ] && ([ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]); then
                        echo Insufficient parameters supplied to $2 option
                        usage_and_exit
                fi
                ;;
        * | -* | --* )
                error "Unknown option: $1"
                ;;
esac

# Check options for ipv4 parameter
case $2 in
        dhcp )
                dhcp_connect
                ;;
        default )
                echo Setting IP: $ip
                echo Setting Netmask: $netmask
                echo Setting Gateway: $gateway
                static_connect
                ;;
        static )
                ip=$3
                netmask=$4
                gateway=$5
                static_connect
                ;;
        * )
                error "Unknown option $2 for $1"
                ;;
esac
