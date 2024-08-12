# Node Exporter Installation Script

This repository contains a Bash script for installing the [Node Exporter](https://prometheus.io/docs/guides/node-exporter/) on a Linux system. The Node Exporter is an essential tool for monitoring system metrics and is part of the Prometheus ecosystem.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)

## Features

- Downloads and installs Node Exporter from the official GitHub repository.
- Creates a dedicated system user for running Node Exporter.
- Sets up a systemd service for easy management of the Node Exporter service.
- Provides verbose output and error checking for each step of the installation.

## Prerequisites

- A Linux system (Debian, Ubuntu, CentOS, etc.)
- Root access or sudo privileges
- `wget` and `tar` installed on the system

## Installation

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/mrankitvish/node-exporter-setup.git
   cd node-exporter-setup
   ```
2. Make the installation script executable:

    ```bash
    chmod +x setup.sh
    ```

3. Run the installation script as root:

    ```bash
    sudo ./setup.sh
    ```
## Usage
After running the installation script, the Node Exporter service will be started automatically. You can check the status of the service with the following command:

```bash
sudo systemctl status node-exporter.service
```
To view the metrics collected by Node Exporter, open your web browser and navigate to:

```text
http://<your-server-ip>:9100/metrics
```
Replace <your-server-ip> with the IP address of your server.
