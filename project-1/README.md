Linux CPU Monitoring with Webex Alerts

A lightweight Bash-based monitoring solution that checks CPU utilization on a Linux server and sends real-time alerts to a Cisco Webex Space when CPU usage exceeds a defined threshold.

Features
Monitor CPU usage in real time
Configurable CPU threshold
Sends alerts to a Cisco Webex Space
Includes hostname and timestamp in alerts
Easy deployment using Cron
Lightweight and requires only Bash and cURL
Prerequisites
Linux Server (Ubuntu, CentOS, RHEL, Amazon Linux, etc.)
Bash Shell
cURL installed
Cisco Webex Bot
Webex Room ID

Verify cURL is available:

Shell
curl --version
 

Install if needed:

Shell
sudo apt install curl -y

or

Shell
sudo yum install curl -y
Project Structure
Plain Text
.
├── CPU-monitor.sh
└── README.md
Create a Webex Bot
Sign in to https://developer.webex.com
Navigate to My Apps
Create a new Bot
Copy the Bot Access Token
Add the bot to your Webex Space
Get the Webex Room ID

Bot token = "OWQ1YzIxN2UtODZmYy00NTJiLThmMzEtYTQ2NjVhNjFiZDA0YjA2MmNjMDYtMjVh_PI91_1d82aa80-3b51-4d67-9357-9945f90330e3"
room id = "Y2lzY29zcGFyazovL3VybjpURUFNOnVzLXdlc3QtMl9yL1JPT00vM2U4NGZkMDAtZDEzOS0xMWYxLTkyOTMtOWYyODVkZDliZWU2"


Test the alert first

curl -X POST https://webexapis.com/v1/messages \
-H "Authorization: Bearer OWQ1YzIxN2UtODZmYy00NTJiLThmMzEtYTQ2NjVhNjFiZDA0YjA2MmNjMDYtMjVh_PI91_1d82aa80-3b51-4d67-9357-9945f90330e3" \
-H "Content-Type: application/json" \
-d '{
    "roomId": "Y2lzY29zcGFyazovL3VybjpURUFNOnVzLXdlc3QtMl9yL1JPT00vM2U4NGZkMDAtZDEzOS0xMWYxLTkyOTMtOWYyODVkZDliZWU2",
    "text":"Hello from Linux Server"
}'

Script Configuration

Update the following variables in CPU-monitor.sh:

Shell
THRESHOLD=80
 
BOT_TOKEN="YOUR_WEBEX_BOT_TOKEN"
 
ROOM_ID="YOUR_WEBEX_ROOM_ID"
 
Monitoring Script
Shell
#!/bin/bash
 
THRESHOLD=80
HOSTNAME=$(hostname)
 
CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print int(100-$8)}')
 
BOT_TOKEN="YOUR_WEBEX_BOT_TOKEN"
ROOM_ID="YOUR_WEBEX_ROOM_ID"
 
if [[ "$CPU_USAGE" =~ ^[0-9]+$ ]] && [ "$CPU_USAGE" -gt "$THRESHOLD" ]; then
 
MESSAGE="High CPU Alert
Server: $HOSTNAME
CPU Usage: ${CPU_USAGE}%
Time: $(date)"
 
curl -s -X POST https://webexapis.com/v1/messages \
-H "Authorization: Bearer $BOT_TOKEN" \
-H "Content-Type: application/json" \
-d "{\"roomId\":\"$ROOM_ID\",\"text\":\"$MESSAGE\"}"
 
fi
Execution

Make the script executable:

Shell
chmod +x CPU-monitor.sh

Run manually:

Shell
./CPU-monitor.sh
Automate with Cron

Open crontab:

Shell
crontab -e

Run the script every minute:

Shell
* * * * * /root/devops/CPU-monitor.sh >> /var/log/cpu-monitor.log 2>&1

Verify cron jobs:

Shell
crontab -l
Monitoring Logs

View script execution logs:

Shell
tail -f /var/log/cpu-monitor.log
Sample Webex Alert
Plain Text
High CPU Alert
 
Server: ip-172-31-34-21
CPU Usage: 92%
Time: Mon Oct 26 17:30:00 IST 2026
Future Enhancements
Memory utilization monitoring
Disk usage monitoring
Service status monitoring
Multiple server alerts
Alert suppression to avoid duplicate notifications
Docker/Kubernetes monitoring integration
Email and Microsoft Teams notification support
Author

Uttam Singh
 Cloud & DevOps Engineer

GitHub: your-github-profile

License

This project is open-source and available under the MIT License.
