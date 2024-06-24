#!/bin/bash
declare -a foods
a=1
USERLIST_FILE="userList.txt"
check_credentials() {
    local username=$1
    local password=$2
    # local USERLIST_FILE=$3
    while IFS=: read -r stored_username stored_password; do
        if [[ "$username" == "$stored_username" && "$password" == "$stored_password" ]]; then
            echo "successful"
            return 0
        fi
    done < "$USERLIST_FILE"

    echo "failed"
    return 1
}



while [ $a = 1 ]
    do
        echo "### Hall Dinning Management ###"
        echo "choose your option"
        echo "1) Admin Login ~> update food menu"
        echo "2) User Login ~> see food menu"
        echo "4) User Register"
        echo "3) Exit"
        read -p "Input your choice: " temp
        echo
        echo
        if [ $temp = 3 ];then
            a=-1;
        fi
        while  [ $temp = 1 ]
            do
                echo "## Admin Login Interface ##"
                echo "Input your credential"
                
                read -p "Username: " user 
                read -p "Password: " pass
                res=$(check_credentials "$user" "$pass")
                echo "Login $res"
                
                if [ $res = "successful" ];then

                    echo "---------------------------------"
                    echo "        Successfully LogIn       "
                    echo "---------------------------------"
                    echo "# Welcome to Admin Pannel Mr. $user"
                    echo
                    echo
                    echo "choose your option"
                    echo "1) Update food menu"
                    echo "2) Update token list"
                    echo "3) Log Out from Admin Pannel"
                    read -p "Input your choice: " option
                    if [ $option = 3 ];then

                        echo "-------------------------"
                        echo "   Successfully Logout   "
                        echo "-------------------------"
                        break;
                    fi
                    while [ $option = 1 ]
                        do
                            
                            echo
                            echo "Input the name today's food menu "
                            echo "note: food name should be one word ~> Needs to update"
                            echo "-> write 'done' to end inputs"
                            
                            i=0
                            read -p "Day Number: " day
                            while [ 1 ]
                                do
                                    echo "1) Update todays Lunch: "
                                    echo "2) Update todays Dinner: "
                                    echo "3) Exit"
                                    read -p "Choose your option: " x
                                    if [ $x = 1 ];then
                                        echo "## Lunch Item -> Day ${day}: " >> foodMenu.txt 
                                        menu="none"
                                        i=0
                                        while [ $menu != "done" ]
                                        do
                                            read menu
                                            if [ $menu != "done" ];then
                                                let i=i+1
                                                echo "$i)$menu" >> foodMenu.txt
                                            fi
                                        done
                                        echo "" >> foodMenu.txt
                                    elif [ $x = 2 ];then
                                        echo "## Dinner Item -> Day ${day}: " >> foodMenu.txt 
                                        menu="none"
                                        i=0
                                        while [ $menu != "done" ]
                                        do
                                            read menu
                                            if [ $menu != "done" ];then
                                                let i=i+1
                                                echo "$i)$menu" >> foodMenu.txt
                                            fi
                                        done
                                        echo "" >> foodMenu.txt
                                    elif [ $x = 3 ];then
                                        break;
                                    fi 
                                done
                            echo
                            echo
                            echo "choose your option"
                            echo "1) Update food menu"
                            echo "2) Update token list ~~> not available write now"
                            echo "3) Log Out from Admin Pannel"
                            read -p "Input your choice: " option
                            if [ $option = 3 ];then
                                temp=-1
                            fi
                        done
                elif [ $res != "successful" ];then

                    echo "press "1" to continue"
                    echo "press "2" to Exit"
                    read -p "Input" inp
                    if [ inp = 2 ];then
                        break;
                    fi    
                fi
                echo
                echo
            done
            
        while [ $temp = 2 ]
            do
                echo "---------------------------------"
                echo "        Successfully LogIn       "
                echo "---------------------------------"
                echo "## User Login Interface ##"
                echo "Welcome $user"
                echo 
                echo
                read -p "username: " userU
                read -p "password: " passU
                res=$(check_credentials "$userU" "$passU" "userList.txt")
                echo "Login $res"
                while [ $res = "successful" ]
                do
                    echo "choose your option"
                    echo "1) See Food Menu"
                    echo "3) Logout from your profile"
                    read -p "Input your choice: " option
                    if [ $option = 1 ];then
                        echo 
                        cat foodMenu.txt
                    fi
                    if [ $option = 3 ];then
                        temp=-1
                        res="unsucessful"
                    fi
                done
                if [ $temp != -1 ];then
                    echo "choose your option"
                    echo "1) Continue to login"
                    echo "2) Exit"
                    read -p "Input your choice: " option2
                    if [ $option2 = 2 ];then
                        temp=-1
                    fi
                fi
            done
            echo
            echo
        while [ $temp = 4 ]
            do
                echo "Create a new account"
                read -p "Username: " username
                read -p "Password: " password
                read -p "Confirm password: " confpass
                if [ $confpass = $password ];then
                    echo "Password Matched"
                    echo "Account Created Successfully"
                    echo $username:$password >> userList.txt
                    break;
                fi
            done
    done
#./Dinning_Management.sh