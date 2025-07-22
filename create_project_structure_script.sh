
#!/bin/bash

# Script to create a folder structure for a spec-driven agent-based development project
# in the user's home directory and initialize it with markdown files from a GitHub repository.
# Usage: ./create_project_structure.sh <local_project_name>
# Note: To export environment variables to your current shell session, source this script: . ./create_project_structure.sh <local_project_name>
# Assumes SSH authentication is set up for GitHub (git@ scheme).

# Check if local project name is provided
if [ -z "$1" ]; then
    echo "Error: Please provide the local project name"
    echo "Usage: $0 <local_project_name>"
    exit 1
fi

LOCAL_PROJECT_NAME="$1"
ROOT_DIR="$HOME/$LOCAL_PROJECT_NAME"

# Ensure HOME is defined and not root
if [ -z "$HOME" ] || [ "$HOME" = "/" ]; then
    echo "Error: HOME directory is not defined or is set to root (/). Aborting for safety."
    exit 1
fi

# Default GitHub base URL for SSH
GITHUB_BASE_URL="git@github.com"

# Prompt for repo owner and repo name
read -p "Enter GitHub repo owner (username or org): " REPO_OWNER
if [ -z "$REPO_OWNER" ]; then
    echo "Error: Repo owner is required."
    exit 1
fi

read -p "Enter GitHub repo name (project name for repo): " REPO_NAME
if [ -z "$REPO_NAME" ]; then
    echo "Error: Repo name is required."
    exit 1
fi

# Construct full repo URL using git@ scheme
REPO_URL="$GITHUB_BASE_URL:$REPO_OWNER/$REPO_NAME.git"

# Export environment variables
export REPO_OWNER="$REPO_OWNER"
export REPO_NAME="$REPO_NAME"
export REPO_URL="$REPO_URL"

echo "Environment variables exported:"
echo "REPO_OWNER=$REPO_OWNER"
echo "REPO_NAME=$REPO_NAME"
echo "REPO_URL=$REPO_URL"

# Create root directory in user's home
mkdir -p "$ROOT_DIR"

# Clone the GitHub repository using SSH
git clone "$REPO_URL" "$ROOT_DIR/repo_temp"
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone repository. Check SSH authentication and ensure the repository exists."
    exit 1
fi

# Copy markdown files to docs directory
mkdir -p "$ROOT_DIR/docs"
find "$ROOT_DIR/repo_temp" -name "*.md" -exec cp {} "$ROOT_DIR/docs/" \;
if [ $? -eq 0 ]; then
    echo "Markdown files copied from repository to $ROOT_DIR/docs/"
else
    echo "No .md files found in repository; proceeding with structure."
fi

# Prompt user to confirm deletion of temporary directory
echo "About to delete temporary clone directory: $ROOT_DIR/repo_temp"
read -p "Confirm deletion? (y/n): " confirm
if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Deletion cancelled. Temporary directory remains."
else
    rm -rf "$ROOT_DIR/repo_temp"
    if [ $? -eq 0 ]; then
        echo "Temporary directory deleted successfully."
    else
        echo "Error deleting temporary directory."
    fi
fi

# Create main directories
mkdir -p "$ROOT_DIR/docs/specs/prd"
mkdir -p "$ROOT_DIR/docs/specs/tasks"
mkdir -p "$ROOT_DIR/docs/specs/eval_datasets"
mkdir -p "$ROOT_DIR/docs/architecture"
mkdir -p "$ROOT_DIR/docs/refine_prompts"
mkdir -p "$ROOT_DIR/src/agents"
mkdir -p "$ROOT_DIR/src/environment"
mkdir -p "$ROOT_DIR/src/pipelines"
mkdir -p "$ROOT_DIR/tests"

# Create README in root with project overview
cat << EOF > "$ROOT_DIR/README.md"
# $LOCAL_PROJECT_NAME

This project follows a spec-driven development (SDD) approach for agent-based development (ABD) with eval data engineering. The structure is organized to support PRDs, tasks, architecture, eval datasets, and iterative refinement. Markdown templates are sourced from the provided GitHub repository.

## Directory Structure
- **docs/specs/prd**: Product Requirement Documents
- **docs/specs/tasks**: Task decomposition and processing
- **docs/specs/eval_datasets**: Evaluation dataset specifications
- **docs/architecture**: Architectural blueprints and diagrams
- **docs/refine_prompts**: Refinement prompts for iterative feedback
- **src/agents**: Agent implementation code
- **src/environment**: Environment simulation code
- **src/pipelines**: Eval data generation pipelines
- **tests**: Unit, integration, and eval tests
EOF

# Set executable permissions for the script (self-referential)
chmod +x "$0"

echo "Project structure for '$LOCAL_PROJECT_NAME' created successfully in $HOME!"
echo "Navigate to '$ROOT_DIR' to view the folder structure."
echo "Markdown files from '$REPO_URL' have been copied to '$ROOT_DIR/docs/'."
