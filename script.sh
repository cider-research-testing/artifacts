#!/bin/bash

token="$1"  # Assign the first argument to the token variable
repo="$2"
run="$3"

url="https://api.github.com/repos/$repo/actions/runs/$run/artifacts --header 'Authorization: Bearer $token'" 
while true; do
  curl -s -o response.json $url

  artifact=$(jq '.artifacts[] | select(.name=="go-result") | .id' response.json)

  if [ -z "$artifact" ]; then
      echo "Skip"
  else
      #echo "Got Artifact:"
      echo $artifact  
      #export ARCHIVE_ID=$artifact
      break 
  fi
  
    #echo "Response not yet met. Retrying in 5 seconds..."
    sleep 1
done
