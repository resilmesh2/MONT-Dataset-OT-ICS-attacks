# Scenario - Ransomware attack on OT/ICS Network

In order to create the Ransomware Attack on OT/ICS Network, the first thing that we are going to do is set up a vulnerable public-facing service, with a recent vulnerability. This will be the entry point for the attacker.


### **1 - CVE-2021-44228 (Log4Shell)**

#### **Description:**

The Log4Shell vulnerability affects the Apache Log4j 2 library, which is widely used for logging in Java applications. By sending a specially crafted request, an attacker can trigger the vulnerability to execute arbitrary code on the server.


#### Log4Shell Attack - How it works

1. **Vulnerability Identification**: The Log4j library is used extensively in Java applications for logging purposes. A flaw in the JNDI (Java Naming and Directory Interface) lookup functionality allows remote code execution by injecting a JNDI URL into a log message.

2. **Exploit Execution**: The attacker sends a request containing a malicious JNDI URL. When the vulnerable application logs this request, the JNDI lookup mechanism fetches and executes the code from the attacker-controlled server.

3. **Remote Code Execution**: The code fetched via the JNDI URL is executed on the target server, giving the attacker control over the system. This can be used to deploy further payloads, access sensitive information, or pivot to other parts of the network.


#### Log4Shell Vulnerability - Steps to set up

#### **Prerequisites**

- Docker installed on the host machine.


#### **Step 1: Setup the Vulnerable Application**<a id="step-1-setup-the-vulnerable-application"></a>

1. **Pull and Run the Docker Container** Execute the following command to run the vulnerable application with a volume connected to `/` of the host machine:

```
# super user privilegessudo su# start Docker container with the vulnerable applicationdocker run --name vulnerable-app --network host -v /:/root/ ghcr.io/christophetd/log4shell-vulnerable-app\@sha256:6f88430688108e512f7405ac3c73d47f5c370780b94182854ea2cddc6bd59929
```

**Explanation**:

- \--network host: Connects the container to the host's network.

- -v /:/root/: Mounts the host's root directory to the container's /root/ directory, giving access to all host data and simulating an application that runs in the target machine.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdo_sYB36B3vdNlhukIFlQ2iB4QxqAJjJlzkUpXf4wpY-_EpD8QbLway6XLqyO5e3dvAszCDuu7rT7m4TzyBxQT3_urZ_331dfjKSHjC7GyxDQw1v9OD3sUJX8jL6e-AgIXR8H-0hk6cDE85RvTBB5HAPA0?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 3**: Step 1 - Vulnerable application set up.

