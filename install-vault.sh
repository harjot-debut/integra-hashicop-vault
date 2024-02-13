
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
echo "    INSTALLING VAULT "
echo "============================================================"
echo""
echo""



# sudo apt update && sudo apt install gpg wget

# wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# sudo apt update && sudo apt install vault


set -x

sudo apt-get update && sudo apt-get upgrade -y
sudo apt install net-tools


wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault

set +x


systemctl daemon-reload
systemctl start vault
systemctl enable vault
systemctl status vault