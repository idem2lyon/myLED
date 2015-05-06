# myLED + myMonitoring

Guess your scripts are in /opt/scripts

Add in personnal crontab ($ crontab -e) this line :

* * * * * /opt/scripts/myMonitoring.sh >> /dev/null 2>&1

And in /etc/crontab :
@reboot root    /opt/scripts/myMonitoring.sh

