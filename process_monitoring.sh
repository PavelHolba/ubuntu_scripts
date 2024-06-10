#!/bin/bash

current_processes=$(ps aux)

check_new_processes() {
    new_processes=$(ps aux)
    while read -r line; do
        # Extract the user name, cpu, mem and process name from the process line
        user=$(echo "$line" | awk '{print $1}')
        cpu=$(echo "$line" | awk '{print $3}')
        mem=$(echo "$line" | awk '{print $4}')
        process=$(echo "$line" | awk '{print $11}')

        # Ignore processes owned by root, systemd+, message+, polkitd, and syslog
        if [[ "$user" != "root" && "$user" != "systemd+" && "$user" != "message+" && "$user" != "polkitd" && "$user" != "syslog" ]]; then
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