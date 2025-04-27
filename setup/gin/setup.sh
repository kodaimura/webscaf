#!/bin/bash

set -e

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Project name is missing. Please provide a project name."
  exit 1
fi

GIN_REPO="https://github.com/kodaimura/scaf-gin.git"

echo "📦 Cloning scaf-gin..."
git clone "$GIN_REPO" clonetmp

echo "🔁 Replacing placeholder 'scaf-gin' with app name '$PROJECT_NAME'..."
for fpath in `find ./clonetmp -name "*.go" -o -name "*.html"`
do sed -i "" s/scaf-gin/$PROJECT_NAME/g $fpath
done
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./clonetmp/go.mod
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./clonetmp/config/env/.env.sample
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./clonetmp/config/env/.env.dev
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./clonetmp/config/env/.env.prod
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./clonetmp/web/static/manifest.json

echo "🧹 Cleaning up"
mv clonetmp/* .
rm -rf clonetmp
rm -rf .git
rm -rf setup
rm setup.sh

echo "✅ Gin setup complete!"