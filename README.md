# relayaway
automated deployment of wireguard server to tunnel port 44158 for Helium Hotspot p2p traffic

## be safe
* run `git-init.sh` to prevent accidental commiting of secrets

## terraform instructions
1. install terraform
1. modify main.tf to match your vault.yaml port choices
1. look up the cli commands
1. deploy

## ansible instructions
1. install ansible using pip
1. install requirements ```make reqs```
1. create the vault password ```.vault-password``` with a password of 'change-this-password'
1. decrypt the vault ```make decrypt```
1. change the vault password
1. update the vault.yaml file
    * generate key pairs as needed ```wg genkey | tee privatekey | wg pubkey > publickey```

TODO finish instructions...

## background
* https://golb.hplar.ch/2019/01/expose-server-vpn.html - rules used in server_wg0.conf template
* https://www.cyberciti.biz/faq/how-to-set-up-wireguard-firewall-rules-in-linux/ - explains the rules well