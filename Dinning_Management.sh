#!/bin/bash
declare -a foods
a=1
USERLIST_FILE="userList.txt"
check_credentials() {
    local username=$1
    local password=$2

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
                echo "Given Credentials"
                echo
                echo "Username = "user""
                echo "password = 123"
                echo
                managerUser=user
                managerPass=123
                read -p "Username: " user 
                read -p "Password: " pass
                echo
                echo
                while [[ $managerUser != $user || $managerPass != $pass ]]
                do
                    echo "Wrong Credential! Try Again"
                    echo
                    echo
                    read -p "Username: " user 
                    read -p "Password: " pass
                done
                echo "# Welcome to Admin Pannel Mr. $managerUser #"
                echo
                echo
                echo "choose your option"
                echo "1) Update food menu"
                echo "2) Update token list"
                read -p "Input your choice: " option
                while [ $option = 1 ]
                    do
                        echo
                        echo
                        echo "Input the name today's food menu "
                        echo "note: food name should be one word ~> Needs to update"
                        echo "~> write 'done' to end inputs"
                        read -r menu
                        i=0
                        while [ $menu != "done" ]
                            do
                                foods[i]=$menu
                                i=$i+1
                                read -r menu
                            done
                        echo
                        echo
                        echo "choose your option"
                        echo "1) Update food menu"
                        echo "2) Update token list ~~> not available write now"
                        echo "3) Exit"
                        read -p "Input your choice: " option
                        if [ $option = 3 ];then
                            temp=-1
                        fi
                    done
                    echo
                    echo
            done
            
        while [ $temp = 2 ]
            do
                echo
                echo
                echo "## User Login Interface ##"
                echo 
                echo
                read -p "username" userU
                read -p "password" passU
                res=$(check_credentials "$userU" "$passU")
                echo "Login $res"
                while [ $res = "successful" ]
                do
                    echo "choose your option"
                    echo "1) See Today's Menu"
                    echo "3) Logout from your profile"
                    read -p "Input your choice: " option
                    if [ $option = 1 ];then
                        echo 
                        i=1
                        for item in ${foods[@]}
                            do
                                echo "$i) $item"
                                i=$((i + 1))
                            done
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