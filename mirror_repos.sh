#!/bin/bash
TOKEN="$(cat /run/secrets/gitlab_secret)"
#remove fucking trailing characters
TOKEN="${TOKEN//$'\r'/}"

#only push current branch
git config --global push.default simple
while read l; do
    REPOS=($l)
    SOURCE_REPO=${REPOS[0]}
    echo SOURCE_REPO: $SOURCE_REPO
    DESTINATION_REPO=${REPOS[1]}
	echo DESTINATION_REPO: $DESTINATION_REPO
    # replace "gitlab" to "oauth2:$TOKEN@gitlab"
    ACCESS_STRING="oauth2:$TOKEN@gitlab"
    DESTINATION_REPO="${DESTINATION_REPO/gitlab/"$ACCESS_STRING"}"
    git clone $SOURCE_REPO current_repo
    cd ./current_repo
    pwd
    git remote set-url origin $DESTINATION_REPO
    git status
    git push
    cd ../
    pwd
    rm -r ./current_repo
done < config.txt
