# Infrastructure

Automated deployment of a Flask application with PostgreSQL backend, Nginx load balancing, and Consul service discovery with TLS/ACL security.

## Architecture

- **App Servers (2)**: Flask application instances

- **Database**: PostgreSQL with automated schema setup

- **Load Balancer**: Nginx with upstream health checks

- **Service Discovery**: Consul cluster (1 server + 4 clients) with TLS encryption and ACL authentication

- **CI/CD**: Jenkins setup

## Quick Start

**Deploy infrastructure**
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbook.yml

**Access application** 
open http://192.168.56.10