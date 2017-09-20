#!/bin/bash

logdir=/var/log/usage/$(date +"%Y/%m/%d")
uptime_log="$logdir/uptime.log"
process_log=$logdir/process.log
memory_log=$logdir/memory.log
disk_log=$logdir/disk.log

mkdir -p $logdir

uptime >> $uptime_log

printf "\n\nStarting memory monitor [$(date +"%H:%M:%S")]" >> $memory_log
printf "\n\nFREE -M OUTPUT [$(date +"%H:%M:%S")]:\n" >> $memory_log
free -m >> $memory_log
printf "\n\nCAT /PROC/MEMINFO OUTPUT [$(date +"%H:%M:%S")]:\n" >> $memory_log
cat /proc/meminfo >> $memory_log
printf "\n\n VMSTAT -S OUTPUT [$(date +"%H:%M:%S")]:\n" >> $memory_log
vmstat -s >> $memory_log
printf "\n\n TOP OUTPUT [$(date +"%H:%M:%S")]:\n" >> $memory_log
top -b -n1 >> $memory_log

printf "\n\nStarting processes monitor [$(date +"%H:%M:%S")]" >> $process_log
printf "\n\nTop 10 Processes with Higher Processor Consumption  OUTPUT [$(date +"%H:%M:%S")]:\n" >> $process_log
ps -e -o pcpu,pmem,args --sort=pcpu | cut -d" " -f1-5| tail >> $process_log
printf "\n\nPS -AUX OUTPUT [$(date +"%H:%M:%S")]:\n" >> $process_log
ps -aux >> $process_log
printf "\n\nPS -E OUTPUT [$(date +"%H:%M:%S")]:\n" >> $process_log
ps -e >> $process_log
printf "\n\nPSTREE OUTPUT [$(date +"%H:%M:%S")]:\n" >> $process_log
pstree >> $process_log
printf "\n\nPS -ejH OUTPUT [$(date +"%H:%M:%S")]:\n" >> $process_log
ps -ejH >> $process_log
printf "\n\nPS -eLf OUTPUT [$(date +"%H:%M:%S")]:\n" >> $process_log
ps -eLf >> $process_log

printf "\n\nStarting processes monitor [$(date +"%H:%M:%S")]" >> $disk_log
printf "\n\nDF -H OUTPUT [$(date +"%H:%M:%S")]:\n" >> $disk_log
df -h >> $disk_log