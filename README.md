<div align="center">
  
<a href="https://raw.githubusercontent.com/Stick-Package-Manager/lite/refs/heads/assets/lite.png" target="_blank" rel="noopener">
  <img src="https://raw.githubusercontent.com/Stick-Package-Manager/lite/refs/heads/assets/lite.png" width="100" height="100" alt="Stick Lite logo">
  
</a>

# Stick Lite
Stick Lite is a stripped-down version of Stick, written in V for the Arch User Repository (AUR), designed to be as minimal as possible. It removes nearly all non-essential features, keeping only the core functionality needed to install and manage packages. Perfect for extremely old or resource-constrained systems where every byte matters.

Total Size: 1.95 KB
</div>

## **Commands**

```bash
stick-lite <command> [package]
```

| Command | Description | Example |
|---------|-------------|---------|
| `install` | Install package with dependencies | `stick-lite install yay` |
| `remove` | Remove installed package | `stick-lite remove yay` |

## **Disclaimer**  
Stick Lite is still in active development and is **not yet ready for use**.  
While this repository already includes the README, documentation, and other project files, the package manager itself is currently incomplete.  

## Prerequisites

- [V compiler](https://vlang.io/) (latest version recommended)
- `pacman` package manager (Arch Linux or derivative)
- `makepkg` (from `base-devel` package)
- `tar` utility
- `sh` shell
- `sudo` access (for system dependencies)
- Internet connection

### Install Prerequisites

```bash
sudo pacman -S base-devel
```

## Installation

### Quick Install (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/Stick-Package-Manager/installer/main/install.sh | bash
```

Or with `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/Stick-Package-Manager/installer/main/install.sh | bash
```

### Run directly

```bash
v stick-lite.v

./stick install vim
```

| Feature                  | Stick | Lite |
|--------------------------|-------|------------|
| Package Installation      | ✅    | ✅         |
| Dependency Management     | ✅    | ✅         |
| Configuration Support     | ✅    | ⚠️         |
| Isolated Installation     | ✅    | ❌         |
| Repo Management           | ✅    | ❌         |
| AUR Search                | ✅    | ❌         |
| Upgrades            | ✅    | ❌         |
| Reinstall Support         | ✅    | ❌         |
| Clean Removal             | ✅    | ❌         |
| Package Tracking          | ✅    | ❌         |
| Signature Verification    | ✅    | ❌         |
| Auto-conflict Resolution  | ✅    | ❌         |

© 2025 [ihatemustard](https://github.com/ihatemustard) & [Stick Package Manager contributors](https://github.com/Stick-Package-Manager/stick/people)
