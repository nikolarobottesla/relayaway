# relayaway
automated deployment of wireguard server to tunnel port 44158 for Helium Hotspot p2p traffic, this should become obsolete in a few months with the light hotspot conversion

![alt text](https://github.com/[username]/[reponame]/blob/[branch]/diagram.png?raw=true)

## requirements
1. linuxy environment (ubuntu 20.04 WSL2 was used)
1. git
1. python with pip
1. ability to google, please google the step before posting a question

## be safe
* run `git-init.sh` to prevent accidental commiting of secrets

# instructions

## GitHub
1. fork and clone this repo

## Amazon Web Services
1. setup an AWS account with 2 factor authentication
1. install AWS CLI
1. find the lowest latency region, run from your installation location, https://ping.psa.fun/
1. add ed25519 SSH key pair to the region(s) you want to use and make sure to match the `key_pair_name` in main.tf
1. setup AWS credentials file https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html

## Terraform
1. install terraform
1. modify lightsail region folder(s) and main.tf file(s) as necessary to match your desired region(s)
1. go do ansible instructions, stop before deploy step and come back
1. modify main.tf to match your vault.yaml port choice 
1. (optional) look up the terraform cli commands, read through some of the AWS tutorial
1. deploy lightsail infra using Terraform cli
    * `terraform init`
    * `terraform validate`
    * `terraform apply`
1. put the static public ips in vault.yaml

## Ansible
1. install ansible using pip
1. install ansible requirements `make reqs`
1. create the vault password file `.vault-password` with a password of 'change-this-password'
1. decrypt the vault `make decrypt`
1. change the vault password and save it in a password manager
1. update the vault.yaml file
    * randomize wireguard port and subnet
    * add or remove servers in the s_keys section (you won't have the public ips until you deploy Terraform)
    * install wireguard and generate key pairs as needed `wg genkey | tee privatekey | wg pubkey > publickey`
1. add or remove hosts in `hosts.ini`
1. deploy ansible automation `make server`
1. create client configs `make client`

## save and secure your work
1. encrypt the vault `make encrypt`
1. git add, commit and push
1. comment out port 22 (ssh) in the main.tf files and re-apply

## tunnel adapter (peer 2)
1. get hardware
    * recomended wired: https://www.gl-inet.com/products/gl-mt300n-v2/
    * recomended wifi: https://www.amazon.com/dp/B07794JRC5
1. follow included instructions for initial setup
1. recomend setting up goodcloud remote access
1. add wireguard connection by copy and pasting config
1. connect Helium Hotspot to tunnel adapter lan
1. forward tcp 44158 (helium p2p port) from wireguard to lan for ip of hotspot

# shoulders standing on
* https://golb.hplar.ch/2019/01/expose-server-vpn.html - rules used in server_wg0.conf template
* https://www.cyberciti.biz/faq/how-to-set-up-wireguard-firewall-rules-in-linux/ - explains the rules well
* https://github.com/jnv/ansible-role-unattended-upgrades
* https://github.com/IronicBadger/infra
