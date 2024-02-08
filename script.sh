#!/bin/bash

# User Management and Backup Script

# Function to display menu
display_menu() {
    echo "1. Add User"
    echo "2. Delete User"
    echo "3. List Users"
    echo "4. Create Backup of User Home Directories"
    echo "5. Exit"
}

# Function to add a new user
add_user() {
    read -p "Enter username: " username
    sudo useradd $username
    sudo passwd $username
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    sudo userdel -r $username
    echo "User $username deleted."
}

# Function to list all users
list_users() {
    cut -d: -f1 /etc/passwd
}

# Function to create a backup of user home directories
backup_users() {
    read -p "Enter backup directory: " backup_dir
    sudo mkdir -p $backup_dir

    for user_home in /home/*; do
        user=$(basename $user_home)
        sudo tar -czvf "$backup_dir/$user.tar.gz" -C /home $user
    done

    echo "Backup completed successfully!"
}

# Main script
while true; do
    display_menu

    read -p "Enter your choice: " choice

    case $choice in
        1) add_user ;;
        2) delete_user ;;
        3) list_users ;;
        4) backup_users ;;
        5) echo "Exiting script. Goodbye!"; exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done
