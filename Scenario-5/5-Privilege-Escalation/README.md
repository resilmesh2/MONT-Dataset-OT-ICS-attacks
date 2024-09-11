# Privilege Escalation

In this phase, the malware that was executed on the compromised system attempts to escalate its privileges. This is typically achieved by prompting the user for admin credentials during a fake "firmware update" process.

- **MITRE ATT&CK Technique**: [T1078.003 - Valid Accounts: Default Accounts](https://attack.mitre.org/techniques/T1078/003/)

## Objective

The objective is to gain higher-level access to the system by tricking the user into providing administrator credentials. This allows the attacker to perform actions that require elevated privileges, such as making changes to system settings or accessing sensitive information.

## Steps for Privilege Escalation

### 1. Design the Malware to Prompt for Credentials

The malware is designed to display a fake update prompt that requests admin credentials. Common methods include:

- **Fake Update Prompt**: The malware may present a dialog or form that appears to be a legitimate system update request but actually captures user credentials.
- **Credential Harvesting**: The malware captures the provided credentials and sends them to the attacker’s Command and Control (C2) server.

#### Example Dialog:

```
Update Required
A new firmware update is available. Please enter your admin credentials to proceed with the installation.

Username: [__________]
Password: [__________]
[Submit Button]
```

### 2. Capture the Admin Credentials
When the user enters their credentials into the fake update prompt, the malware captures this information. Ensure that the credentials are:

- **Captured Securely**: The malware must securely transmit the captured credentials to the attacker's C2 server.
- **Stored Safely**: The attacker should ensure that any captured credentials are handled securely to prevent detection.
### 3. Verify Privilege Escalation
Confirm that the malware has successfully escalated its privileges by:

- **Accessing Restricted Areas**: Attempt to access system areas or perform actions that require admin privileges.
- **Checking Permissions**: Use commands or tools to verify that the malware has gained elevated permissions.
**Example Commands for Verification**:
To check user permissions:

```
whoami /groups
```
To attempt access to restricted areas:

```
sudo -l
```
### 4. Monitor and Analyze
Monitor the system for:

- **Unusual Activity**: Look for signs that the malware is using the escalated privileges to perform unauthorized actions.
- **Logs**: Check system logs for any entries related to the use of admin credentials.

## Next Steps
Once privilege escalation is confirmed, proceed to the Impact phase, where the attacker will execute actions to disrupt or damage the OT processes.

## Summary
In the Privilege Escalation (T1078.003) phase, the malware prompts the user for admin credentials during a fake "firmware update." By capturing these credentials, the attacker gains elevated access to the system, enabling further actions to be performed with administrative privileges.

```
This `README.md` entry details the **Privilege Escalation** phase, focusing on how the malware prompts for admin credentials and provides steps for verifying and monitoring the escalation of privileges.
```
