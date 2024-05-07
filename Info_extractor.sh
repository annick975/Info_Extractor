#!/bin/bash

while true; do
    # Display menu
    echo "Choose an option:"
    echo "1. Identify the system's public IP"
    echo "2. Identify the private IP address assigned to the system's network interface"
    echo "3. Display the MAC address (masking sensitive portions for security)"
    echo "4. Display the percentage of CPU usage for the top 5 processes"
    echo "5. Display memory usage statistics: total and available memory"
    echo "6. List active system services with their status"
    echo "7. Locate the Top 10 Largest Files in /home"
    echo "8. Exit"

    read -p "Enter your choice (1-8): " choice

    case "$choice" in
        1)
            # Task 1: Identify the system's public IP
            public_ip=$(curl -s ifconfig.me)
            echo "Public IP Address: $public_ip"
            ;;
        2)
            # Task 2: Identify the private IP address assigned to the system's network interface
            private_ip=$(hostname -I | awk '{print $1}')
            echo "Private IP Address: $private_ip"
            ;;
        3)
            # Task 3: Display the MAC address (masking sensitive portions for security)
            mac_address=$(ip link show | awk '/ether/ {print $2}')
            masked_mac=$(echo "$mac_address" | sed 's/..:..:..:..:..:../XX:XX:XX:XX:XX:XX/')
            echo "MAC Address: $masked_mac"
            ;;
        4)
            # Task 4: Display the percentage of CPU usage for the top 5 processes
            top_processes=$(ps aux --sort=-%cpu | head -n 6)
            echo -e "\nTop 5 CPU-consuming processes:"
            echo "$top_processes"
            ;;
        5)
            # Task 5: Display memory usage statistics: total and available memory
            memory_stats=$(free -h | awk '/^Mem:/ {print "Total: " $2, "Available: " $NF}')
            echo -e "\nMemory Usage:"
            echo "$memory_stats"
            ;;
        6)
            # Task 6: List active system services with their status
            services_status=$(systemctl list-units --type=service --state=running --no-pager)
            echo -e "\nActive System Services:"
            echo "$services_status"
            ;;
        7)
            # Task 7: Locate the Top 10 Largest Files in /home
            largest_files=$(find /home -type f -exec du -h {} + | sort -rh | head -n 10)
            echo -e "\nTop 10 Largest Files in /home:"
            echo "$largest_files"
            ;;
        8)
            echo "Exiting the program. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 8."
            ;;
    esac
done
