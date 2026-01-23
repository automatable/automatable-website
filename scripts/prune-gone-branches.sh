#!/bin/bash
# Prune remote tracking refs and delete local branches marked as [gone]

# Fetch and prune stale remote refs
git fetch --prune 2>/dev/null

# Find and delete local branches whose upstream is gone
gone_branches=$(git branch -vv 2>/dev/null | grep ': gone]' | awk '{print $1}')

if [ -n "$gone_branches" ]; then
    echo "Cleaning up merged branches:"
    for branch in $gone_branches; do
        echo "  Deleting: $branch"
        git branch -d "$branch" 2>/dev/null || git branch -D "$branch" 2>/dev/null
    done
else
    echo "✓ No stale branches to clean up"
fi
