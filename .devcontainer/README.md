# Devcontainer Configuration

This directory contains the VS Code devcontainer configuration for Borg Web UI.

## What's Included

### Base Environment
- **Python 3.10** - Matching production environment
- **Node.js 22** - Latest LTS for frontend development
- **Redis Server** - For caching and session management
- **Borg Backup 1.4.3+** - Backup tool matching production version

### System Dependencies
- Build tools (gcc, g++, make, pkg-config)
- Borg dependencies (libacl1, liblz4, libzstd, libxxhash)
- SSH tools (openssh-client, sshfs, sshpass)
- Development tools (git, vim, htop, tree, ncdu)

### VS Code Extensions

**Python Development:**
- Python language support
- Pylance language server
- Black formatter
- Ruff linter

**Frontend Development:**
- ESLint
- Prettier
- Tailwind CSS IntelliSense

**Database & Docker:**
- Docker extension
- SQLite viewer

**Git & Testing:**
- GitLens
- Test Explorer
- Coverage visualization

## Getting Started

1. Install [VS Code](https://code.visualstudio.com/) and the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2. Open this project in VS Code
3. When prompted, click "Reopen in Container" (or use Command Palette: "Dev Containers: Reopen in Container")
4. Wait for the container to build and the post-create script to complete
5. Start developing!

## Development Workflow

### Backend Development
```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8081
```

### Frontend Development
```bash
cd frontend && npm run dev
```

### Run Tests
```bash
# All tests
pytest

# With coverage
pytest --cov=app --cov-report=html

# Specific test file
pytest tests/unit/test_borg_wrapper.py
```

### Format Code
```bash
# Python
black app/ tests/

# Frontend
cd frontend && npm run format
```

### Lint Code
```bash
# Python
ruff check app/ tests/

# Frontend
cd frontend && npm run lint
```

## Ports

The following ports are automatically forwarded to your local machine:

- **8081** - Backend API (FastAPI)
- **5173** - Frontend dev server (Vite)
- **6379** - Redis (for debugging)

## File Structure

```
.devcontainer/
├── Dockerfile          # Custom image with all dependencies
├── devcontainer.json   # VS Code devcontainer configuration
├── post-create.sh      # Setup script run after container creation
└── README.md           # This file
```

## Troubleshooting

### Container won't build
- Ensure Docker is running
- Try rebuilding: Command Palette → "Dev Containers: Rebuild Container"

### Redis not running
```bash
sudo service redis-server start
redis-cli ping  # Should return PONG
```

### Python dependencies not found
```bash
pip install -r requirements.txt
```

### Frontend dependencies not found
```bash
cd frontend && npm install
```

### Port already in use
Change the port in your command:
```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8082
```

## Benefits

- **Consistency:** Everyone gets the same development environment
- **Quick Setup:** One-click to start developing
- **No Local Pollution:** All tools are containerized
- **Production Parity:** Matches production Python/Node.js versions
- **Integrated Testing:** All test tools pre-installed

## Customization

You can customize the devcontainer by editing:

- `Dockerfile` - Add system dependencies
- `devcontainer.json` - Add VS Code extensions or settings
- `post-create.sh` - Add custom setup steps
