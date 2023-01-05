#!/bin/bash

set -e

# Need a personal CircleCI API token saved as CIRCLE_TOKEN
# https://circleci.com/docs/managing-api-tokens/#creating-a-personal-api-token

VCS=""
ORG=""

ALL_PROJECTS=$(curl -s --request GET --url "https://circleci.com/api/v2/insights/${VCS}/${ORG}/summary?circle-token=${CIRCLE_TOKEN}" | jq -r .all_projects[])

for i in $(echo ${ALL_PROJECTS}) ; do
  echo "$i"
  echo test
  curl -s --request GET --url "https://circleci.com/api/v2/project/${VCS}/${ORG}/${i}/envvar?circle-token=${CIRCLE_TOKEN}" | jq .items[]
done
