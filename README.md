Sure! Here's an updated **README.md** for your **auto_select_mirror_ubuntu** repository, including the new steps for **single-command installation and execution**:

---

# auto_select_mirror_ubuntu

**auto_select_mirror_ubuntu** is a script that automatically selects and sets the appropriate Ubuntu repository mirror based on your system's version. The script fetches the list of available Ubuntu distributions from a mirror, checks your system's codename, and sets the repository URL accordingly.

## Features:
- Automatically detects your Ubuntu version's codename.
- Fetches available distributions from a mirror.
- Sets the correct repository URL for your Ubuntu version.
- Backs up your current `/etc/apt/sources.list` before making changes.
- Updates the package list for the new repository.

## Prerequisites:
- Ubuntu-based system.
- `wget` must be installed (usually pre-installed on Ubuntu).
- `sudo` privileges for modifying system files.

## Installation Instructions

### **One Command Installation and Execution**

To download and run the script in a single command, run the following:

```bash
curl -sSL https://raw.githubusercontent.com/Sajibekanti/auto_select_mirror_ubuntu/main/auto_select_mirror.sh | sudo bash
```

This will:
1. Download the script from GitHub.
2. Make it executable.
3. Run the script with `sudo` privileges.
4. Automatically clean up the downloaded script after execution.

### **Manual Installation**

If you prefer to download and install the script manually, follow these steps:

1. Clone the Repository:
   ```bash
   git clone https://github.com/Sajibekanti/auto_select_mirror_ubuntu.git
   cd auto_select_mirror_ubuntu
   ```

2. Make the script executable:
   ```bash
   chmod +x auto_select_mirror.sh
   ```

3. Run the script:
   ```bash
   sudo ./auto_select_mirror.sh
   ```

---

## How the Script Works

1. **Get Current Ubuntu Codename**: 
   The script uses `lsb_release -c` to get the codename of your current Ubuntu installation (e.g., `jammy`, `noble`, etc.).

2. **Fetch Available Distributions**:
   The script fetches the list of available distributions from `https://mirror.limda.net/ubuntu-archive/dists/` using `wget` and checks if your codename is listed.

3. **Update Sources**:
   If the codename is found, the script updates your `/etc/apt/sources.list` file with the correct repository URL for your Ubuntu version.

4. **Backup**:
   The script backs up your original `/etc/apt/sources.list` file to `/etc/apt/sources.list.backup` before making any changes.

5. **Update Package List**:
   Finally, it runs `sudo apt update` to refresh the package list from the newly set repositories.

---

## Example Output:

```bash
Found the distribution 'noble' in the available list.
Setting the repository URL to: http://mirror.limda.net/ubuntu-archive/
Backing up original sources.list...
Updating package list...
Repository setup and package list updated!
```

---

## Troubleshooting

- **Distribution Not Found**:
   If the script cannot find your codename in the list of available distributions, it will exit with an error:

   ```bash
   Error: Distribution 'noble' not found in the available mirror list.
   ```

   In this case, please ensure that your Ubuntu version is supported or check if you're using a pre-release version.

---

## Script Customization

You can modify the following variables in the script:
- `MIRROR_URL`: The base URL of the mirror from which the available distributions will be fetched.
- `REPO_URL`: The base URL for the repository (set to `http://mirror.limda.net/ubuntu-archive/` by default).
