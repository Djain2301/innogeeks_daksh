#!/bin/bash
new_user(){
    echo "enter the new user name"
    read user_name
    echo "Do you want the home directory to be made with the user? type [y/n]"
    read ch
    if [ $ch=="y" ]
    then
    `useradd -m $user_name`
    else
    `useradd $user_name`
    fi
    if [ $? -eq 0 ]
    then 
    echo "User created"
    else
    echo "User not created"
    fi

}

new_group(){
    echo "enter the name of your new group"
    read name
    `groupadd $name`
    if [ $? -eq 0 ]
    then 
    echo "group created"
    else
    echo "group not created"
    fi
}

password(){
    echo "type the name of existing user for which you want to add the password"
    read name
    `passwd $name`
}

Delete_user(){
    echo "which user do you want to delete?"
    read user_name
    `userdel -r $user_name`
    if [ $? -eq 0 ]
    then 
    echo '"User deleted"'
    else
    echo "operation failed"
    fi
    echo "do you want to check if the user was deleted? [y/n]"
    read choice
    if [ $choice=="y" ]
    then
    id $user_name 
    else
    echo "OK"
    fi
}

Delete_group(){
    echo "enter the name of group you want to delete"
    read name
    `groupdel $name`
    if [ $? -eq 0 ]
    then 
    echo '"group deleted"'
    else
    echo "operation failed"
    fi
}

list_users(){
    echo "here is a list of all users on your system"
    awk -F':' '{ print $1}' /etc/passwd
}

echo "Hi there! Please enter your name"
read name
echo "Hi $name"



valid=true
while [ $valid ]
do
    echo -e "\nWhat do you want to do?"
    echo "1. Add a new user"
    echo "2. Add a new group"
    echo "3. Change password for an existing user"
    echo "4. Delete an user"
    echo "5. Delete a group"
    echo "6. List all the users"
    echo "7. Exit"
    read choice
    case "$choice" in
        "1") 
            new_user
            ;;
        "2") 
            new_group
            ;;
        "3") 
            password
            ;;
        "4") 
            Delete_user
            ;;
        "5")
            Delete_group
            ;;
	"6")
	    list_users
	    ;;
        "7")
            valid=false
            break
            ;;
        *) echo "Enter a valid choice" 
            ;;
    esac
done
