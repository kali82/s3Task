#!/bin/bash

OUTPUT_FILE="metadata.txt"

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
SECURITY_GROUPS=$(curl -s http://169.254.169.254/latest/meta-data/security-groups | tr '\n' ',')

OS_INFO=$(cat /etc/os-release)
OS_NAME=$(grep -i '^NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')
OS_VERSION=$(grep -i '^VERSION=' /etc/os-release | cut -d= -f2 | tr -d '"')
OS_INFO="Name: $OS_NAME,Version: $OS_VERSION"
USERS=$(grep -E '/(bash|sh)$' /etc/passwd )

cat <<EOF > $OUTPUT_FILE
Instance ID: $INSTANCE_ID
Public IP: $PUBLIC_IP
PRIVATE_IP: $PRIVATE_IP
Security Groups: $SECURITY_GROUPS
OS info: $OS_INFO
Users: $USERS
EOF

echo "Success! Data saved in file: $OUTPUT_FILE"

