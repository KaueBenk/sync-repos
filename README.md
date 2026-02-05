# � Sync Repos

PowerShell script to automatically manage multiple Git repositories, performing sync operations and detecting uncommitted changes.

## 📋 Description

This script scans all Git repositories in a parent directory, automatically executing:
- `git pull` - Updates the local repository
- `git push` - Pushes local changes to remote
- Checks the working tree status
- Generates a consolidated problem report

## ✨ Features

- ✅ Automatic synchronization of multiple repositories
- ✅ Detection of uncommitted changes (dirty working tree)
- ✅ Final report showing only repositories with problems
- ✅ Colorful and organized output
- ✅ Configurable parameter to specify repositories directory

## 🚀 Usage

### Basic Usage

Run the script in the directory containing your repositories:

```powershell
. '.\sync-repos.ps1'
```

By default, the script will look for repositories in the parent directory (`..`).

### Custom Path Usage

Specify a different directory:

```powershell
. '.\sync-repos.ps1' -ReposPath "C:\Users\YourUser\Projects"
```

### Output Example

```
Processing repository: project-1
OK: Working tree is clean

Processing repository: project-2
Warning: Working tree is not clean!

Processing repository: project-3
OK: Working tree is clean

============================================
PROBLEM REPORT
============================================

Found 1 repository(ies) with problems:

Repository: project-2
Branch: main
Status:
   M modified-file.txt
   ?? new-file.txt
```

## 📦 Requirements

- **Windows PowerShell 5.1+** or **PowerShell Core 7+**
- **Git** installed and available in PATH
- Git repositories configured with remotes

## 🛠️ How It Works

1. **Scan**: Lists all directories in the specified path
2. **Sync**: For each repository, executes `git pull` and `git push`
3. **Check**: Uses `git status --porcelain` to detect uncommitted changes
4. **Collect**: Stores information about repositories with problems
5. **Report**: Displays a final summary of only the repositories that need attention

## 📊 Detected Status Types

The script identifies various types of changes in the working tree:

- `M` - Modified file
- `A` - File added to staging
- `D` - Deleted file
- `??` - Untracked file
- `R` - Renamed file
- `C` - Copied file
- `U` - File with merge conflict

## ⚙️ Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `ReposPath` | string | `".."` | Path to the parent directory containing the repositories |

## 🔒 Security

- The script **does not modify** files in the repositories
- Only executes standard Git commands (`pull`, `push`, `status`)
- Does not delete or overwrite data

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the project
2. Create a branch for your feature (`git checkout -b feature/MyFeature`)
3. Commit your changes (`git commit -m 'Add MyFeature'`)
4. Push to the branch (`git push origin feature/MyFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 👤 Author

Developed to facilitate the management of multiple Git repositories in development environments.

## 🐛 Known Issues

- The script needs to be executed with the `.` operator (dot sourcing) to work correctly
- Requires repositories to be already configured with remotes

## 💡 Tips

- Run the script periodically to keep your repositories synchronized
- Use together with Windows scheduled tasks for complete automation
- Add the directory to PATH to execute from anywhere

## 📧 Support

If you encounter problems or have suggestions, open an [issue](../../issues) on GitHub.

---

⭐ If this project was useful to you, consider giving it a star!
