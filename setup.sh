#!/bin/bash

echo "🌟 Select setup type:"
echo "1) Next.js + Gin (default)"
read -p "Enter number [1]: " choice

choice=${choice:-1}

read -p "🚀 Enter your project name: " project_name

if [ -z "$project_name" ]; then
  echo "❌ Project name cannot be empty. Exiting."
  exit 1
fi

chmod +x ./sh/*

case $choice in
  1)
    echo "🛠️ Running setup for Next.js + Gin..."
    bash ./sh/next-gin.sh "$project_name"
    ;;
  *)
    echo "❌ Invalid choice. Exiting."
    exit 1
    ;;
esac