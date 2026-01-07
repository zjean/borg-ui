#!/bin/bash

# Devcontainer post-creation script for Borg Web UI
# This script runs after the container is created and sets up the development environment

set -e  # Exit on error

echo "🚀 Setting up Borg Web UI development environment..."

# Start Redis server in background
echo "📦 Starting Redis server..."
sudo service redis-server start
redis-cli ping > /dev/null && echo "✅ Redis is running" || echo "❌ Redis failed to start"

# Create necessary directories
echo "📁 Creating necessary directories..."
sudo mkdir -p /data /backups /var/log/borg
sudo chown -R vscode:vscode /data /backups /var/log/borg
echo "✅ Directories created"

# Install Python dependencies
echo "🐍 Installing Python dependencies..."
pip install --no-cache-dir -r requirements.txt
echo "✅ Python dependencies installed"

# Install frontend dependencies
echo "⚛️  Installing frontend dependencies..."
cd frontend
npm install
cd ..
echo "✅ Frontend dependencies installed"

# Create initial database if it doesn't exist
echo "🗄️  Setting up database..."
if [ ! -f "/data/borg.db" ]; then
    echo "Creating initial database..."
    # The database will be created automatically when the app starts
    echo "Database will be created on first run"
fi
echo "✅ Database setup complete"

# Display useful information
echo ""
echo "✨ Development environment ready!"
echo ""
echo "📚 Quick Start Commands:"
echo ""
echo "  Backend Development:"
echo "    uvicorn app.main:app --reload --host 0.0.0.0 --port 8081"
echo ""
echo "  Frontend Development:"
echo "    cd frontend && npm run dev"
echo ""
echo "  Run Tests:"
echo "    pytest"
echo ""
echo "  Run Tests with Coverage:"
echo "    pytest --cov=app --cov-report=html"
echo ""
echo "  Format Code:"
echo "    black app/ tests/"
echo "    cd frontend && npm run format"
echo ""
echo "  Lint Code:"
echo "    ruff check app/ tests/"
echo "    cd frontend && npm run lint"
echo ""
echo "🔗 Forwarded Ports:"
echo "  - 8081: Backend API (FastAPI)"
echo "  - 5173: Frontend Dev Server (Vite)"
echo "  - 6379: Redis"
echo ""
echo "💡 Tip: Check CLAUDE.md for project-specific guidelines"
echo ""
