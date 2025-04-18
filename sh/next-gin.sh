#!/bin/bash

set -e

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Project name is missing. Please provide a project name."
  exit 1
fi

GIN_REPO="https://github.com/kodaimura/scaf-gin.git"
NEXT_REPO="https://github.com/kodaimura/scaf-next.git"

echo "📦 Cloning scaf-gin and scaf-next..."
git clone "$GIN_REPO" api
git clone "$NEXT_REPO" web

echo "🐳 Moving Dockerfiles to docker/..."
mkdir -p docker/api docker/web
mv ./api/Dockerfile ./docker/api/Dockerfile
mv ./web/Dockerfile ./docker/web/Dockerfile

echo "🐋 Moving docker-compose.yml to ."
cp docker-compose/next-gin

mkdir -p docker/api docker/web
mv ./api/Dockerfile ./docker/api/Dockerfile
mv ./web/Dockerfile ./docker/web/Dockerfile

echo "🔁 Replacing placeholder 'scaf-gin' with app name '$PROJECT_NAME'..."
for fpath in `find ./api -name "*.go"`
do sed -i "" s/scaf-gin/$PROJECT_NAME/g $fpath
done
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./api/README.md
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./api/go.mod
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./api/config/env/.env.sample
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./api/config/env/.env.dev
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./api/web/static/manifest.json
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./api/web/template/_head.html
sed -i "" s/scaf-gin/$PROJECT_NAME/g ./api/web/template/_header.html

echo "🔁 Replacing placeholder 'scaf-next' with app name '$PROJECT_NAME'..."
for fpath in `find ./web -name "*.tsx"`
do sed -i "" s/scaf-next/$PROJECT_NAME/g $fpath
done
sed -i "" s/scaf-next/$PROJECT_NAME/g ./web/package-lock.json
sed -i "" s/scaf-next/$PROJECT_NAME/g ./web/package.json

echo "🔁 Replacing placeholder 'project_db' with app name '$PROJECT_NAME'..."
sed -i "" s/project_db/$PROJECT_NAME/g docker-compose.yml
sed -i "" s/project_db/$PROJECT_NAME/g ./api/config/env/.env.sample
sed -i "" s/project_db/$PROJECT_NAME/g ./api/config/env/.env.dev

sed -i "" s#package#\.\.\/\.\.\/web\/package#g ./docker/web/Dockerfile

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
rm -rf .git
rm -rf sh

echo "✅ Next.js + Gin setup complete!"