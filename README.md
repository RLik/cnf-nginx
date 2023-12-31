# Example of configuring nginx server from box by GitLab pipeline

I use this Ansile playbookas a base to configuring nginx server out of box for my labs using GitLab pipeline. Playbook was tested on followins OS: Ubuntu Server 22.04, CentOS 7, CentOS 9 Stream.

You can freely use this solution, but without any guarantee from the author.

## Environment description

I use GitLab CE server with local shell agent and Ansible installed. GitLab runner run under gitlab-runner user account.

## Step to prepare

- [ ] Switch to gitlab-runner user context:
```
 sudo su - gitlab-runner
```
- [ ] Generate SSH keys if they wasn't generated early:
```
ssh-keygen
```
- [ ] Correct inventory file (inventory/inv.ini) and add appropriate hosts.
- [ ] Copy SSH public key to all servers form inventory file:
```
ssh-copy-id roman@10.10.10.37
ssh-copy-id roman@10.10.10.41
ssh-copy-id roman@10.10.10.42
```
- [ ] Add sudo password for all hosts.
```
sudo nano /etc/ansible/vault/nginx.yml
```
Format is:
```
ansible_sudo_pass: P@$$word
```
- [ ] Encrypt file with sudo password by Ansible Vault:
```
sudo ansible-vault encrypt /etc/ansible/vault/nginx.yml
```
- [ ] Give rights to read sudo password file only to root and gitlab-runner users:
```
sudo chown root:gitlab-runner /etc/ansible/vault/nginx.yml
sudo chmod 640 /etc/ansible/vault/nginx.yml
sudo chmod 650 /etc/ansible/vault/
```

- [ ] In GitLab Project settings add variale named $ANSIBLE_VAULT_PASSWORD and in value part specify password that you've use to encrype nginx.yml file by Ansible Vault.
- [ ] Create directory for storing SSL cert and keys files. Add contents of SSL crt and ke files (or just copy this files to server):
```
sudo mkdir -p /etc/ansible/config/ssl
sudo nano /etc/ansible/config/ssl/itproblog.ru.key
sudo nano /etc/ansible/config/ssl/itproblog.ru.crt
```

- [ ] Give rights to read SSL cert and keys files only to root and gitlab-runner users:
```
sudo chmod -R 650 /etc/ansible/config/
sudo chown root:gitlab-runner -R /etc/ansible/config/
```