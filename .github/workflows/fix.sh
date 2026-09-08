#!/bin/bash
set -e

git config user.name "Shouryabahuguna"
git config user.email "shouryabahuguna@gmail.com"

git add -A
git commit -m "fix: frontend-ci build job test step added"
git push origin main