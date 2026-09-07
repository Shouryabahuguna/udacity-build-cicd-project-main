#!/bin/bash
set -e

echo "1. Staging all modified files..."
git add -A

echo "2. Committing changes..."
git commit -m "fix: update configurations, dockerfiles and workflows" || echo "Nothing new to commit"

echo "3. Pushing changes to GitHub main branch..."
git push origin main

echo "=========================================="
echo "Successfully pushed to GitHub!"
echo "Ab GitHub Actions tab par Frontend Continuous Integration check karein!"
echo "=========================================="