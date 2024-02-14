
### SETUP VAULT 

- Clone the Hashicop vault repository at home directory :-
`cd $HOME && git clone https://github.com/harjot-debut/integra-hashicop-vault.git`

- Move to cloned repo and Install hashicop vault using command :-  
`cd $HOME/integra-hashicop-vault && ./install-vault.sh`

- To check installed version , use command :-
`vault version`

- Inside this hashicop directory enter the IP address of the machine in the file **vault-config.json** in json field `'vaultIP`':-

- Setup and start vault container using command :-
`./setup-vault.sh` 

> NOTE:- SAVE THE Unseal key and Token that will be used for unsealing and login to vault in future.
  

