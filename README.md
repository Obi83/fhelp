#     fhelp     - Ultimate Fedora Post-Install Helper


### Description
`fhelp` is a helper script designed for fresh Fedora (version 41) installations. It automates the process of updating the system, installing useful packages, and configuring services to save time and effort. This script also includes features to spoof the hostname and MAC address for enhanced privacy. This script was tested on Fedora 41 Workstation Gnome-Desktop.

![Fedora 41 Workstation - Fastfetch](https://github.com/Obi83/fhelp/blob/main/media/Fedor-41-fastfetch.png)

### Features
- Full update/upgrade circle
- Tool installing 
- Installing essential packages  
- Hostname changer
- MAC address changer



# Detailed Steps

### 1. Full Update Circle
The script begins by ensuring your Fedora system is fully updated and cleaned. This step includes:

- **Updating System Packages**: Fetches and installs the latest updates for all installed packages.
- **Removing Unnecessary Packages**: Removes packages that are no longer needed.
- **Cleaning Up Package Cache**: Frees up disk space by removing cached package files.

### 2. Tool Installing
This step focuses on installing essential tools and utilities:

- **Installing Flatpak and Gnome Platform**: Provides a runtime for Gnome applications.
- **Adding RPM Fusion Repositories**: Adds additional software sources.
- **Installing Essential Packages**: Installs a list of useful tools and utilities, including:
- **Installing Additional Flatpak Packages**: Installs `ExtensionManager` and `ProtonPlus`.

    ### Essential Packages/ Usefull Tools: 
    The script checks for and installs a list of useful tools, including:

        terminator:          A terminal emulator with advanced features.
        shellcheck:          A static analysis tool for shell scripts.
        inxi:                A system information tool.
        ufw:                 A user-friendly firewall.
        tor:                 Anonymity network client.
        fastfetch:           A fast system information tool.
        guake:               A dropdown terminal.
        timeshift:           A system restore tool.
        steam:               A digital distribution platform for video games.
        wireshark:           A network protocol analyzer.
        torbrowser-launcher: A tool to help download and install the Tor Browser.
        vlc:                 A multimedia player.
        codium:              An open-source build of Visual Studio Code.
        gnome-tweaks:        A tool for customizing desktop, windowing, workspaces, and more
        Installing Additional Flatpak Packages: The script installs ExtensionManager and ProtonPlus using Flatpak.

### 3. Hostname Changer
To enhance privacy, the script includes a service that generates a random hostname:

- **Generating a Random Hostname**: Creates an 8-character hostname from random syllables.
- **Setting the New Hostname**: Uses `hostnamectl` to set the new hostname.
- **Updating `/etc/hosts`**: Updates the hosts file to reflect the new hostname.
- **Systemd Service**: Ensures the hostname is set at boot.

### 4. MAC Address Changer
For additional privacy, the script includes a service that spoofs the MAC address:

- **Determining the Primary Network Interface**: Identifies the primary network interface.
- **Generating a Random MAC Address**: Generates a random MAC address.
- **Changing the MAC Address**: Sets the new MAC address.
- **Displaying the New MAC Address**: Confirms the change by displaying the new MAC address.
- **Systemd Service**: Ensures the MAC address is changed at boot.



# Installation
1. Clone the repository:
    
    
        git clone https://github.com/Obi83/fhelp.git
   
    
        cd fhelp

   
3. Make the `fhelp.sh` script executable:   
    
       sudo chmod +x fhelp.sh


4. Execute the `fhelp.sh` script as root:

        sudo ./fhelp.sh


# Usage
Run the `fhelp.sh` script to perform the following tasks:

- Update and clean the system
- Install essential packages ans usefull helper tools
- Set up and enable hostname generator service
- Set up and enable MAC address spoofing service



# References
This script was created by Obi83 with assistance from AI. For a full list of references and sources that inspired parts of this script, please see the [REFERENCES.md](REFERENCES.md) file.



# License
This project is licensed under the MIT License. See the [LICENSE](LICENSE.txt) file for details.


[def]: media/Fedor-41-fastfetch.png