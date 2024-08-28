#!/bin/bash

# Load variables from the .env file
source .env

# Check if the INTERFACE variable is set
if [ -z "$INTERFACE" ]; then
  echo "The INTERFACE variable is not set in the .env file."
  exit 1
fi

# Execute the commands using the interface name from the .env file
sudo ip link add link "$INTERFACE" name "$INTERFACE".10 type vlan id 10
sudo ip link add link "$INTERFACE" name "$INTERFACE".20 type vlan id 20
sudo ip link set dev "$INTERFACE".10 up
sudo ip link set dev "$INTERFACE".20 up

echo "VLAN interfaces $INTERFACE.10 and $INTERFACE.20 have been created and set up."
