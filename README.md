# Elk-Stack-Project
This is the documentation for deployment of an Elk Stack server for Project 1 in Cybersecurity Bootcamp

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Network Diagram](https://github.com/wynx2/Elk-Stack-Project/blob/main/Images/Network_Diagram.PNG)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the filebeat-playbook.yml file may be used to install only certain pieces of it, such as Filebeat.
   
  a.  elk-playbook.yml
  
  b.  filebeat-playbook.yml (also includes the commands to install metricbeat)
  
  c.  first-playbook.yml (used to deploy the dvwa container to be monitored by the ELK stack)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available in case a host vm goes down, in addition to restricting administrative access by means of a jump box to the network.


Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the server files and collects metric data about the system services.
- Filebeat is a tool that collects and forwards the log files to ElasticSearch
- MetricBeat collects system and various service level metrics which are sent to ElasticSearch

The configuration details of each machine may be found below.
| Name     | Function         | IP Address               | Operating system |
|----------|------------------|--------------------------|------------------|
| Jump Box | Gateway          | 20.94.246.131 / 10.0.0.4 | Ubuntu 18.04.1   |
| Web-1    | Webserver        | 10.0.0.6                 | Ubuntu 18.04.1   |
| Web-2    | Webserver        | 10.0.0.7                 | Ubuntu 18.04.1   |
| Elk-VM   | Elk Stack Server | 52.152.223.188 / 10.1.0.5| Ubuntu 18.04.1   |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 47.229.80.238

Machines within the network can only be accessed by the Jump Box.
- The Elk VM can only be accessed from the Jump Box.  

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses          |
|----------|---------------------|-------------------------------|
| Jump Box | Yes                 | 47.229.80.238                 |
| Web-1    | No                  | 10.0.0.4 Jump Box Internal IP |
| Web-2    | No                  | 10.0.0.4 Jump Box Internal IP |
| Elk-VM   | No                  | 10.0.0.4 Jump Box Internal IP |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it allowed the installation and configuration YAML files to be reused for future installations
and faster updates for any changes in configuration. 

The playbook implements the following tasks:
- Install docker.io
- Install Python3-pip
- Install docker using pip
- Download and install the cyberxsecurity/dvwa container
- Enable the Docker Service

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![screenshot after running docker ps](https://github.com/wynx2/Elk-Stack-Project/blob/main/Images/Elk_PS.PNG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.6 (Web-1)
- 10.0.0.7 (Web-2)

We have installed the following Beats on these machines:
- FileBeat
- MetricBeat

These Beats allow us to collect the following information from each machine:
- Filebeat will allow us to collect log files for analysis.  Metricbeat will allow us to collect system metrics eg. CPU usage, Memory uage from the docker containers.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the metricbeat.yml and filebeat.yml configuration files to etc/ansible.  The configuration files can be downloaded from 
	https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat
	https://gist.githubusercontent.com/slape/58541585cc1886d2e26cd8be557ce04c/raw/0ce2c7e744c54513616966affb5e9d96f5e12f73/metricbeat

- Update the configuration files to include the internal IP address of the Elk-VM (10.1.0.5)
- Run the playbook, and navigate to http://52.152.223.188:5601/app/kibana to check that the installation worked as expected.


- The playbook file to install ELK is elk-playbook.yml. The playbook file that installs filebeat and metricbeat is filebeat-playbook.yml.  The playbook files should be copied to /etc/ansible/roles
- Within the ansible container, the /etc/ansible/hosts file will need to be updated with the IP addresses where filebeat/metricbeat will be installed and where ELK should be installed.  The webservers grouping
will contain the IP addresses where filebeat/metricbeat will be installed.  The elk grouping will contain the IP address for the ELK-VM.  Each IP should be followed by "ansible_python_interpreter=/usr/bin/python3". 
- Navigate to http://52.152.223.188:5601/app/kibana to check that ELK is running.

Refer to the ff commands to download the Filebeat/Metricbeat configuration files and run the playbook.

Download Configuration Files

curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat > /etc/ansible/filebeat-config.yml

curl https://gist.githubusercontent.com/slape/58541585cc1886d2e26cd8be557ce04c/raw/0ce2c7e744c54513616966affb5e9d96f5e12f73/metricbeat >/etc/ansible/metricbeat-config.yml

Run Playbook File

sudo ansible-playbook filebeat-playbook.yml
