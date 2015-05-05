#!/bin/sh

# This file is part of myLED.
#
# Use it as you want

### BEGIN INIT INFO
# Provides:          proc_monitor
# Required-Start:    $local_fs $network $remote_fs $jeedom
# Required-Stop:     $local_fs $network $remote_fs $jeedom
# Should-Start:      $NetworkManager $jeedom
# Should-Stop:       $NetworkManager $jeedom
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts process monitoring
# Description:       starts process monitoring using start-stop-daemon
### END INIT INFO

PROC_JEEDOM=`ps -ef | grep nodejs | grep jeedom`
LED_JEEDOM="verte"

INET=`ping -q -c 1 -W 1 8.8.8.8 >/dev/null && echo "0"`
LED_INET="rouge"

WIFI=`ping -q -c 1 -W 1 192.168.25.254 >/dev/null && echo "0"`
LED_WIFI="bleue"

Jeedom(){
  set -- ${PROC_JEEDOM}
  PID=$2
  if [ ! -z "$PID" ]  ; then
    /usr/bin/python /opt/scripts/myLED.py Allumer ${LED_JEEDOM}
    echo "OK" 
  else
    /usr/bin/python /opt/scripts/myLED.py Eteindre ${LED_JEEDOM}
    echo "KO"
  fi
}

Inetv4(){
  if [ ${INET} -eq 0 ] ; then
    /usr/bin/python /opt/scripts/myLED.py Allumer ${LED_INET}
    echo "IPv4 is up"
  else
    /usr/bin/python /opt/scripts/myLED.py Eteindre ${LED_INET}
    echo "IPv4 is down"
  fi
}

Wifi(){
  if [ ${WIFI} -eq 0 ] ; then
    /usr/bin/python /opt/scripts/myLED.py Allumer ${LED_WIFI}
    echo "Wifi is up"
  else
    /usr/bin/python /opt/scripts/myLED.py Eteindre ${LED_WIFI}
    echo "Wifi is down"
  fi
}


while true ; do
  Jeedom
  Inetv4
  Wifi
  sleep 30
done
