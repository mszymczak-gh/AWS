#!/bin/bash

URL="https://testingstaticwebsite.co.uk"
REQUESTS=100

for (( i=1; i<=$REQUESTS; i++ ))
do
   echo "Request $i"
   curl -s -o /dev/null -A "Mozilla/5.0" $URL
   # Optional: Remove or reduce this sleep for faster requests
   sleep 0.1
done
