#!/bin/bash

function add_user {
    read -p "Enter username to add: " username
    useradd $username
    echo "User $username added."
}

function modify_user {
    PS3="Select an option: "
    options=("Change password" "Add to group" "Remove from group" "Exit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Change password")
                read -p "Enter username to change password: " username
                passwd $username
                ;;
            "Add to group")
                read -p "Enter username to add to group: " username
                read -p "Enter group name: " groupname
                usermod -aG $groupname $username
                ;;
            "Remove from group")
                read -p "Enter username to remove from group: " username
                read -p "Enter group name: " groupname
                gpasswd -d $username $groupname
                ;;
            "Exit")
                break
                ;;
            *) echo "Invalid option $REPLY";;
        esac
    done
}

function list_users {
    cut -d: -f1 /etc/passwd
}

function add_group {
    read -p "Enter group name to add: " groupname
    groupadd $groupname
    echo "Group $groupname added."
}

function modify_group {
    PS3="Select an option: "
    options=("Add user to group" "Remove user from group" "Exit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Add user to group")
                read -p "Enter group name to add user: " groupname
                read -p "Enter username: " username
                usermod -aG $groupname $username
                ;;
            "Remove user from group")
                read -p "Enter group name to remove user: " groupname
                read -p "Enter username: " username
                gpasswd -d $username $groupname
                ;;
            "Exit")
                break
                ;;
            *) echo "Invalid option $REPLY";;
        esac
    done
}

function list_groups {
    cut -d: -f1 /etc/group
}

function disable_user {
    read -p "Enter username to disable: " username
    usermod -L $username
    echo "User $username disabled."
}

function enable_user {
    read -p "Enter username to enable: " username
    usermod -U $username
    echo "User $username enabled."
}

function change_password {
    read -p "Enter username to change password: " username
    passwd $username
}

echo "========================================================================================================================="
echo "							  _   _   _   _   _   _					  "
echo "							 / \ / \ / \ / \ / \ / \				  "
echo "							( H | I | C | K | E | R )				  "
echo " 							 \_/ \_/ \_/ \_/ \_/ \_/				  "
echo "                     							by yousefyahia		  	  "
echo "=========================================================================================================================="
while true; do
    PS3="Choose an option: "
    options=("Add user" "Modify user" "List users" "Add group" "Modify group" "List groups" "Disable user account" "Enable user account" "Change user password" "Exit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Add user")
                add_user
                break
                ;;
            "Modify user")
                modify_user
                break
                ;;
            "List users")
                list_users
                break
                ;;
            "Add group")
                add_group
                break
                ;;
            "Modify group")
                modify_group
                break
                ;;
            "List groups")
                list_groups
                break
                ;;
            "Disable user account")
                disable_user
                break
                ;;
            "Enable user account")
                enable_user
                break
                ;;
            "Change user password")
                change_password
                break
                ;;
            "Exit")
                exit 0
                ;;
            *) echo "Invalid option $REPLY";;
        esac
    done
done
