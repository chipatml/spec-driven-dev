
#!/bin/bash

# Script to create a folder structure for a spec-driven agent-based development project
# in the user's home directory and initialize it as a GitHub-ready repository.
# Usage: ./create_project_structure.sh <project_name> <github_repo_url>

# Check if project name and repo URL are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Please provide both project name and GitHub repo URL"
    echo "Usage: $0 <project_name> <github_repo_url>"
    exit 1
fi

PROJECT_NAME="$1"
REPO_URL="$2"
ROOT_DIR="$HOME/$PROJECT_NAME"

# Ensure HOME is defined and not root
if [ -z "$HOME" ] || [ "$HOME" = "/" ]; then
    echo "Error: HOME directory is not defined or is set to root (/). Aborting for safety."
    exit 1
fi

# Extract OWNER and REPO from URL
OWNER=$(echo "$REPO_URL" | sed -E 's|https://github.com/([^/]+)/([^/]+).*|\1|')
REPO=$(echo "$REPO_URL" | sed -E 's|https://github.com/([^/]+)/([^/]+).*|\2|')

if [ -z "$OWNER" ] || [ -z "$REPO" ]; then
    echo "Error: Invalid GitHub repo URL format."
    exit 1
fi

# Prompt for GitHub Personal Access Token
read -s -p "Enter your GitHub Personal Access Token (with repo scope): " TOKEN
echo ""

if [ -z "$TOKEN" ]; then
    echo "Error: Token is required."
    exit 1
fi

# Check if repo exists, create if not
RESPONSE_CODE=$(curl -s -H "Authorization: token $TOKEN" -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/$OWNER/$REPO" -w "%{http_code}" -o /dev/null)

if [ "$RESPONSE_CODE" = "404" ]; then
    echo "Repository does not exist. Creating new repository..."
    CREATE_RESPONSE=$(curl -s -H "Authorization: token $TOKEN" -H "Accept: application/vnd.github.v3+json" -d "{\"name\":\"$REPO\", \"auto_init\":true}" "https://api.github.com/user/repos")
    if [[ $CREATE_RESPONSE == *"\"message\": \"Bad credentials\""* ]]; then
        echo "Error: Invalid token or insufficient permissions."
        exit 1
    elif [[ $CREATE_RESPONSE == *"\"name\": \"$REPO\""* ]]; then
        echo "Repository created successfully."
    else
        echo "Error creating repository: $CREATE_RESPONSE"
        exit 1
    fi
elif [ "$RESPONSE_CODE" != "200" ]; then
    echo "Error checking repository (HTTP $RESPONSE_CODE). Check token and URL."
    exit 1
fi

# Create root directory in user's home
mkdir -p "$ROOT_DIR"

# Clone the GitHub repository with token for authentication
CLONE_URL="https://${TOKEN}@github.com/${OWNER}/${REPO}.git"
git clone "$CLONE_URL" "$ROOT_DIR/repo_temp"

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
# $PROJECT_NAME

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

echo "Project structure for '$PROJECT_NAME' created successfully in $HOME!"
echo "Navigate to '$ROOT_DIR' to view the folder structure."
echo "Markdown files from '$REPO_URL' have been copied to '$ROOT_DIR/docs/'."
