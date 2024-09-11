# Impact

In this phase, the malware executes its final actions to cause disruption and damage. After successfully escalating privileges, the malware automatically shuts down and locks the system. This action disrupts OT processes and can cause significant damage to equipment.

- **MITRE ATT&CK Techniques**: 
  - [T1489 - Service Stop](https://attack.mitre.org/techniques/T1489/)
  - [T1485 - Data Destruction](https://attack.mitre.org/techniques/T1485/)

## Objective

The objective is to cause operational disruption and damage within the OT environment by:

- **Shutting Down the System**: Forcefully shutting down the system to halt all processes and operations.
- **Locking the System**: Preventing legitimate users from accessing or using the system, further exacerbating the impact on OT operations.

## Steps for Impact

### 1. Design Malware to Perform Shutdown and Lock

The malware is programmed to:

- **Initiate System Shutdown**: Execute commands to shut down the operating system.
- **Lock the System**: Use methods to lock or encrypt critical files or the system itself to prevent access.

#### Example Commands for Shutdown:

To shut down the system:
```
sudo shutdown -h now
```
To lock the system (if applicable):

```
sudo systemctl stop <service-name>
```

### 2. Implement Data Destruction (Optional)
For more severe impact, the malware might also:

- **Delete Critical Files**: Remove or corrupt essential system files or OT data.
- **Encrypt Files**: Encrypt files to render them inaccessible without proper decryption keys.
**Example Commands for Data Deletion**:
To delete files:

```
sudo rm -rf /path/to/critical/files
```
To encrypt files (using a tool like OpenSSL):

```
openssl enc -aes-256-cbc -salt -in /path/to/important/file -out /path/to/encrypted/file
```
### 3. Monitor the Impact
After executing the shutdown and lock commands:

- **Observe System Behavior**: Confirm that the system has shut down or is locked as intended.
- **Check for Disruption**: Assess the impact on OT processes and any resulting damage to equipment.
### 4. Document the Results
- **Record the Incident**: Document the specifics of the shutdown and locking actions, including timestamps and affected systems.
- **Analyze Damage**: Evaluate the extent of operational disruption and equipment damage.
## Next Steps
After causing impact, the attacker may:

- **Exit the Environment**: Ensure that all traces of the attack are removed to avoid detection.
- **Plan for Recovery**: Assess how to recover from the disruption and repair any damage caused.
## Summary
In the Impact (T1489 / T1485) phase, the malware automatically shuts down and locks the system after escalating privileges. This action disrupts OT processes and may cause significant damage to equipment, making recovery efforts critical for restoring operations.

```
This `README.md` entry outlines the **Impact** phase, detailing how the malware causes disruption by shutting down and locking the system, and provides steps for implementation, monitoring, and documentation.
```
