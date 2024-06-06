#!/bin/bash
#get only the first line
echo LOG: try read /run/secret/push_token and save to TOKEN variable
TOKEN="$(head -n 1 /run/secrets/push_token)"
#remove fucking trailing characters
TOKEN="${TOKEN//$'\r'/}"
#remove spaces
TOKEN="${TOKEN//$' '/}"

echo LOG: start of loop
while read line; do
    echo
    echo LOG: start work with line=$line
    #split line by spaces
    REPOS=($line)
    SOURCE_REPO=${REPOS[0]}
    echo LOG: SOURCE_REPO=$SOURCE_REPO
    DESTINATION_REPO=${REPOS[1]}
    echo LOG: DESTINATION_REPO=$DESTINATION_REPO

    # replace "$TOKEN$" in config string to TOKEN value
    DESTINATION_REPO="${DESTINATION_REPO/TOKEN/"$TOKEN"}"
    echo LOG: try clone repo to ./current_repo
    git clone $SOURCE_REPO current_repo --mirror

    echo LOG: go to ./current_repo
    cd ./current_repo
    echo LOG: show current directory
    pwd
    echo LOG: try update remote
    git remote update
    echo LOG: try set new remote
    git remote set-url origin $DESTINATION_REPO
    echo LOG: try push to new remote
    git push --all

    echo LOG: go to parent directory
    cd ../
    echo LOG: show current directory
    pwd
    echo LOG: remove ./current_repo
    rm -r ./current_repo
    echo LOG: end work with line=$line
done < /app/data/config.txt
echo LOG: exit
