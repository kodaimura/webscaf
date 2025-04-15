#!/bin/bash

set -e

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Project name is missing. Please provide a project name."
  exit 1
fi

NEST_REPO="https://github.com/kodaimura/scaf-nest.git"
NEXT_REPO="https://github.com/kodaimura/scaf-next.git"

echo "📦 Cloning scaf-nest and scaf-next..."
git clone "$NEST_REPO" api
git clone "$NEXT_REPO" web

echo "🐳 Moving Dockerfiles to docker/..."
mkdir -p docker/api docker/web
mv ./api/Dockerfile ./docker/api/Dockerfile
mv ./web/Dockerfile ./docker/web/Dockerfile

echo "🐋 Moving docker-compose.yml to current"
cp ./setup/next-nest/docker-compose.yml .
cp ./setup/next-nest/docker-compose.prod.yml .

echo "🔁 Replacing placeholder 'scaf-nest' with app name '$PROJECT_NAME'..."
sed -i "" s/scaf-nest/$PROJECT_NAME/g ./api/package-lock.json
sed -i "" s/scaf-nest/$PROJECT_NAME/g ./api/package.json

echo "🔁 Replacing placeholder 'scaf-next' with app name '$PROJECT_NAME'..."
for fpath in `find ./web -name "*.tsx"`
do sed -i "" s/scaf-next/$PROJECT_NAME/g $fpath
done
sed -i "" s/scaf-next/$PROJECT_NAME/g ./web/package-lock.json
sed -i "" s/scaf-next/$PROJECT_NAME/g ./web/package.json

echo "🔁 Replacing placeholder 'project_db' with app name '$PROJECT_NAME'..."
sed -i "" s/project_db/$PROJECT_NAME/g docker-compose.yml
sed -i "" s/project_db/$PROJECT_NAME/g ./api/.env.sample

sed -i "" 's#COPY package#COPY \.\.\/\.\.\/web\/package#g' ./docker/web/Dockerfile
sed -i "" 's#COPY \. \.#COPY \.\.\/\.\.\/web \.#g' ./docker/web/Dockerfile
sed -i "" 's#COPY package#COPY \.\.\/\.\.\/api\/package#g' ./docker/api/Dockerfile
sed -i "" 's#COPY \. \.#COPY \.\.\/\.\.\/api \.#g' ./docker/api/Dockerfile

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

echo "✅ Next.js + NestJs setup complete!"