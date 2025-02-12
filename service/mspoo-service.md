# SCRIPT.sh


#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Make sure that 'ip' command is available
if ! command -v ip &> /dev/null; then
    echo "'ip' command not found. Please install it and try again."
    exit 1
fi

# Determine primary network interface
get_primary_interface() {
    INTERFACE=$(ip route | grep default | awk '{print $5}' | head -n 1)
    
    if [ -z "$INTERFACE" ]; then
        echo "No network interface found."
        exit 1
    fi
}

# Generate random MAC address
generate_random_mac() {
    echo -n "02" # Locally administered address (LAA) and unicast address
    for i in {1..5}; do
        printf ":%02x" $((RANDOM % 256))
    done
    echo # Ensure a newline at the end
}

# Spoof MAC address
spoof_mac() {
    # Get the primary network interface
    get_primary_interface

    # Generate a random MAC address
    NEW_MAC=$(generate_random_mac)

    echo "Spoofing MAC address for interface $INTERFACE with new MAC: $NEW_MAC"

    # Bring the network interface down
    if ! ip link set dev $INTERFACE down; then
        echo "Failed to bring down the network interface."
        exit 1
    fi

    # Change the MAC address
    if ! ip link set dev $INTERFACE address $NEW_MAC; then
        echo "Failed to change the MAC address."
        exit 1
    fi

    # Bring the network interface back up
    if ! ip link set dev $INTERFACE up; then
        echo "Failed to bring up the network interface."
        exit 1
    fi

    # Display the new MAC address
    ip link show $INTERFACE | grep ether
}

# Execute
spoof_mac






# SYSTEMD.service


[Unit]
Description=MSPOO MACSpoofing Service

After=network-online.target

Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/mspoo.sh

Restart=on-failure

RestartSec=3

[Install]
WantedBy=multi-user.target