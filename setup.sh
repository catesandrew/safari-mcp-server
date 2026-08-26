#!/bin/bash

# Safari MCP Server Setup Script
# This script helps set up the development environment

echo "🚀 Setting up Safari MCP Server..."

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "❌ Error: This server only works on macOS"
  echo "   Safari and SafariDriver are only available on macOS systems"
  exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
  echo "❌ Error: Node.js is not installed"
  echo "   Please install Node.js 18+ from https://nodejs.org/"
  exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
  echo "❌ Error: Node.js version 18+ is required"
  echo "   Current version: $(node -v)"
  echo "   Please update Node.js from https://nodejs.org/"
  exit 1
fi

echo "✅ Node.js version: $(node -v)"

# Check if Safari is available
if ! command -v safaridriver &> /dev/null; then
  echo "❌ Error: SafariDriver not found"
  echo "   SafariDriver should be available at /usr/bin/safaridriver"
  echo "   Make sure you're running macOS with Safari 10+"
  exit 1
fi

echo "✅ SafariDriver found: $(which safaridriver)"

# Install dependencies
echo "📦 Installing dependencies..."
pnpm install

if [ $? -ne 0 ]; then
  echo "❌ Error: Failed to install dependencies"
  exit 1
fi

echo "✅ Dependencies installed"

# Build the project
echo "🔨 Building project..."
pnpm run build

if [ $? -ne 0 ]; then
  echo "❌ Error: Failed to build project"
  exit 1
fi

echo "✅ Project built successfully"

# Check Safari configuration
echo "🔍 Checking Safari configuration..."

# Check if Developer menu is enabled (we can't check this programmatically)
echo "⚠️  Please ensure Safari is configured:"
echo "   1. Safari → Preferences → Advanced → 'Show Develop menu in menu bar' ✓"
echo "   2. Develop → Allow Remote Automation ✓"

# Try to enable SafariDriver
echo "🔧 Attempting to enable SafariDriver..."
echo "   You may be prompted for your admin password..."

sudo safaridriver --enable

if [ $? -eq 0 ]; then
  echo "✅ SafariDriver enabled successfully"
else
  echo "⚠️  SafariDriver enable failed. You may need to run manually:"
  echo "   sudo safaridriver --enable"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Run the server: pnpm start"
echo "2. Add to Claude Desktop config:"
echo "   File location: ~/Library/Application Support/Claude/claude_desktop_config.json"
echo ""
echo "   Add this configuration:"
echo "   {"
echo '     "mcpServers": {'
echo '       "safari-devtools": {'
echo '         "command": "node",'
echo "         \"args\": [\"$(pwd)/build/index.js\"]"
echo "       }"
echo "     }"
echo "   }"
echo ""
echo "3. Restart Claude Desktop to load the server"
echo ""
echo "For more information, see README.md"
