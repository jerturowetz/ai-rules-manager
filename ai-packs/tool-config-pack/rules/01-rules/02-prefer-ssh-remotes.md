---
id: prefer_ssh_remotes
scope: global
category: security
description: "Always use SSH instead of HTTPS for Git remotes and CLI tool authentication"
tools_excluded: []
---

# Prefer SSH Remotes

Always configure Git remotes and CLI tools to use SSH instead of HTTPS for authentication.

## Core Principle

**SSH keys over password prompts.** SSH provides better security and eliminates repeated authentication prompts.

## Git Remotes

### ✅ **Preferred SSH Format:**
```bash
# When adding remotes
git remote add origin git@github.com:username/repository.git

# When cloning
git clone git@github.com:username/repository.git

# GitHub CLI setup
gh auth login  # Choose SSH when prompted
```

### ❌ **Avoid HTTPS Format:**
```bash
# Avoid these formats
git remote add origin https://github.com/username/repository.git
git clone https://github.com/username/repository.git
```

## Converting Existing HTTPS Remotes

### Check Current Remote
```bash
git remote -v
# origin  https://github.com/username/repo.git (fetch)
# origin  https://github.com/username/repo.git (push)
```

### Convert to SSH
```bash
git remote set-url origin git@github.com:username/repo.git

# Verify the change
git remote -v
# origin  git@github.com:username/repo.git (fetch)
# origin  git@github.com:username/repo.git (push)
```

## SSH Key Setup

### Generate SSH Key (if needed)
```bash
# Generate new SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"

# Start SSH agent
eval "$(ssh-agent -s)"

# Add key to agent
ssh-add ~/.ssh/id_ed25519
```

### Add to GitHub/GitLab/Bitbucket
```bash
# Copy public key to clipboard (macOS)
pbcopy < ~/.ssh/id_ed25519.pub

# Then add to your Git provider's SSH keys settings
```

### Test SSH Connection
```bash
# Test GitHub connection
ssh -T git@github.com

# Expected response:
# Hi username! You've successfully authenticated...
```

## CLI Tools Configuration

### GitHub CLI
```bash
# Login with SSH preference
gh auth login
# Choose: "GitHub.com"
# Choose: "SSH"
# Choose: "Upload your SSH public key"
```

### Other Git Providers
```bash
# GitLab
git clone git@gitlab.com:username/project.git

# Bitbucket  
git clone git@bitbucket.org:username/project.git

# Custom Git servers
git clone git@your-server.com:username/project.git
```

## Why SSH is Better

### ✅ **Security Benefits:**
- **No password transmission** - Keys are never sent over the network
- **Strong cryptographic authentication** - Much harder to compromise than passwords
- **Key-based access control** - Easy to revoke specific keys without affecting others

### ✅ **Convenience Benefits:**
- **No repeated login prompts** - Authentication happens automatically
- **Works with 2FA** - No need to generate tokens for command line access
- **Better for automation** - Scripts can run without interactive authentication

### ✅ **Performance Benefits:**
- **Faster connection setup** - No OAuth/token exchange overhead
- **Persistent connections** - SSH can reuse connections for multiple operations

## Common Issues and Solutions

### SSH Agent Not Running
```bash
# Start SSH agent
eval "$(ssh-agent -s)"

# Add key
ssh-add ~/.ssh/id_ed25519

# Make persistent (add to ~/.zshrc or ~/.bashrc)
echo 'eval "$(ssh-agent -s)"' >> ~/.zshrc
echo 'ssh-add ~/.ssh/id_ed25519' >> ~/.zshrc
```

### Permission Denied
```bash
# Check if key is added to agent
ssh-add -l

# If not listed, add it
ssh-add ~/.ssh/id_ed25519

# Verify key is uploaded to Git provider
```

### Wrong Key Used
```bash
# Specify key explicitly
ssh -i ~/.ssh/specific_key git@github.com

# Or configure in ~/.ssh/config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
```

## Team Guidelines

### For New Projects
- Always clone with SSH
- Add SSH setup to project README
- Include SSH key generation in onboarding docs

### For Existing Projects
- Convert HTTPS remotes to SSH during next setup
- Document the conversion process for team members
- Update deployment scripts to use SSH

**Remember: SSH setup takes 5 minutes once, but saves authentication headaches forever.**