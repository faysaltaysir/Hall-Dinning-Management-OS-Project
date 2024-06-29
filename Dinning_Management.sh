#!/bin/bash
declare -a foods
a=1
USERLIST_FILE="userList.txt"
USERIDFILE="userId.txt"
ADMINLIST_FILE="adminList.txt"
TOKEN_FILE="tokenBuyList.txt"
check_credentials() {
    local username=$1
    local password=$2
    local LIST_FILE=$3
    while IFS=: read -r stored_username stored_password; do
        if [[ "$username" == "$stored_username" && "$password" == "$stored_password" ]]; then
            echo "successful"
            return 0
        fi
    done < "$LIST_FILE"

    echo "failed"
    return 1
}

check_tokenbuy() {
    local username=$1
    local number=$2
    local LIST_FILE=$3
    total=0
    while IFS=: read -r stored_username stored_number; do
        if [[ "$username" == "$stored_username" ]]; then
            let total=total+stored_number
            # echo "present"
            # return 0
        fi
    done < "$LIST_FILE"
    echo $total
    return 1
}

check_validId() {
    local username=$1
    local LIST_FILE=$2

    while read -r stored_username; do
        if [[ "$username" == "$stored_username" ]]; then
            echo "valid"
            return 0
        fi
    done < "$LIST_FILE"

    echo "invalid"
    return 1
}
check_validId2() {
    local username=$1
    local LIST_FILE=$2

    while IFS=: read -r stored_username stored_password; do
        if [[ "$username" == "$stored_username" ]]; then
            echo in"valid"
            return 0
        fi
    done < "$LIST_FILE"

    echo "valid"
    return 1
}

calculate_total(){
    local TOKENFILE=$1
    sum=0
    while IFS=: read -r stored_id stored_num;do
        let sum=sum+stored_num
    done < "$TOKENFILE"
    echo $stored_id $sum
}



while [ $a = 1 ]
    do
        echo "### Hall Dinning Management ###"
        echo "choose your option"
        echo "1) Admin Login"
        echo "2) User Login"
        echo "3) Exit"
        echo "4) User Register"
        read -p "Input your choice: " temp
        echo
        echo
        if [ $temp = 3 ];then
            a=-1;
        fi
        flag5=0
        flag3=0
        while  [ $temp = 1 ]
            do
                if [ $flag3 = 0 ];then
                    echo "## Admin Login Interface ##"
                    echo "Input your credential"
                    
                    read -p "Username: " userX 
                    read -p "Password: " passX
                    res2=$(check_credentials "$userX" "$passX" "$ADMINLIST_FILE")
                    echo "Login $res2"
                fi
                if [ $res2 = "successful" ];then
                    if [ flag5 = 0 ];then
                        
                        echo "---------------------------------"
                        echo "        Successfully LogIn       "
                        echo "---------------------------------"
                        flag5=1
                    fi
                    echo "# Welcome to Admin Pannel"
                    echo
                    echo
                    echo "choose your option"
                    echo "1) Update food menu"
                    echo "2) Token sell list view"
                    echo "3) Log Out from Admin Pannel"
                    read -p "Input your choice: " option
                    if [ $option = 3 ];then

                        echo "-------------------------"
                        echo "   Successfully Logout   "
                        echo "-------------------------"
                        flag3=0
                        break;
                    fi
                    flag2=0
                    while [ $option = 1 -a $flag2 = 0 ]
                        do
                            
                            echo
                            echo "Input the name today's food menu "
                            echo "-> write 'done' to end inputs"
                            
                            i=0
                            # read -p "Day Number: " day
                            current_date_time=$(date +"%d-%m-%y")
                            flag4=0
                            while [ 1 ]
                                do  
                                    if [ $flag4 = 0 ];then
                                        echo "--------------------" >> foodMenu.txt
                                        echo "${current_date_time}" >> foodMenu.txt
                                        echo "--------------------" >> foodMenu.txt
                                        flag4=1
                                    fi
                                    echo "--------------------"
                                    echo "${current_date_time}"
                                    echo "--------------------"

                                    echo "1) Update todays Lunch: "
                                    echo "2) Update todays Dinner: "
                                    echo "3) Exit"
                                    read -p "Choose your option: " x
                                    if [ $x = 1 ];then
                                        echo "## Lunch Item -> " >> foodMenu.txt 
                                        menu="none"
                                        i=0
                                        while [ "$menu" != "done" ]
                                        do
                                            read -r menu
                                            # echo "$menu"
                                            if [ "$menu" != "done" ];then
                                                let i=i+1
                                                echo "$i)$menu" >> foodMenu.txt
                                            fi
                                        done
                                        echo "" >> foodMenu.txt
                                    elif [ $x = 2 ];then
                                        echo "## Dinner Item -> Day ${current_date_time}: " >> foodMenu.txt 
                                        menu="none"
                                        i=0
                                        while [ $menu != "done" ]
                                        do
                                            read -r menu
                                            if [ $menu != "done" ];then
                                                let i=i+1
                                                echo "$i)$menu" >> foodMenu.txt
                                            fi
                                        done
                                        echo "" >> foodMenu.txt
                                    elif [ $x = 3 ];then
                                        flag2=1
                                        flag3=1
                                        break;
                                    fi 
                                done
                            # echo
                            # echo
                            # echo "choose your option"
                            # echo "1) Update food menu"
                            # echo "2) Token sell list view"
                            # echo "3) Log Out from Admin Pannel"
                            # read -p "Input your choice: " option
                            # if [ $option = 3 ];then
                            #     temp=-1
                            # fi
                            # if [ $option = 2 ];then
                            #     break;
                            # fi
                        done
                    if [ $option = 2 ];then
                        echo "ID     :TokenBought"
                        cat $TOKEN_FILE
                        # bought=$(check_tokenbuy "$userU" "$num" "tokenBuyList.txt")
                        result=$(calculate_total $TOKEN_FILE)
                        echo "Total Sold number: $result"
                        flag3=1
                    fi

                elif [ $res2 != "successful" ];then

                    echo "1) press "1" to continue"
                    echo "2) press "2" to Exit"
                    read -p "Input: " inp
                    if [ $inp = 2 ];then
                        temp=-1;
                        break;
                    fi    
                fi
                echo
                echo
            done
            
        while [ $temp = 2 ]
            do
                
                echo "## User Login Interface ##"
                echo 
                echo
                read -p "username: " userU
                read -p "password: " passU
                res=$(check_credentials "$userU" "$passU" "$USERLIST_FILE")
                echo "Login $res"
                flag=1
                while [ $res = "successful" ]
                do  
                    if [ $flag = 1 ];then
                        echo "---------------------------------"
                        echo "        Successfully LogIn       "
                        echo "---------------------------------"
                        flag=0
                    fi
                    echo "choose your option"
                    echo "1) See Food Menu"
                    echo "2) Buy Token"
                    echo "3) See token due"
                    echo "4) Logout from your profile"
                    read -p "Input your choice: " option
                    if [ $option = 1 ];then
                        echo 
                        cat foodMenu.txt
                    fi
                    if [ $option = 2 ];then
                        current_date_time=$(date +"%d-%m-%y")
                        read -p "Number of token want to buy: " num
                        echo "$userU:$num" >> "tokenBuyList.txt"
                        bought=$(check_tokenbuy "$userU" "$num" "tokenBuyList.txt")
                        echo
                        echo "Total token bought: $bought"
                        let tot=bought*80
                        echo "Total amount due: $tot"
                        # check=$(check_validId "$userId" "totalBuy.txt")
                        # if [ "$check" = "valid" ];then
                        #     echo "$userU : $bought : $tot" >> "totalBuy.txt"
                        # fi
                        

                    fi
                    if [ $option = 3 ];then
                        # read -p "Number of token want to buy" num
                        # echo "$userU:$num" >> "tokenBuyList.txt"
                        bought=$(check_tokenbuy "$userU" "$num" "tokenBuyList.txt")
                        echo "Total token bought: $bought"
                        let tot=bought*80
                        echo "Total amount due: $tot"

                    fi
                    if [ $option = 4 ];then
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
                checkId=$(check_validId "$username" "$USERIDFILE")
                checkId2=$(check_validId2 "$username" "$USERLIST_FILE")
                # echo $checkId
                # echo $checkId2
                if [ "$checkId" = "invalid" ];then
                    echo "UserId is not a member of the House."
                    echo
                    break;
                elif [ "$checkId2" = "invalid" ];then
                    echo "Already you have an account."
                    echo
                    break;
                elif [ "$confpass" = "$password" -a "$checkId2" = "valid" ];then
                    echo "Password Matched"
                    echo "Account Created Successfully"
                    echo "$username":"$password" >> userList.txt
                    # echo $username:$password >> adminList.txt
                    # checkId="invalid"
                    break;        
                fi
            done
    done
#./Dinning_Management.sh