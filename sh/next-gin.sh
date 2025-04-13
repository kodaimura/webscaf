#!/bin/bash

set -e

TEMP_DIR="scaf_tmp_$$"

GIN_REPO="https://github.com/kodaimura/scaf-gin.git"
NEXT_REPO="https://github.com/kodaimura/scaf-next.git"

echo "📦 Cloning scaf-gin and scaf-next..."
git clone "$GIN_REPO" api
git clone "$NEXT_REPO" web

echo "🐳 Moving Dockerfiles to docker/..."
mkdir -p docker/api docker/web
mv ./api/Dockerfile ./docker/api/Dockerfile
mv ./web/Dockerfile ./docker/web/Dockerfile

echo "🧹 Cleaning up"

echo "✅ Next.js + Gin setup complete!"