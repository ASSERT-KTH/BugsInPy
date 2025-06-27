#!/usr/bin/env bash

# Exit the shell script immediately if any of the subsequent commands fails.
set -e

################################################################################
# This script initializes BugsInPy Docker environment.
# It sets up any additional dependencies or configurations needed.
################################################################################

echo "Initializing BugsInPy Docker environment..."

# Print an error message and terminate the script.
print_error_and_exit() {
  echo -e "${1} \nTerminating initialization... " >&2
  exit 1
}

# Check if we're in the right directory
if [ ! -f "framework/bin/bugsinpy-checkout" ]; then
    print_error_and_exit "BugsInPy framework not found. Please run this script from the BugsInPy root directory."
fi

# Verify Python version is available
echo "Verifying Python version..."
if python3 --version | grep -q "Python 3.8"; then
    echo "✓ Python 3.8 is available"
    python3 --version
else
    print_error_and_exit "Python 3.8 is not available"
fi

# Verify required tools
echo "Verifying required tools..."
for tool in git dos2unix python3 pip3; do
    if command -v $tool &> /dev/null; then
        echo "✓ $tool is available"
    else
        print_error_and_exit "$tool is not available"
    fi
done

# Create work directory if it doesn't exist
mkdir -p framework/bin/temp

# Set proper permissions
chmod +x framework/bin/*

echo "BugsInPy Docker environment initialized successfully!"
echo ""
echo "You can now use BugsInPy commands:"
echo "  bugsinpy-info"
echo "  bugsinpy-checkout -p <project> -i <bug_id> -v <version> -w <work_dir>"
echo "  bugsinpy-compile"
echo "  bugsinpy-test"
echo "  bugsinpy-coverage" 