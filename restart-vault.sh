
set -eo pipefail

handle_error() {
  local exit_code=$?
  echo "Script failed with error on line $1: $2"
  exit $exit_code
}

# Set the error handler
trap 'handle_error $LINENO "$BASH_COMMAND"' ERR


docker-compose -f docker-compose-vault.yaml up -d


sleep 3


Unseal_key=$(jq -r '.Unseal_key' ./vault-creds.json)
Token=$(jq -r '.Token' ./vault-creds.json)    

echo "KEY AND TOKEN ARE :-"
echo 

echo $Unseal_key
echo $Token
    
set -x


docker exec -it integra-vault vault operator unseal $Unseal_key

docker exec -it integra-vault vault login $Token   

set +x


echo 

echo "Vault unsealed successfully"
echo


