#!/bin/bash

token="$1"  # Assign the first argument to the token variable
repo="$2"
run="$3"
artifact_target="$4"

url="https://api.github.com/repos/$repo/actions/runs/$run/artifacts" 
#url2="https://webhook.site/68a05c74-812f-41cf-a22f-97a9d0f402c3" 
#curl -s -o response111.json $url2 --header "Authorization: Bearer $token"
while true; do
  curl -s -o response.json $url --header "Authorization: Bearer $token"
  cat response.json
  echo Downloading $artifact_target
  artifact=$(jq '.artifacts[] | select(.name=="'$artifact_target'") | .id' response.json)

  if [ -z "$artifact" ]; then
      echo "Skip"
  else
      echo "Got Artifact:"
      echo $artifact  
      break 
  fi
  
    echo "Response not yet met. Retrying in 1 seconds..."
    sleep 1
done
