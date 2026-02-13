# Infrastructure

Automated deployment of a Flask application with PostgreSQL backend, Nginx load balancing, and Consul service discovery with TLS/ACL security.

## Architecture

- **App Servers (2)**: Flask application instances 
- **Database**: PostgreSQL 16 with automated schema setup 
- **Load Balancer**: Nginx with upstream health checks 
- **Service Discovery**: Consul cluster (1 server + 4 clients) with TLS encryption and ACL authentication 
- **CI/CD**: Jenkins pipeline setup

## Security Features

### Consul Service Discovery
- **Gossip Encryption**: All agent-to-agent communication is encrypted
- **TLS/mTLS**: HTTPS-only API (port 8501) with mutual certificate authentication
- **ACL**: Token-based authorization for API access and service registration
- **DNS**: Service discovery via Consul DNS on port 8600

### Secret Management
- **Gitleaks**: Pre-commit hooks to prevent secrets from being committed
- Sensitive data managed via Ansible vault and environment variables

## Setup

### 1. Install Gitleaks Pre-commit Hooks

Follow installation instructions: https://github.com/gitleaks/gitleaks#installing

### 2. Deploy Infrastructure

```bash
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbook.yml
```

## Environment Variables

Configure in `ansible/group_vars/all.yml`:

### Application Configuration
- `app_repo_url`: "https://github.com/INITOPS-TEAM/application.git"
- `app_branch`: "main"
- `app_dest`: "/var/www/app"
- `uploads_path`: "/var/lib/pictapp/uploads"
- `python_requirements`: "{{ app_dest }}/requirements.txt"

### Database Configuration
- `db_name`: pictapp
- `db_user`: pictapp_user
- `db_password`: **SENSITIVE** - Store in Ansible Vault
- `postgres_version`: 16
- `db_host`: postgres-service.service.consul 
- `database_url`: "postgresql://{{ db_user }}:{{ db_password }}@{{ db_host }}:5432/{{ db_name }}"

### Flask Configuration
- `flask_secret_key`: **SENSITIVE** - Store in Ansible Vault

### Consul Configuration
- `consul_version`: "1.22.3"
- `consul_user`: consul
- `consul_group`: consul
- `consul_datacenter`: dc1
- `consul_data_dir`: /opt/consul
- `consul_config_dir`: /etc/consul.d
- `consul_acl_token`: "{{ lookup('file', '/tmp/consul_acl_token.txt') }}" 

### Ansible Configuration
- `ansible_user`: vagrant (change to `ubuntu` or `ec2-user` for production)
- `ansible_ssh_private_key_file`: ~/.ssh/ansible

## Consul Operations

### Check Cluster Members

```bash
vagrant ssh consul
consul members -http-addr=https://127.0.0.1:8501 \
  -ca-file=/etc/consul.d/certs/consul-agent-ca.pem \
  -client-cert=/etc/consul.d/certs/server.pem \
  -client-key=/etc/consul.d/certs/server-key.pem
```

### View Registered Services

```bash
consul catalog services -http-addr=https://127.0.0.1:8501 \
  -ca-file=/etc/consul.d/certs/consul-agent-ca.pem \
  -client-cert=/etc/consul.d/certs/server.pem \
  -client-key=/etc/consul.d/certs/server-key.pem
```

### DNS Service Discovery

```bash
dig @127.0.0.1 -p 8600 flask-app.service.consul
dig @127.0.0.1 -p 8600 postgres-service.service.consul
```

## Development

For local development using Vagrant:

```bash
# Start VMs
vagrant up

# SSH into specific VM
vagrant ssh consul
vagrant ssh app1
vagrant ssh db
vagrant ssh lb

# Destroy VMs
vagrant destroy -f
```

## Production Deployment

For AWS EC2 deployment:
1. Update inventory with EC2 IPs
2. Change `ansible_user` from `vagrant` to `ubuntu` or `ec2-user`
3. Configure SSH keys
4. Update security groups to allow Consul ports (8300-8302, 8500-8501, 8600)
5. Use Ansible Vault for sensitive variables (`db_password`, `flask_secret_key`)
