# **Reconnaissance - Scanning the Infrastructure**
[ T1595 ] <https://attack.mitre.org/techniques/T1595/> 


## Objective:

The goal of reconnaissance is to gather information about the target organization’s network infrastructure. This includes identifying active hosts, open ports, services running on those ports, and potential vulnerabilities. This step is crucial as it lays the foundation for planning and executing subsequent attack steps.


## MITRE Technique: T1595 - Active Scanning
Active scanning involves actively probing a network to discover systems, services, and potential vulnerabilities. This technique is often used by attackers to map out the network and identify entry points.

As this step in the scenario is used to grab more information about the target, those definitions can be useful:

- **Network Mapping:** Helps in understanding the layout of the target network, including active hosts and network structure.

- **Port Scanning:** Identifies which ports are open and listening, indicating potential services to target.

- **Service Identification:** Provides detailed information about the services running on open ports, including their versions, which is critical for identifying known vulnerabilities.

- **Web Server Scanning:** Specifically targets web servers to find vulnerabilities that could be exploited for initial access.

- **Banner Grabbing:** Collects additional information about services by capturing banners, which can provide version numbers and other identifying details.


## Tools/Services

1. ### Nmap (Network Mapper):

**Purpose:** Nmap is a versatile and powerful tool used for network discovery and security auditing. It can be used to identify live hosts, open ports, and the services running on those ports.

2. ### Nikto:

**Purpose:** Nikto is an open-source web server scanner that performs comprehensive tests against web servers for multiple items, including outdated versions, configuration issues, and potentially dangerous files.


## Applying techniques:

#### Simple Scanning

```
# Execute a simple scanning
sudo nmap [IP-Address]
```
![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdV9ikugdJKAQpok0ukxtDBVtSLKuuJko6Bz3RJW8AszOHYyN4Dh4TtAG8z3L87y_vwDRbLmVVi4XBN0w3ztsYUxdQR6FOsOWg53s3ObsI3rO_-4el93kgOqACIB71mhGpmxFw-xu4J_iuULwyFCgbBmRWn?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 1**: Simple scanning result on 10.208.89.15: application running on port 8080.


#### Aggressive Scanning
```
sudo nmap -A [IP-Address]
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe3skKQqmnXGZM7gruRFh94aSrIZH_N-CgsP5qJT160U1TPgcp_qZKKoCM2Bn7_fr7gOWq5G9Q-pcPLMj16H27YMDdJkSNMTS9G1lQjdHbC-7oADhasXwRs10jqLGkc8-o4ouoUvt0hhn4RHtWlDZgbnjC3?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 2**: Aggressive scanning result on 10.208.89.15: application running on port 8080 + services versions.
