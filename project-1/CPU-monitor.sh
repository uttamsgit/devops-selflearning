#!/bin/bash

#just a demo script for monitor CPU and Trigger the alert in teams

THRESHOLD=2
HOSTNAME=$(hostname)

CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print int(100-$8)}')

BOT_TOKEN="OWQ1YzIxN2UtODZmYy00NTJiLThmMzEtYTQ2NjVhNjFiZDA0YjA2MmNjMDYtMjVh_PI91_1d82aa80-3b51-4d67-9357-9945f90330e3"
ROOM_ID="Y2lzY29zcGFyazovL3VybjpURUFNOnVzLXdlc3QtMl9yL1JPT00vM2U4NGZkMDAtZDEzOS0xMWYxLTkyOTMtOWYyODVkZDliZWU2"

echo "CPU_USAGE=$CPU_USAGE"

if [ "$CPU_USAGE" -gt "$THRESHOLD" ]; then

MESSAGE="High CPU Alert - Server: $HOSTNAME - CPU Usage: ${CPU_USAGE}% - Time: $(date)"

curl -s -X POST https://webexapis.com/v1/messages \
-H "Authorization: Bearer $BOT_TOKEN" \
-H "Content-Type: application/json" \
-d "{
  \"roomId\":\"$ROOM_ID\",
  \"text\":\"$MESSAGE\"
}"

fi


