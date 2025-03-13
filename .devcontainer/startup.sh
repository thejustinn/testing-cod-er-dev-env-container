# Commands to run after starting coder environment
# ==========================================================

# Execute Flyway command

# Coder env builder currently does not support extensions field in devcontainer.json
# Workaround to install extensions listed
if ! which code-server > /dev/null; then
  curl -fsSL https://code-server.dev/install.sh | sh | tee code-server-install.log
fi

# Set the CODE_CLI variable depending on which command is available
CODE_CLI="code-server"
if which code > /dev/null; then
  CODE_CLI="code"
fi

# Create the necessary directory for extensions
mkdir -p ~/.vscode-server/extensions

# Get the realpath of the script's directory
realpath=$(realpath "$(dirname "$0")")

# Disable error checking to allow for conditional checks
set +e

# Get the list of extensions from the devcontainer.json file
extensions=$(sed 's/\/\/.*$//g' "$realpath"/devcontainer.json | jq -r -M '[.customizations.vscode.extensions[]?, .extensions[]?] | .[]' )

# Check if extensions exist and install them
if [ -n "$extensions" ] && [ "$extensions" != "null" ]; then
  echo "$extensions" | while read extension; do
    # Ensure that the extension variable is expanded properly
    $CODE_CLI --extensions-dir ~/.vscode-server/extensions --install-extension "$extension"
  done
fi