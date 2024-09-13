# Execution

In this phase, the malware that was delivered via the malicious USB device is automatically executed on the compromised system. This step is crucial as it initiates the attacker's control over the system and facilitates further actions like privilege escalation and impact.

- **ATT&CK Technique**: [T1059 - Execution: Command and Scripting Interpreter](https://attack.mitre.org/techniques/T1059/)

## Objective

The objective is to ensure that the malware on the USB device is executed automatically once it is inserted into the target system. This enables the attacker to gain control of the system without requiring additional user interaction.

## Steps to Execute the Malware

### 1. Prepare the Malware

The malware on the USB device is designed to execute automatically. Common methods include:

- **AutoRun/Autorun**: The malware might be set up to run automatically when the USB is inserted if autorun features are enabled on the target system.
- **Malicious Installer**: The malware could be disguised as a legitimate firmware installer that executes upon being opened.

### 2. Trigger the Malware Execution

When the USB device is inserted into the compromised workstation :

- **Autorun Configuration**: If autorun is enabled, the malware may automatically execute upon USB insertion.
- 
- **Manual Execution**: If autorun is disabled, the user might need to manually run the executable (e.g., `PLC_Firmware_Update.exe`).

### 3. Validate Execution

Ensure the malware is running correctly by checking for:

- **Processes**: Use commands or tools to confirm that the malicious processes are active.
- **Network Connections**: Verify that the malware is making network connections to the attacker's Command and Control (C2) server.

#### Example Commands for Validation:

To check for running processes:
```
ps aux | grep [malware_process_name] PLC_Firmware_Update
```

To monitor network connections:

```
netstat -an | grep [C2_server_ip]
```

### 5. Monitor and Analyze
Monitor the system for:

Unusual Activity: Look for signs of malware behavior such as unauthorized access or data exfiltration.
Logs: Check system logs for any entries related to the malware execution.

## Next Steps
Once the malware is confirmed to be running, proceed to the Privilege Escalation phase, where the attacker will attempt to gain higher-level access to the system.

## Summary
In the Execution (T1059) phase, the malware is automatically run on the compromised system upon inserting the malicious USB device. This step is critical as it initiates the attacker’s control over the system, allowing for subsequent privilege escalation and impact actions.

```
This `README.md` outlines the **Execution** phase of the attack scenario, detailing how the malware is executed automatically and providing steps for validating and capturing network activity during this phase.
```
