
set -eo pipefail

handle_error() {
  local exit_code=$?
  echo "Script failed with error on line $1: $2"
  exit $exit_code
}

# Set the error handler
trap 'handle_error $LINENO "$BASH_COMMAND"' ERR


echo""
echo""
echo "============================================================"
echo "    GENERATE VAULT COMPOSE FILE "
echo "============================================================"
echo""
echo""

./generate-vault-compose-file.sh

sleep 1


echo""
echo""
echo "============================================================"
echo "    CREATING VAULT CONTAINER "
echo "============================================================"
echo""
echo""


docker-compose -f docker-compose-vault.yaml up -d


sleep 10


INIT_RESPONSE=$(docker exec -it integra-vault vault operator init \
    -key-shares=1 \
    -key-threshold=1 \
    -format=json)
    
    
echo "**Vault is initialized**"


UNSEAL_KEY_BASE=$(echo "$INIT_RESPONSE" | jq -r '.unseal_keys_b64[0]')
ROOT_KEY=$(echo "$INIT_RESPONSE" | jq -r '.root_token')


json=$(jq -n \
    --arg Unseal_key "$UNSEAL_KEY_BASE" \
    --arg Token "$ROOT_KEY" \
    '{"Unseal_key": $Unseal_key, "Token": $Token}')


echo "$json" > vault-creds.json




echo""
echo""
echo "============================================================"
echo "    UNSEALING VAULT "
echo "============================================================"
echo""
echo""

set -x

docker exec -it integra-vault vault operator unseal $UNSEAL_KEY_BASE

docker exec -it integra-vault vault login $ROOT_KEY    

set +x

echo
echo

echo "NOTE:-"

echo 

echo "Note down the unseal key and root token given below"
echo

echo "Unseal key:"
echo $UNSEAL_KEY_BASE

echo 

echo "Token:"
echo $ROOT_KEY
