# Example of configuring nginx server from box

I use this Ansile playbookas a base to configuring nginx server out of box. Playbook was tested on followins OS: Ubuntu Server 22.04, CentOS7, CentOS 9 Stream.

You can freely use this solution, but without any guarantee from the author.






sudo chown root:gitlab-runner /etc/ansible/vault/nginx.yml
sudo chmod 650 /etc/ansible/vault/nginx.yml
chmod 641 /etc/ansible/vault/
sudo mkdir -p /etc/ansible/config/ssl
nano /etc/ansible/config/ssl/itproblog.ru.key
nano /etc/ansible/config/ssl/itproblog.ru.crt
sudo chmod -R 440 /etc/ansible/config/
sudo chown root:gitlab-runner -R /etc/ansible/config/
sudo chmod 650 /etc/ansible/config/
sudo chmod 650 /etc/ansible/config/ssl/


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

## Integrate with your tools

- [ ] [Set up project integrations](http://gitlab.itproblog.ru/Likhachev/cnf-nginx/-/settings/integrations)