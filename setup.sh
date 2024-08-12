#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

echo "Starting the installation of Node Exporter..."

# Download the Node Exporter tarball
echo "Downloading Node Exporter..."
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download Node Exporter. Exiting."
    exit 1
fi

# Extract the tarball
echo "Extracting Node Exporter..."
tar -xvf node_exporter-1.8.2.linux-amd64.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to extract Node Exporter. Exiting."
    exit 1
fi

# Move the node_exporter binary to /usr/local/bin
echo "Moving Node Exporter binary to /usr/local/bin..."
mv node_exporter-1.8.2.linux-amd64/node_exporter /usr/local/bin/
if [ $? -ne 0 ]; then
    echo "Failed to move Node Exporter binary. Exiting."
    exit 1
fi

# Create a system user for Node Exporter
echo "Creating a system user for Node Exporter..."
useradd --no-create-home --shell /bin/false node_exporter
if [ $? -ne 0 ]; then
    echo "Failed to create user 'node_exporter'. Exiting."
    exit 1
fi

# Change ownership of the node_exporter binary
echo "Changing ownership of the Node Exporter binary..."
chown node_exporter:node_exporter /usr/local/bin/node_exporter
if [ $? -ne 0 ]; then
    echo "Failed to change ownership of Node Exporter binary. Exiting."
    exit 1
fi

# Create the systemd service file for Node Exporter
echo "Creating systemd service file for Node Exporter..."
cat <<EOL > /etc/systemd/system/node-exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOL
if [ $? -ne 0 ]; then
    echo "Failed to create systemd service file. Exiting."
    exit 1
fi

# Reload systemd to recognize the new service
echo "Reloading systemd daemon..."
systemctl daemon-reload
if [ $? -ne 0 ]; then
    echo "Failed to reload systemd daemon. Exiting."
    exit 1
fi

# Enable and start the Node Exporter service
echo "Enabling and starting Node Exporter service..."
systemctl enable node-exporter.service
if [ $? -ne 0 ]; then
    echo "Failed to enable Node Exporter service. Exiting."
    exit 1
fi

systemctl start node-exporter.service
if [ $? -ne 0 ]; then
    echo "Failed to start Node Exporter service. Exiting."
    exit 1
fi

echo "Node Exporter has been installed and started successfully."
