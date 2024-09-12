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

# Function to create a VLAN interface
create_vlan_interface() {
  VLAN_ID=$1
  VLAN_INTERFACE="$INTERFACE.$VLAN_ID"

  # Create the VLAN interface
  sudo ip link add link "$INTERFACE" name "$VLAN_INTERFACE" type vlan id "$VLAN_ID"
  if [ $? -ne 0 ]; then
    echo "Failed to create VLAN $VLAN_ID interface."
    exit 1
  fi

  # Bring up the VLAN interface
  sudo ip link set dev "$VLAN_INTERFACE" up
  if [ $? -ne 0 ]; then
    echo "Failed to bring up VLAN $VLAN_ID interface."
    exit 1
  fi
  echo "VLAN interface $VLAN_INTERFACE has been created and set up."
}

# Create VLAN 10, 20, and 30 interfaces
create_vlan_interface 10
create_vlan_interface 20
create_vlan_interface 30
