# OT/ICS attacks- Simulation of an operational disruption in an OT/ICS network. 

The setup involves configuring a network with a vulnerable web application, OpenPLC, SCADA, and Tomcat services. The scenario includes two key vulnerabilities: CVE-2021-44228 (Log4Shell) and CVE-2009-3548 (weak credentials in Apache Tomcat). These vulnerabilities allow attackers to gain remote code execution through Log4j exploits and WAR file uploads, respectively, affecting industrial control systems using OpenPLC and ScadaBR for simulation.
