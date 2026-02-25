#!/usr/bin/env bash
set -e

# This script handles creating a PR or pushing changes if any exist.
# It expects GITHUB_TOKEN and GITHUB_REF_NAME to be set.

if [ -n "$(git status --porcelain)" ]; then
    git config --global user.name "github-actions[bot]"
    git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
    git add .
    git commit -m "chore: update data"

    BRANCH_NAME="update-data-$(date +%s)"

    # Determine the base branch
    BASE_BRANCH="${GITHUB_REF_NAME:-main}"
    if [ "$BASE_BRANCH" = "HEAD" ]; then
        BASE_BRANCH="main"
    fi

    echo "Creating branch $BRANCH_NAME based on $BASE_BRANCH"
    git checkout -b "$BRANCH_NAME"

    if git push origin "$BRANCH_NAME"; then
        echo "Push successful. Attempting to create PR..."
        if gh pr create \
            --title "chore: update data" \
            --body "Automated data update." \
            --base "$BASE_BRANCH" \
            --head "$BRANCH_NAME"; then
            echo "PR created successfully."
        else
            echo "⚠️ Failed to create PR. This might be due to repository settings. Changes are pushed to branch $BRANCH_NAME."
            # Do not exit 1, allowing the pipeline to continue
        fi
    else
        echo "⚠️ Failed to push branch $BRANCH_NAME. Check workflow permissions."
        # Do not exit 1, allowing the pipeline to continue (e.g. maybe just transient error or protection)
    fi
else
    echo "No changes to commit."
fi
