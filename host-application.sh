#!/bin/bash

APPLICATION_DIR="hosted-applications"

if [ -n "$1" ] && [ -n "$2" ]; then
  SUBMODULE_PATH="$APPLICATION_DIR/$2/app"
  if [ -d $SUBMODULE_PATH ]; then
    echo "submodule already exist, update submodule now.."
    git submodule update --remote $SUBMODULE_PATH
  else 
    echo "creating new submodule"
    git submodule add "$1" "$SUBMODULE_PATH"
  fi
  cat <<EOF >"$APPLICATION_DIR/$2/catalog-info.yaml"
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: test-$2
  description: Component with GitHub actions enabled.
  annotations:
    github.com/project-slug: ''
spec:
  type: service
  lifecycle: experimental
  owner: user:guest
EOF
fi


