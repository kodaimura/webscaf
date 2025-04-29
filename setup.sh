#!/bin/bash

echo "🌟 Select setup type:"
echo "1) Gin (default)"
echo "2) Gin + Next.js"
echo "3) Genie"
echo "4) Genie + Next.js"
read -p "Enter number [1-4]: " choice

choice=${choice:-1}

read -p "🚀 Enter your project name: " project_name

if [ -z "$project_name" ]; then
  echo "❌ Project name cannot be empty. Exiting."
  exit 1
fi

case $choice in
  1)
    echo "🛠️ Running setup for Gin..."
    chmod +x ./setup/gin/setup.sh
    bash ./setup/gin/setup.sh "$project_name"
    ;;
  2)
    echo "🛠️ Running setup for Gin + Next.js..."
    chmod +x ./setup/next-gin/setup.sh
    bash ./setup/next-gin/setup.sh "$project_name"
    ;;
  3)
    echo "🛠️ Running setup for Genie..."
    chmod +x ./setup/genie/setup.sh
    bash ./setup/genie/setup.sh "$project_name"
    ;;
  4)
    echo "🛠️ Running setup for Genie + Next.js..."
    chmod +x ./setup/next-genie/setup.sh
    bash ./setup/next-genie/setup.sh "$project_name"
    ;;
  *)
    echo "❌ Invalid choice. Exiting."
    exit 1
    ;;
esac