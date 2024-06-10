#!/bin/bash

current_processes=$(ps aux)

check_new_processes() {
    new_processes=$(ps aux)
    while read -r line; do
        # Extract the user name, cpu and mem from the process line
        user=$(echo "$line" | awk '{print $1}')
        cpu=$(echo "$line" | awk '{print $3}')
        mem=$(echo "$line" | awk '{print $4}')
        # Extract the process name which is the rest of the line
        process=$(echo "$line" | awk '{print substr($0,index($0,$11))}') 

        # Ignore processes owned by root, systemd+, message+, polkitd, and syslog
        if [[ "$process" != "ps aux" && "$user" != "root" && "$user" != "systemd+" && "$user" != "message+" && "$user" != "polkitd" && "$user" != "syslog" ]]; then
            if ! echo "$current_processes" | grep -q "$line"; then
                echo "New Process Detected: $line"
            fi
        fi
    done <<< "$new_processes"
}

while true; do
    check_new_processes
    sleep 5
done