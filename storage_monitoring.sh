#!/bin/bash

storage=$(df -H)
while read -r line; do
    mounted_on=$(echo "$line" | awk '{print $6}')

    if [[ "$mounted_on" == "/" ]]; then
        use=$(echo "$line" | awk '{print $5}' | tr -d '%')
        if [ "$use" -gt 50 ]; then
            echo "pomoc"
        fi
    fi
done <<< "$storage"