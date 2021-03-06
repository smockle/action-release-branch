#!/usr/bin/env bash
# Adapted from https://dev.to/jeffreymfarley/deploy-atomically-with-travis--npm-68b
# and https://github.com/actions/typescript-action#publish-to-a-distribution-branch
set -eo pipefail

RELEASE_BRANCH="${1:-dist}"

# Set the user name and email to match the API token holder
# This will make sure the git commits will have the correct photo
# and the user gets the credit for a checkin
git config --global user.email "${GH_EMAIL}"
git config --global user.name "${GH_USERNAME}"
git config --global push.default matching

# Get the credentials from a file
git config credential.helper "store --file=.git/credentials"

# Associate the API key with the account
echo "https://${GH_TOKEN}:@github.com" > .git/credentials

# Stash changed files (e.g. those created by a build script).
git add .
git stash

# Get latest release branch.
git fetch -a
git checkout -b "${RELEASE_BRANCH}" --track "origin/${RELEASE_BRANCH}"
git pull origin "${RELEASE_BRANCH}"

# Reconcile changed files, then remove (newly-)ignored files.
# (`.gitignore` is often updated before
# `smockle/action-release-branch` runs.)
git checkout stash -- .
git rm -r --cached .
git add .
git stash drop

# Update the release branch.
git commit -am "chore: publish release branch [skip ci]" || true # skip “no changes” error
git push --force origin HEAD:"refs/heads/${RELEASE_BRANCH}"