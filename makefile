decrypt:
	ansible-vault decrypt --vault-password-file .vault-password vars/vault.yaml

encrypt:
	ansible-vault encrypt --vault-password-file .vault-password vars/vault.yaml

# ansible-galaxy collection install -r requirements.yaml -p ./
reqs:
	ansible-galaxy collection install -r requirements.yaml
	ansible-galaxy role install -r requirements.yaml

# server
server:
	ansible-playbook run.yaml -b --limit wg_server