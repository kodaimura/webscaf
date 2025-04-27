#!/bin/bash

set -e

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Project name is missing. Please provide a project name."
  exit 1
fi

GENIE_REPO="https://github.com/kodaimura/scaf-genie.git"

echo "📦 Cloning scaf-genie..."
git clone "$GENIE_REPO" clonetmp

echo "🔁 Replacing placeholder 'ScafGenie' with app name '$PROJECT_NAME'..."
for fpath in `find ./clonetmp -name "*.jl" -o -name "*.toml" -o -name "*.html"`
do sed -i "" s/ScafGenie/$PROJECT_NAME/g $fpath
done

mv ./clonetmp/src/ScafGenie.jl ./clonetmp/src/$PROJECT_NAME.jl 

echo "🧹 Cleaning up"
rm -rf .git
rm -rf clonetmp/.git
rm -rf clonetmp/.vscode
mv clonetmp/* clonetmp/.[!.]* .
rm -rf clonetmp
rm -rf setup
rm setup.sh

echo "✅ Genie setup complete!"