#!/bin/bash
echo ""
echo "#############################################"
echo "#############################################"
echo ""
# Function to display a logo
display_logo() {
    cat << "EOF"
 _______  __   __  _______  ___      _______ 
|       ||  | |  ||       ||   |    |       |
|    ___||  |_|  ||    ___||   |    |    _  |
|   |___ |       ||   |___ |   |    |   |_| |
|    ___||       ||    ___||   |___ |    ___|
|   |    |   _   ||   |___ |       ||   |    
|___|    |__| |__||_______||_______||___|    
EOF
}

# Display the Logo
display_logo
echo ""
echo ""
echo "#############################################"
echo "#######*Author of the Script is Obi83*#######"
echo ""
echo "Starting the fhelp script for Fedora!"

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi
echo ""
echo "Let's start with a standard task to make the system fresh and clean!"
echo "Also fhelp will install a few useful helper plus spoofs hostname and mac address."

# Update & cleanup with verbose logging
echo ""
echo "Updating system"
dnf update -y 
dnf upgrade -y 
dnf autoremove -y 
dnf clean all 

# Function to install org.gnome.Platform/x86_64/47 using Flatpak
install_gnome_platform() {
    echo "Installing org.gnome.Platform/x86_64/47 using Flatpak"
    flatpak install -y org.gnome.Platform/x86_64/47
    if [ $? -ne 0 ]; then
        echo "Failed to install org.gnome.Platform/x86_64/47"
    else
        echo "org.gnome.Platform/x86_64/47 has been installed successfully"
    fi
}

# Call the function to install org.gnome.Platform/x86_64/47
install_gnome_platform

# Function to search for correct package names and install them
search_and_install_packages() {
    # List of packages to install
    packages=("terminator" "shellcheck" "inxi" "ufw" "tor" "fastfetch" "timeshift" "steam" "wireshark" "torbrowser-launcher" "vlc" "gnome-tweaks")

    for package in "${packages[@]}"; do
        # Check if the package is already installed
        if ! rpm -q $package &> /dev/null; then
            echo "Searching for package: $package"
            search_result=$(dnf search $package | grep -m 1 "^$package\.")
            if [ -n "$search_result" ]; then
                correct_package=$(echo $search_result | awk '{print $1}')
                echo "Installing package: $correct_package"
                sudo dnf install -y $correct_package
                if [ $? -ne 0 ]; then
                    echo "Failed to install package: $correct_package"
                else
                    echo "Package installed: $correct_package"
                fi
            else
                echo "Package not found: $package"
            fi
        else
            echo "Package already installed: $package"
        fi
    done
}

# Start the installation process
install_packages
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm  -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm  -E %fedora).noarch.rpm
sudo dnf group upgrade -y core
sudo dnf4 group upgrade -y core
sudo dnf install -y terminator inxi ufw tor fastfetch timeshift steam wireshark torbrowser-launcher vlc gnome-tweaks
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install -y codium
sudo flatpak install -y ExtensionManager ProtonPlus
echo ""
echo "Installation of useful helpers is done. Enjoy!"
echo "fhelp installing now: hogen - hostname generator service."

# Create the hogen.sh file with hostname change code
echo ""
echo "Create: /usr/local/bin/hogen.sh"
cat << 'EOF' > /usr/local/bin/hogen.sh
#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Syllables
syllables=("la" "na" "se" "xa" "zu" "fo" "ra" "gi" "ja" "bo" "pi" "ke" "se" "ro" "mo" "me" "li" "jo" "lo" "mi" "pa" "ku" "te" "pa" "fo" "vo" "lu" "vo" "wo" "ta" "si" "pe" "ne" "mu" "so" "ma" "na" "ri" "la" "ga" "ja" "fi" "ba" "gu" "ka" "lo" "la" "po" "me" "sa" "va" "xe" "zu" "du" "ke" "ji" "xe" "ne" "nu" "be" "ni" "to" "ru" "su" "no" "la" "me" "na" "ra" "za" "xi" "po" "mi" "ha" "ne" "tu" "lo" "ka" "ta" "ni" "me" "jo" "ta" "re" "mi" "to" "na" "ya" "wa" "nu" "na" "ka" "ra" "pa" "ji" "nu" "fe" "lo" "ja" "ma" "jo" "su" "bo" "me" "re" "ke" "ti" "xu" "bo" "le" "pa" "da" "ku" "ki" "la" "so" "ve" "ba" "me" "zo" "ro" "lo" "je" "si" "mi" "pe" "na" "ga" "vo" "mu" "pa" "la" "sa" "me" "pi" "ho" "la" "mo" "te" "ma" "le" "bi" "jo" "re" "nu" "wi" "pa" "je" "mo" "ne" "la" "ma" "ra" "ru" "wi" "bu" "na" "lo" "ne" "me" "xi" "ko" "fi" "lu" "ji" "do" "ri" "we" "po" "pe" "wa" "ku" "ka" "hi" "yo" "ri" "ji" "ju" "ra" "po" "mo" "lo" "ma" "ko" "le" "ti" "me" "li" "to" "du" "la" "ne" "ka" "ga" "je" "be" "ri" "lo" "mi" "ti" "tu" "ku" "ri" "gi" "sa" "se" "la" "jo" "me" "sa" "pa" "ka" "to" "ta" "ru" "su" "la" "ne" "zi" "go" "po" "wa" "pu" "ka" "vo" "sa" "do" "me" "ki" "su" "me" "jo" "ro" "le" "pa" "me" "no" "ji" "le" "ho" "me" "su" "na" "la" "pa" "we" "le" "ne" "mi" "ku" "mo" "no" "ka" "mo" "me" "wo" "no" "ja" "ki" "ru" "lo" "po" "me" "te" "ri" "ha" "ra" "mi" "ma" "ba" "to" "me" "ja" "le" "mo" "mu" "la" "pa" "te" "la" "ro" "wa" "ze" "bi" "ke" "na" "le" "me" "mo" "ru" "ne" "la" "po" "me" "le" "bu" "lo" "sa" "xi" "me" "la" "ga" "so" "ru" "me" "pa" "sa" "wa" "me" "lo" "ka" "no" "we" "po" "zi" "ha" "re" "da" "me" "ne" "jo" "po" "ja" "ra" "la" "za" "ga" "le" "me" "ka" "no" "me" "la" "je" "me" "la" "na" "po" "so" "ro" "la" "mi" "na" "me" "ka" "le" "jo" "ne" "xi" "me" "le" "la" "nu" "so" "lo" "je" "ra" "me" "pa" "sa" "me" "la" "me" "ne" "la" "me" "pa" "me" "pa" "le" "we" "pa" "lo" "sa" "le" "lo")

# Random name
name=""
while [ ${#name} -lt 8 ]; do
    name="${name}${syllables[RANDOM % ${#syllables[@]}]}"
done

# Make it exactly 8 characters
name=${name:0:8}

# Capitalize letters
name="$(tr '[:lower:]' '[:upper:]' <<< ${name:0:1})${name:1:1}$(tr '[:lower:]' '[:upper:]' <<< ${name:2:1})${name:3}"

# New hostname
newhn=$name
hostnamectl set-hostname $newhn

# Update /etc/hosts
echo "127.0.0.1    localhost" > /etc/hosts
echo "127.0.0.1    $newhn" >> /etc/hosts

exit
EOF

# Make the hogen.sh file executable
chmod +x /usr/local/bin/hogen.sh

echo "Create: /etc/systemd/system/hogen.service"
# Create the hogen.service file with systemd unit configuration
cat << 'EOF' > /etc/systemd/system/hogen.service
[Unit]
Description=HOGEN Hostname Generator
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/local/bin/hogen.sh
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# Set the correct permissions for the service file
chmod +x /etc/systemd/system/hogen.service

# Reload systemd to recognize the new service, enable it, and start it
systemctl daemon-reload
systemctl enable hogen.service

echo ""
echo "Setup complete. The hogen service has been installed and enabled."
echo "fhelp will now create: mspoo - mac spoofy service"

# Create the mspoo.sh file with macspoof code
echo ""
echo "Create: /usr/local/bin/mspoo.sh"

cat << 'EOF' > /usr/local/bin/mspoo.sh
#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Make sure that 'ip' command is available
if ! command -v ip &> /dev/null; then
    echo "'ip' command not found. Please install it and try again."
    exit 1
fi

# Determine primary network interface
get_primary_interface() {
    INTERFACE=$(ip route | grep default | awk '{print $5}' | head -n 1)
    
    if [ -z "$INTERFACE" ]; then
        echo "No network interface found."
        exit 1
    fi
}

# Generate random MAC address
generate_random_mac() {
    echo -n "02" # Locally administered address (LAA) and unicast address
    for i in {1..5}; do
        printf ":%02x" $((RANDOM % 256))
    done
    echo # Ensure a newline at the end
}

# Spoof MAC address
spoof_mac() {
    # Get the primary network interface
    get_primary_interface

    # Generate a random MAC address
    NEW_MAC=$(generate_random_mac)

    echo "Spoofing MAC address for interface $INTERFACE with new MAC: $NEW_MAC"

    # Bring the network interface down
    if ! ip link set dev $INTERFACE down; then
        echo "Failed to bring down the network interface."
        exit 1
    fi

    # Change the MAC address
    if ! ip link set dev $INTERFACE address $NEW_MAC; then
        echo "Failed to change the MAC address."
        exit 1
    fi

    # Bring the network interface back up
    if ! ip link set dev $INTERFACE up; then
        echo "Failed to bring up the network interface."
        exit 1
    fi

    # Display the new MAC address
    ip link show $INTERFACE | grep ether
}

# Execute
spoof_mac
EOF

# Make the mspoo.sh file executable
chmod +x /usr/local/bin/mspoo.sh

echo "create: /etc/systemd/system/mspoo.service"
echo ""
# Create the mspoo.service file with systemd unit configuration
cat << 'EOF' > /etc/systemd/system/mspoo.service
[Unit]
Description=MSPOO MACSpoofing Service
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/mspoo.sh
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# Set permissions for the service file
chmod +x /etc/systemd/system/mspoo.service

# Enable the new service and start it
systemctl daemon-reload
systemctl enable mspoo.service
echo "The mspoo spoofing service has been installed and enabled."

echo ""
echo "##*fhelp*##+##*fhelp*##"
echo "##*fhelp*##+##*fhelp*##"
echo ""
# Function to display a logo
display_logo() {
    cat << "EOF"

  __ _          _       
 / _| |__   ___| |_ __  
| |_| '_ \ / _ \ | '_ \ 
|  _| | | |  __/ | |_) |
|_| |_| |_|\___|_| .__/ 
                 |_|    

EOF
}

# Display the Logo
display_logo
echo ""
echo ""
echo "##*fhelp*##+##*fhelp*##"
echo "##*fhelp*##+##*fhelp*##"
echo ""

# Last Words
echo "everything is done!"
echo "fhelp installed some useful helpers, and spoofed your hostname and MAC address for privacy."
echo "This project is licensed under the MIT License - see the [LICENSE](https://github.com/Obi83/fhelp/blob/main/LICENSE) file for details."
echo ""

# Reboot the system
echo "Rebooting the system to apply changes in 1 minute..."
shutdown -r +1
echo ""

# Ask the user if they want to cancel the reboot
read -p "Press 'c' to cancel the reboot or any other key to continue: " user_input

if [ "$user_input" = "c" ]; then
    echo "Cancelling the reboot..."
    shutdown -c
else
    echo "Reboot will proceed in 1 minute."
fi
