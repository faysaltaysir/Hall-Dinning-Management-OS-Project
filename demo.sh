while IFS=: read -r stored_id stored_num;do
                            
                            if [ $stored_id = $userU ];then
                                let sum=num+stored_num
                                echo "in"
                                if [ $sum < 30 ];then
                                    echo "$userU:$sum" >> "tokenBuyList.txt"
                                    echo "token bought sucessfully"
                                    let total=num*2*40
                                    echo "Total due: $total tk"
                                    break;
                                else
                                    echo "Can't buy more than 30 days"
                                    break;
                                fi
                            else 
                                echo "$userU:$num" >> "tokenBuyList.txt"
                                echo "token bought sucessfully"
                                let total=num*2*40
                                echo "Total due: $total tk"
                                break;
                            # echo $stored_id
                            fi    
                        done < "$TOKEN_FILE"