#!/usr/bin/env bash
set -x

# This script handles creating a PR or pushing changes if any exist.
# It expects GITHUB_TOKEN and GITHUB_REF_NAME to be set.

if [ -n "$(git status --porcelain)" ]; then
    echo "Changes detected."
    git config --global user.name "github-actions[bot]"
    git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
    git add .
    if ! git commit -m "chore: update data"; then
        echo "Failed to commit changes."
        exit 1
    fi

    BRANCH_NAME="update-data-$(date +%s)"

    # Determine the base branch
    BASE_BRANCH="${GITHUB_REF_NAME:-main}"
    if [ "$BASE_BRANCH" = "HEAD" ]; then
        BASE_BRANCH="main"
    fi

    echo "Creating branch $BRANCH_NAME based on $BASE_BRANCH"
    if ! git checkout -b "$BRANCH_NAME"; then
        echo "Failed to checkout new branch."
        exit 1
    fi

    if git push origin "$BRANCH_NAME"; then
        echo "Push successful."
        if command -v gh &> /dev/null; then
            echo "Attempting to create PR..."
            # Capture output and exit code
            if OUTPUT=$(gh pr create \
                --title "chore: update data" \
                --body "Automated data update." \
                --base "$BASE_BRANCH" \
                --head "$BRANCH_NAME" 2>&1); then
                echo "PR created successfully: $OUTPUT"
            else
                echo "⚠️ Failed to create PR. Changes are pushed to branch $BRANCH_NAME."
                echo "Error details: $OUTPUT"
                # Do not exit 1, allowing the pipeline to continue
            fi
        else
            echo "gh command not found. Skipping PR creation."
        fi
    else
        echo "⚠️ Failed to push branch $BRANCH_NAME. Check workflow permissions."
        # Do not exit 1, allowing the pipeline to continue
    fi
else
    echo "No changes to commit."
fi
