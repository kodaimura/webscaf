#!/bin/bash

echo "🌟 Select setup type:"
echo "1) Next.js + Gin (default)"
read -p "Enter number [1]: " choice

choice=${choice:-1}

case $choice in
  1)
    echo "🛠️ Running setup for Next.js + Gin..."
    bash ./sh/next-gin.sh
    ;;
  *)
    echo "❌ Invalid choice. Exiting."
    exit 1
    ;;
esac