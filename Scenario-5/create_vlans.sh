#!/bin/bash

# Load variables from the .env file
if [ ! -f .env ]; then
  echo ".env file not found."
  exit 1
fi
source .env

# Check if the INTERFACE variable is set
if [ -z "$INTERFACE" ]; then
  echo "The INTERFACE variable is not set in the .env file."
  exit 1
fi

# Verify that the base interface exists
if ! ip link show "$INTERFACE" > /dev/null 2>&1; then
  echo "Base interface $INTERFACE does not exist."
  exit 1
fi

# Create VLAN interfaces
sudo ip link add link "$INTERFACE" name "$INTERFACE".10 type vlan id 10
if [ $? -ne 0 ]; then
  echo "Failed to create VLAN 10 interface."
  exit 1
fi

sudo ip link add link "$INTERFACE" name "$INTERFACE".20 type vlan id 20
if [ $? -ne 0 ]; then
  echo "Failed to create VLAN 20 interface."
  exit 1
fi

# Bring up the VLAN interfaces
sudo ip link set dev "$INTERFACE".10 up
if [ $? -ne 0 ]; then
  echo "Failed to bring up VLAN 10 interface."
  exit 1
fi

sudo ip link set dev "$INTERFACE".20 up
if [ $? -ne 0 ]; then
  echo "Failed to bring up VLAN 20 interface."
  exit 1
fi

echo "VLAN interfaces $INTERFACE.10 and $INTERFACE.20 have been created and set up."
