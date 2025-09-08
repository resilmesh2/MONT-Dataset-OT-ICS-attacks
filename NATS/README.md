# NATS OT-ICS Dataset Publisher & Subscriber

This repository provides Python scripts to publish and subscribe OT-ICS attack dataset features to a **NATS** messaging server. It is designed for cybersecurity experimentation and alert streaming with NATS.

---

## Features

- Publishes CSV-based OT-ICS attack data to NATS subjects.
- Subscribes to NATS subjects and prints received messages.
- Fully configurable NATS server, user credentials, and subjects.
- Python virtual environment setup for isolated dependencies.

---

## Requirements

- Ubuntu 16.04+ or compatible Linux
- Python 3.8+ (required for `nats-py`)
- Docker (for running NATS server if desired)
- Internet connection to download CSVs

---

## Setup

### 1. Install Python 3.8

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.8 python3.8-venv python3.8-dev python3.8-distutils
```

### 2. Clone repository
```bash
git clone https://github.com/resilmesh2/MONT-Dataset-OT-ICS-attacks
cd MONT-Dataset-OT-ICS-attacks/NATS
```
### 3. Setup Python virtual environment
```bash
chmod +x setup_natsenv.sh
./setup_natsenv.sh
```
This will:

Remove any old virtual environment natsenv.
Create a new Python 3.8 virtual environment.
Activate it.
Upgrade pip and install nats-py and asyncio.

### 4. Configure NATS
Modify nats_config.conf. 

## Usage

### 1. Subscriber (inside the Python virtual environment)

```bash
./subscriber.sh
```
### 2. Publisher (inside the Python virtual environment)

```bash
./publisher.sh --csv <link to online csv file or path to offline file>
```

For example: 

```bash
./publisher.sh "https://raw.githubusercontent.com/montimage-projects/OT-ICS-attacks/main/Scenario-2/1-Reconnaissance/normal_scan_features.csv"```



