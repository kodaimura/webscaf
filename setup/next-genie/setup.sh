#!/bin/bash

set -e

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Project name is missing. Please provide a project name."
  exit 1
fi

GENIE_REPO="https://github.com/kodaimura/scaf-genie-api.git"
NEXT_REPO="https://github.com/kodaimura/scaf-next.git"

echo "📦 Cloning scaf-genie-api and scaf-next..."
git clone "$GENIE_REPO" api
git clone "$NEXT_REPO" web

echo "🐳 Moving Dockerfiles to docker/..."
mkdir -p docker/api docker/web
mv ./api/Dockerfile ./docker/api/Dockerfile
mv ./web/Dockerfile ./docker/web/Dockerfile

cp ./setup/next-genie/docker-compose.yml .
cp ./setup/next-genie/docker-compose.prod.yml .
cp ./setup/next-genie/Makefile .

echo "🔁 Replacing placeholder 'ScafGenie' with app name '$PROJECT_NAME'..."
for fpath in `find ./api -name "*.jl" -o -name "*.toml"`
do sed -i "" s/ScafGenie/$PROJECT_NAME/g $fpath
done

echo "🔁 Replacing placeholder 'scaf-next' with app name '$PROJECT_NAME'..."
for fpath in `find ./web -name "*.tsx"`
do sed -i "" s/scaf-next/$PROJECT_NAME/g $fpath
done
sed -i "" s/scaf-next/$PROJECT_NAME/g ./web/package-lock.json
sed -i "" s/scaf-next/$PROJECT_NAME/g ./web/package.json

sed -i "" 's#COPY package#COPY \.\.\/\.\.\/web\/package#g' ./docker/web/Dockerfile
sed -i "" 's#COPY \. \.#COPY \.\.\/\.\.\/web \.#g' ./docker/web/Dockerfile

mv ./api/src/ScafGenie.jl ./api/src/$PROJECT_NAME.jl 

echo "🧹 Cleaning up"
rm ./api/docker-compose.yml
rm ./api/docker-compose.prod.yml
rm ./api/Makefile
rm -rf ./api/.git

rm ./web/docker-compose.yml
rm ./web/docker-compose.prod.yml
rm ./web/Makefile
rm -rf ./web/.git

rm setup.sh
rm -rf setup
rm -rf .git

echo "✅ Next.js + Genie setup complete!"