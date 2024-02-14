
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




sudo snap install vault
