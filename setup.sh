#!/bin/bash

echo "🌟 Select setup type:"
echo "1) Next.js + Gin (default)"
echo "2) Next.js + NestJs"
echo "3) Next.js + Genie"
read -p "Enter number [1-3]: " choice

choice=${choice:-1}

read -p "🚀 Enter your project name: " project_name

if [ -z "$project_name" ]; then
  echo "❌ Project name cannot be empty. Exiting."
  exit 1
fi

case $choice in
  1)
    echo "🛠️ Running setup for Next.js + Gin..."
    chmod +x ./setup/next-gin/setup.sh
    bash ./setup/next-gin/setup.sh "$project_name"
    ;;
  2)
    echo "🛠️ Running setup for Next.js + NestJs..."
    chmod +x ./setup/next-nest/setup.sh
    bash ./setup/next-nest/setup.sh "$project_name"
    ;;
  3)
    echo "🛠️ Running setup for Next.js + Genie..."
    chmod +x ./setup/next-genie/setup.sh
    bash ./setup/next-genie/setup.sh "$project_name"
    ;;
  *)
    echo "❌ Invalid choice. Exiting."
    exit 1
    ;;
esac