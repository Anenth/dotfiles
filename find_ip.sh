#!/bin/bash

echo "Starting ARP scan to discover devices on macOS..."

# Find the default network interface name using the routing table
interface=$(route -n get default | awk '/interface:/{print $2}')

if [[ -z "$interface" ]]; then
    echo "Error: Could not determine the default network interface."
    echo "Please ensure your Mac is connected to a network (Wi-Fi or Ethernet)."
    exit 1
fi

echo "Scanning network on interface: $interface"

# Install arp-scan if it's not already installed
if ! command -v arp-scan &> /dev/null; then
    echo "arp-scan is not installed. Installing with Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install arp-scan
    if ! command -v arp-scan &> /dev/null; then
        echo "Error: arp-scan installation failed. Please install it manually or check your Homebrew installation."
        exit 1
    fi
fi

# Perform ARP scan
sudo arp-scan --interface="$interface" --localnet

echo "ARP scan complete."
