# Reconnaissance through Phishing in OT Environment
[ T1598.001 ] <(https://attack.mitre.org/techniques/T1598/001/)> 


**T1598.001 - Spearphishing Service** involves attackers impersonating legitimate services to trick targets into revealing sensitive information. In the context of an OT environment, this technique is used to identify key personnel and gather information necessary for planning subsequent attack stages.

---

## Objective

The primary objectives of using phishing in the reconnaissance phase are to:
- Identify individuals responsible for maintaining or operating specific OT systems.
- Collect contact information and system details for use in planning further attacks.
- Exploit social engineering techniques to gain unauthorized access or information.

---

## Steps in the Reconnaissance Phase

### 1. Identify the Target

The attacker begins by choosing a target within the organization. In this case, the focus is on identifying employees or roles responsible for OT systems, such as:
- OT network administrators
- Industrial control system (ICS) operators
- Maintenance engineers

### 2. Gather Public Information

Before launching a phishing attack, the attacker collects public information about the target organization. This might include:
- Names and job titles from LinkedIn or the company's website.
- Organizational charts, employee directories, or other available data.
- Industry-related forums, social media, or other publicly accessible platforms.

### 3. Crafting the Phishing Email

The attacker uses the gathered information to create a convincing phishing email. The email is designed to impersonate a legitimate entity, such as:
- Internal IT or OT support teams
- Vendors, service providers, or external contractors related to OT systems

#### Example of a Phishing Email:
```text
Subject: Immediate Action Required - OT System Security Update

Dear [Target's Name],

As part of our ongoing system maintenance, we have detected potential vulnerabilities in the OT environment. To ensure the security of the system, we need to verify the credentials of personnel responsible for overseeing OT operations.

Please click the link below and provide the necessary details to confirm your identity and role:

[Fake Link]

Thank you for your prompt attention to this matter.

Best regards,  
OT Security Team  
[Organization Name]
```

### 4. Deploying the Phishing Email
Once the email is crafted, the attacker sends it to specific individuals identified during earlier research. The email is designed to:
- Request the target to click on a malicious link leading to a fake login page.
- Trick the target into revealing information such as their role, responsibilities, or login credentials.

### 5. Gathering and Analyzing Information
The attacker collects the information provided by the targets, which may include:
- Login credentials to OT systems.
- Names, job titles, and contact information of employees.
- Internal system details, such as software versions or hardware specifications.

This data is then used to:
- Identify key personnel responsible for specific systems.
- Map out the organization's OT infrastructure.
- Plan subsequent stages of the attack, including system infiltration or data theft.

## Additional Phishing Techniques

### Fake Website Phishing
Attackers create a fake website that closely resembles a legitimate one, then trick the target into providing login credentials or personal information.

**Example:**
A fake banking website with a URL like `www.bank-login.com` (instead of `www.bank.com`) asks the user to enter their username and password.

### Phishing on Social Media
Attackers use social media platforms like Facebook, Twitter, or LinkedIn to send phishing messages or post malicious links. Victims are lured into clicking these links and providing sensitive information.

**Example:**
A message from a "friend" on Facebook asks you to click on a link to view "photos" or "videos," but the link leads to a phishing website.

