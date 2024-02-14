

### SETUP VAULT 

- Clone the Hashicop vault repository at home directory :-
`cd $HOME && git clone https://github.com/harjot-debut/integra-hashicop-vault.git`

- Go to cloned repo 
`cd $HOME/integra-hashicop-vault`

- Install hashicop vault (if not already) using command :-  
`./install-vault.sh`

- Setup and start vault container using command :-
`./setup-vault.sh` 

> NOTE:- SAVE THE Unseal key and Token that will be used for unsealing and login to vault in future.





## Vault Restart Instructions

### If Vault stops due to any reasons, follow these steps to restart it:-
- Go to vault directory in VM using command :-
`cd $HOME/integra-hashicop-vault`

- Restart vault using command :-
`./restart-vault.sh`
  
