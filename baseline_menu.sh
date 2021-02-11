#!/bin/bash

#baseline_menu

# v1.0 by sVen Mueller

## This script creates dynamic baseline traffic



clear

echo "Traffic Baselining"

echo

#IP=$1

IP="juiceshop.f5agility.com"

#if [ "$IP" == "" ]

# then

#        #echo -n "Enter Target IP as an Argument"

#        #exit

#fi



BASELINE='Please enter your type of baselining: '

options=("increasing" "alternate" "Quit")

select opt in "${options[@]}"

do

        case $opt in

                "increasing")

                        while true; do

                                clear

                                echo "Hourly increasing HTTP traffic: $IP"

                                echo

				for i in $(eval echo "{0..`date +%M`}")

                                        do

                                                curl -k -0 --interface 10.1.10.100 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" https://$IP`shuf -n 1 ./source/urls.txt`

                                                curl -k -0 --interface 10.1.10.100 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  https://$IP`shuf -n 1 ./source/urls.txt`

                                                curl -k -0 --interface 10.1.10.100 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  https://$IP`shuf -n 1 ./source/urls.txt`

                                                #curl -0 -s -o /dev/null -A "`sort -R ./source/useragents_with_bots.txt | head -1`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" https://$IP`sort -R ./source/urls.txt | head -1`

                                        done

                                #sleep 0.1

                        done

                ;;

                "alternate")

                        while true; do

                                clear

                                echo "Hourly alternate HTTP traffic: $IP"

                                echo

                                #if (( {`date +%k` % 2} )); then

                                if (( `date +%k` % 2 )); then

                                        for i in {1..100};

                                                do

                                                        curl -k -0 --interface 10.1.10.100 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`" -w "High:\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" https://$IP`shuf -n 1 ./source/urls.txt`

                                                        curl -k -0 --interface 10.1.10.100 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  https://$IP`shuf -n 1 ./source/urls.txt`

                                                        curl -k -0 --interface 10.1.10.100 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  https://$IP`shuf -n 1 ./source/urls.txt`

#                                                	curl -k -0 -s -o /dev/null -A "`sort -R ./source/useragents_with_bots.txt | head -1`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" https://$IP`sort -R ./source/urls.txt | head -1`

                                                done

                                else

                                        for i in {1..50};

                                                do

                                                        curl -k --interface 10.1.10.100 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`" -w "High:\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" https://$IP`shuf -n 1 ./source/urls.txt`

                                                        curl -k --interface 10.1.10.100 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  https://$IP`shuf -n 1 ./source/urls.txt`

                                                        curl -k --interface 10.1.10.100 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  https://$IP`shuf -n 1 ./source/urls.txt`

                                                #curl -0 -s -o /dev/null -A "`sort -R ./source/useragents_with_bots.txt | head -1`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" https://$IP`sort -R ./source/urls.txt | head -1`

                                                done

                                fi

                                #sleep 0.1

                                clear

                        done

                ;;

                "Quit")

                        break

                ;;

        *) echo invalid option;;

    esac

done


