
set -eo pipefail

handle_error() {
  local exit_code=$?
  echo "Script failed with error on line $1: $2"
  exit $exit_code
}


vault_config=$(cat ./vault-config.json)


export VAULT_IP=$(echo "$vault_config" | jq -r '.vaultIP')

VAULT_PORT=8200



# Set the error handler
trap 'handle_error $LINENO "$BASH_COMMAND"' ERR

echo "vault:
   image: vault:1.13.3
   container_name: integra-vault
   restart: always
   environment:
      VAULT_ADDR: http://$VAULT_IP:$VAULT_PORT
   ports:
      - "$VAULT_PORT:8200"
   volumes:
      - ./integra-vault-data:/vault/file:rw
      - ./vault:/vault/config:rw
   cap_add:
      - IPC_LOCK
   entrypoint: vault server -config=/vault/config/vault.json" > ./docker-compose-vault.yaml
