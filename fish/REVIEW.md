# Fish Configuration Review

## Overview
This review covers the Fish shell configuration in the `fish/` directory. Overall, the configuration is well-organized but has several areas that could be improved for maintainability, portability, and best practices.

## ✅ Strengths

1. **Good Organization**: Clear separation of concerns (aliases, functions, path, config)
2. **Comprehensive Git Aliases**: Extensive git aliases in `git-aliases-export.fish`
3. **Plugin Management**: Using Fisher for plugin management
4. **Version Managers**: Proper setup for pyenv, rbenv, and nvm
5. **Useful Functions**: Many practical custom functions (image conversion, video stabilization, etc.)

## ⚠️ Issues & Recommendations

### 1. **Hardcoded User Paths** (High Priority)

**Location**: `config.fish`, `path.fish`, `functions.fish`

**Issues**:
- Hardcoded `/Users/anenth` paths throughout
- Not portable to other machines/users

**Examples**:
```fish
# config.fish line 78
set -gx PNPM_HOME "/Users/anenth/Library/pnpm"

# config.fish line 84
alias claude="/Users/anenth/.claude/local/claude"

# config.fish line 87
set -gx PATH $PATH /Users/anenth/.lmstudio/bin

# functions.fish line 169
rm -rfv "/Users/anenth/Library/Application Support/stremio/Cache"
```

**Recommendation**: Replace with `$HOME`:
```fish
set -gx PNPM_HOME "$HOME/Library/pnpm"
alias claude="$HOME/.claude/local/claude"
set -gx PATH $PATH "$HOME/.lmstudio/bin"
rm -rfv "$HOME/Library/Application Support/stremio/Cache"
```

### 2. **Mixed PATH Management** (Medium Priority)

**Location**: `config.fish` and `path.fish`

**Issues**:
- PATH is set in multiple places (`path.fish` and `config.fish`)
- Mixing `export` (bash syntax) with `set -gx` (fish syntax)
- PATH additions scattered throughout `config.fish`

**Examples**:
```fish
# config.fish line 91 - bash syntax!
export PATH="$PATH:$HOME/.local/bin"

# config.fish line 94
fish_add_path /Users/anenth/.antigravity/antigravity/bin
```

**Recommendation**: 
- Consolidate all PATH management in `path.fish`
- Remove bash `export` syntax, use Fish syntax only
- Use `fish_add_path` consistently (Fish 3.2+)

### 3. **Inconsistent Function Definitions** (Low Priority)

**Location**: `functions.fish`

**Issues**:
- Some functions use `--description`, others use `-d`
- Line 59: `function md --wraps mkdir -d` should be `--wraps mkdir --description`
- Line 72: `function gz --d` should be `--description`

**Recommendation**: Standardize on `--description` flag

### 4. **Commented Out Code** (Low Priority)

**Location**: `config.fish` lines 47-70

**Issues**:
- Large block of commented Tide configuration
- Commented vi mode prompt function

**Recommendation**: 
- Remove if not needed, or move to a separate file like `config.fish.backup`
- If keeping for reference, add a comment explaining why

### 5. **Typo in Greeting** (Trivial)

**Location**: `config.fish` line 3

```fish
set -g fish_greeting 'Do somthing awesome today'
```

**Recommendation**: Fix typo: "somthing" → "something"

### 6. **Path.fish Issues** (Medium Priority)

**Location**: `path.fish`

**Issues**:
- Line 2: Missing `/` in `opt/homebrew/sbin` (should be `/opt/homebrew/sbin`)
- Inconsistent spacing in PATH variable
- Flutter path hardcoded

**Current**:
```fish
set homebrew /opt/homebrew/bin opt/homebrew/sbin
set flutter /Users/anenth/Code/flutter
```

**Recommendation**:
```fish
set homebrew /opt/homebrew/bin /opt/homebrew/sbin
set flutter "$HOME/Code/flutter"
```

### 7. **Duplicate Git Alias** (Low Priority)

**Location**: `aliases.fish` and `git-aliases-export.fish`

**Issue**: `g` alias defined in both files (line 11 in aliases.fish, line 16 in git-aliases-export.fish)

**Recommendation**: Remove from one file (prefer keeping in `git-aliases-export.fish`)

### 8. **Emptytrash Function Issues** (Medium Priority)

**Location**: `functions.fish` line 166-174

**Issues**:
- Uses `grm` which may not be available (should be `rm` or check if exists)
- Hardcoded paths
- No error handling

**Recommendation**: Add checks and use `$HOME`:
```fish
function emptytrash -d 'Empty the Trash on all mounted volumes and the main HDD'
    sudo rm -rfv "/Volumes/*/.Trashes"
    if command -v grm > /dev/null
        grm -rf "$HOME/.Trash/*"
    else
        rm -rf "$HOME/.Trash/*"
    end
    # ... rest with $HOME
end
```

### 9. **Missing Error Handling** (Low Priority)

**Location**: Various functions

**Issues**: Many functions don't check if commands exist before using them

**Recommendation**: Add checks like:
```fish
if not command -v command_name > /dev/null
    echo "Error: command_name not found"
    return 1
end
```

### 10. **Private Aliases File** (Info)

**Location**: `private_aliases.fish`

**Note**: This file contains SSH aliases. Consider if these should be in the repo or kept truly private.

## 📋 Suggested File Structure Improvements

Consider organizing `config.fish` better:

```fish
# 1. Basic configuration
set default_user "anenth"
set default_machine "anenth-mac"
set -g fish_greeting 'Do something awesome today'

# 2. Key bindings
fish_vi_key_bindings

# 3. Source configuration files (in order)
source ~/.config/fish/path.fish
source ~/.config/fish/aliases.fish
source ~/.config/fish/functions.fish

# 4. Git prompt configuration
# ... git prompt settings ...

# 5. External tool initialization
starship init fish | source
pyenv init - | source

# 6. Environment variables (move PATH additions to path.fish)
set -x NODE_OPTIONS "--max-old-space-size=6144"
```

## 🔧 Quick Fixes Summary

1. Replace all `/Users/anenth` with `$HOME`
2. Fix typo: "somthing" → "something"
3. Fix `path.fish` line 2: `opt/homebrew/sbin` → `/opt/homebrew/sbin`
4. Remove `export PATH=...` from `config.fish`, use `fish_add_path` in `path.fish`
5. Standardize function descriptions to `--description`
6. Fix function flags: `--d` → `--description`, `--wraps mkdir -d` → `--wraps mkdir --description`
7. Remove duplicate `g` alias
8. Clean up commented code or document why it's kept

## 📝 Best Practices to Follow

1. **Use `$HOME` instead of hardcoded paths**
2. **Consolidate PATH management in `path.fish`**
3. **Use Fish syntax consistently** (no `export`)
4. **Add error handling** for external commands
5. **Use `fish_add_path`** for PATH additions (Fish 3.2+)
6. **Check command existence** before using in functions
7. **Keep functions idempotent** when possible

## 🎯 Priority Actions

**High Priority**:
- Fix hardcoded user paths
- Consolidate PATH management

**Medium Priority**:
- Fix `path.fish` syntax error
- Improve `emptytrash` function
- Remove bash `export` syntax

**Low Priority**:
- Standardize function definitions
- Clean up commented code
- Remove duplicate aliases
- Fix typo in greeting

