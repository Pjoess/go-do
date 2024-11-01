#!/bin/bash

# Determine the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    HOME_DIR="$HOME/.config/godo/todo.json"
    BIN_DIR="/usr/local/bin"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows (via WSL or Git Bash)
    HOME_DIR="\mnt\c\Users\$(whoami)\%USERPROFILE%\.config\godo\todo.json" # Adjust as necessary for your environment
    BIN_DIR="$HOME_DIR/AppData/Local/Microsoft/WindowsApps" # User binaries directory
else
    echo "Unsupported OS"
    exit 1
fi

# Define the path for the todo.json file
DOCUMENTS_PATH="$HOME_DIR"

# Create the todo.json file with initial content
cat <<EOF > "$DOCUMENTS_PATH"
{
  "todos": []
}
EOF

# Check for errors creating the JSON file
if [[ $? -ne 0 ]]; then
    echo "Error creating todo.json"
    exit 1
fi

echo "todo.json created at: $DOCUMENTS_PATH"

# Copy the binary to the appropriate bin directory
BINARY_NAME="godo" # Replace with your actual binary name
SOURCE_BINARY="./$BINARY_NAME"
DEST_BINARY="$BIN_DIR/$BINARY_NAME"

# Copy the binary
if cp "$SOURCE_BINARY" "$DEST_BINARY"; then
    echo "$BINARY_NAME copied to $BIN_DIR"
else
    echo "Error copying $BINARY_NAME to $BIN_DIR"
    exit 1
fi
