#!/bin/bash

# Universal Linux Software Installer Script
# Works on Debian/Ubuntu, Fedora, and Arch-based distributions

# Function to check if a package is installed
is_package_installed() {
    if command -v apt &> /dev/null; then
        dpkg -l | grep -qw "$1"
    elif command -v dnf &> /dev/null; then
        rpm -q "$1" &> /dev/null
    elif command -v pacman &> /dev/null; then
        pacman -Qi "$1" &> /dev/null
    else
        echo "Unsupported package manager"
        exit 1
    fi
}

# Function to install packages
install_package() {
    local pkg="$1"
    echo -e "\nChecking: $pkg"
    
    if is_package_installed "$pkg"; then
        read -p "$pkg is already installed. Update? [Y/n]: " update_choice
        if [[ $update_choice =~ ^[Yy]$ || $update_choice == "" ]]; then
            echo "Updating $pkg..."
            if command -v apt &> /dev/null; then
                sudo apt install --only-upgrade -y "$pkg"
            elif command -v dnf &> /dev/null; then
                sudo dnf upgrade -y "$pkg"
            elif command -v pacman &> /dev/null; then
                sudo pacman -Syu --noconfirm "$pkg"
            fi
        fi
    else
        read -p "Install $pkg? [Y/n]: " install_choice
        if [[ $install_choice =~ ^[Yy]$ || $install_choice == "" ]]; then
            echo "Installing $pkg..."
            if command -v apt &> /dev/null; then
                sudo apt install -y "$pkg"
            elif command -v dnf &> /dev/null; then
                sudo dnf install -y "$pkg"
            elif command -v pacman &> /dev/null; then
                sudo pacman -S --noconfirm "$pkg"
            fi
            
            # Verify installation
            if ! is_package_installed "$pkg"; then
                echo -e "\e[31mError: Failed to install $pkg\e[0m"
            fi
        fi
    fi
}

# Main script
clear
echo -e "\n\e[44m========== Universal Linux Software Installer ==========\e[0m\n"

# Initial system update
echo -e "\e[33mPerforming initial system update...\e[0m"
if command -v apt &> /dev/null; then
    sudo apt update && sudo apt upgrade -y
elif command -v dnf &> /dev/null; then
    sudo dnf upgrade -y
elif command -v pacman &> /dev/null; then
    sudo pacman -Syu --noconfirm
fi

# Software list with category headers
declare -A software=(
    ["Security"]="clamav"
    ["Office Suite"]="libreoffice"
    ["Media Players"]="vlc mpv"
    ["Video Editors"]="kdenlive openshot"
    ["Photo Editors"]="gimp darktable"
    ["Utilities"]="htop neofetch gnome-tweaks"
    ["Development"]="git vim code"
)

# Show software list with numbers
echo -e "\n\e[1mAvailable Software Packages:\e[0m"
count=1
for category in "${!software[@]}"; do
    echo -e "\n\e[32m$category:\e[0m"
    for pkg in ${software[$category]}; do
        echo "  $count. $pkg"
        ((count++))
    done
done

# Package installation loop
echo -e "\n\e[36mEnter package numbers to install (comma-separated):\e[0m"
read -p "Selection: " selections

IFS=',' read -ra selected_indices <<< "$selections"
#!/bin/bash

# Universal Linux Software Installer Script
# Works on Debian/Ubuntu, Fedora, and Arch-based distributions

# Function to check if a package is installed
is_package_installed() {
    if command -v apt &> /dev/null; then
        dpkg -l | grep -qw "$1"
    elif command -v dnf &> /dev/null; then
        rpm -q "$1" &> /dev/null
    elif command -v pacman &> /dev/null; then
        pacman -Qi "$1" &> /dev/null
    else
        echo "Unsupported package manager"
        exit 1
    fi
}

# Function to install packages
install_package() {
    local pkg="$1"
    echo -e "\nChecking: $pkg"
    
    if is_package_installed "$pkg"; then
        read -p "$pkg is already installed. Update? [Y/n]: " update_choice
        if [[ $update_choice =~ ^[Yy]$ || $update_choice == "" ]]; then
            echo "Updating $pkg..."
            if command -v apt &> /dev/null; then
                sudo apt install --only-upgrade -y "$pkg"
            elif command -v dnf &> /dev/null; then
                sudo dnf upgrade -y "$pkg"
            elif command -v pacman &> /dev/null; then
                sudo pacman -Syu --noconfirm "$pkg"
            fi
        fi
    else
        read -p "Install $pkg? [Y/n]: " install_choice
        if [[ $install_choice =~ ^[Yy]$ || $install_choice == "" ]]; then
            echo "Installing $pkg..."
            if command -v apt &> /dev/null; then
                sudo apt install -y "$pkg"
            elif command -v dnf &> /dev/null; then
                sudo dnf install -y "$pkg"
            elif command -v pacman &> /dev/null; then
                sudo pacman -S --noconfirm "$pkg"
            fi
            
            # Verify installation
            if ! is_package_installed "$pkg"; then
                echo -e "\e[31mError: Failed to install $pkg\e[0m"
            fi
        fi
    fi
}

# Main script
clear
echo -e "\n\e[44m========== Universal Linux Software Installer ==========\e[0m\n"

# Initial system update
echo -e "\e[33mPerforming initial system update...\e[0m"
if command -v apt &> /dev/null; then
    sudo apt update && sudo apt upgrade -y
elif command -v dnf &> /dev/null; then
    sudo dnf upgrade -y
elif command -v pacman &> /dev/null; then
    sudo pacman -Syu --noconfirm
fi

# Software list with category headers
declare -A software=(
    ["Security"]="clamav"
    ["Office Suite"]="libreoffice"
    ["Media Players"]="vlc mpv"
    ["Video Editors"]="kdenlive openshot"
    ["Photo Editors"]="gimp darktable"
    ["Utilities"]="htop neofetch gnome-tweaks"
    ["Development"]="git vim code"
)

# Show software list with numbers
echo -e "\n\e[1mAvailable Software Packages:\e[0m"
count=1
for category in "${!software[@]}"; do
    echo -e "\n\e[32m$category:\e[0m"
    for pkg in ${software[$category]}; do
        echo "  $count. $pkg"
        ((count++))
    done
done

# Package installation loop
echo -e "\n\e[36mEnter package numbers to install (comma-separated):\e[0m"
read -p "Selection: " selections

IFS=',' read -ra selected_indices <<< "$selections"

# Convert indices to package names
selected_packages=()
count=1
for category in "${!software[@]}"; do
    for pkg in ${software[$category]}; do
        for index in "${selected_indices[@]}"; do
            if [[ $index == $count ]]; then
                selected_packages+=("$pkg")
            fi
        done
        ((count++))
    done
done

# Install selected packages
for pkg in "${selected_packages[@]}"; do
    install_package "$pkg"
done

echo -e "\n\e[42m========== Installation Complete ==========\e[0m"
echo -e "\nInstalled software:"
for pkg in "${selected_packages[@]}"; do
    if is_package_installed "$pkg"; then
        echo -e "\e[32m✓ $pkg\e[0m"
    else
        echo -e "\e[31m✗ $pkg\e[0m"
    fi
done

echo -e "\nRun this script again to update or install additional packages."
