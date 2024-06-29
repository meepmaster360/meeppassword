#!/bin/bash

# File to store WiFi passwords
PASSWORD_FILE="$HOME/.wifi_passwords"

# Function to add a new WiFi password
add_password() {
    echo "Enter the WiFi SSID:"
    read ssid
    echo "Enter the WiFi password:"
    read -s password
    
    echo "$ssid:$password" >> "$PASSWORD_FILE"
    echo "Password for $ssid added."
}

# Function to view stored WiFi passwords
view_passwords() {
    if [[ -f "$PASSWORD_FILE" ]]; then
        echo "Stored WiFi passwords:"
        while IFS=: read -r ssid password; do
            echo "SSID: $ssid, Password: $password"
        done < "$PASSWORD_FILE"
    else
        echo "No passwords stored."
    fi
}

# Function to delete a WiFi password
delete_password() {
    echo "Enter the WiFi SSID to delete:"
    read ssid
    
    if [[ -f "$PASSWORD_FILE" ]]; then
        grep -v "^$ssid:" "$PASSWORD_FILE" > "$PASSWORD_FILE.tmp" && mv "$PASSWORD_FILE.tmp" "$PASSWORD_FILE"
        echo "Password for $ssid deleted."
    else
        echo "No passwords stored."
    fi
}

# Main menu
while true; do
    echo "WiFi Password Manager"
    echo "1. Add a new WiFi password"
    echo "2. View stored WiFi passwords"
    echo "3. Delete a WiFi password"
    echo "4. Exit"
    echo "Choose an option:"
    read option
    
    case $option in
        1)
            add_password
            ;;
        2)
            view_passwords
            ;;
        3)
            delete_password
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
