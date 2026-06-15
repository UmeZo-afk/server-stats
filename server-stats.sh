#!/usr/bin/env bash

set -euo pipefail

echo "SERVER STATS"

echo "Hostname: $(hostname)"
echo "Date:     $(date)"
echo "Uptime:   $(uptime -p)"

echo ========================================

echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " 100 - $8 "%"}'

echo ========================================

echo "Memory Usage:"
free -h | awk '/Mem:/ {
print "Total: " $2
print "Used: "  $3
print "Free: "  $4
}'

echo ========================================

echo "Disk Usage:"
df -h / | awk 'NR==2 {
print "Total: " $2
print "Used: "  $3
print "Free: "  $4
print "Usage: " $5
}'

echo ========================================

echo "Top directories in /var:"
du -xh /var --max-depth=1

echo ========================================

echo "Inode Usage:"
df -i / | awk 'NR==2 {
print "Total: " $2
print "Used: "  $3
print "Free: "  $4
print "Usage: " $5
}'

echo ========================================

echo "Top 5 Processes by CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo ========================================

echo "Top 5 Processes by Memory:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
