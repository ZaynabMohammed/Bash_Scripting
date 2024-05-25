#!/bin/bash
Flag=0
function Asking_User () {
				read -p "Press m to return to Menu OR q to Exit: " A
				if [ "$A" = "m" ]
				then
					 Flag=0				
				elif [ "$A" = "q"  ]
				then
					 exit
				else
			   	    	echo "U entered a wrong char"
					Flag=1		
				fi
			}

function Print_Record()	{
			
			echo "********************************"
			echo "___The_Contact_U_Search_For_____"
			echo "********************************"
			grep $1 < database.txt |while read FN LN M P
			do
				echo "FirstName: "$FN
				echo "LastName: "$LN
				echo "MAIL: "$M
				echo "PhoneNumber: "$P
			done	


		}
function View_Records (){
			
			local num=1
			while read FN LN M P
			do
				echo "***___ Contact $num ___*** "
				echo "FirstName: "$FN
				echo "LastName: "$LN
				echo "MAIL: "$M
				echo "PhoneNumber: "$P
				num=$[num+1]
			done < database.txt	
}	
	
function delete() {
			sed -i "/$1/d" database.txt &>/dev/null
	
			}
function Search () {
                		
				local Correct=0
				local count=3
				#set -x
				while [ "$Correct" -eq 0 ]
				do
					#echo "$count"
					read -p "Enter anything related to your search: " value
					grep "$value" database.txt >/dev/null
				       	if [ $(echo "$?") -eq "0" ]
					then
						Correct=1
						if [ $1 = 's' ]
						then
							#echo "*****Searching Done*****\n"
							Print_Record "$value"
						else
							delete "$value"
						fi	
					else
						echo "your value isnot exist, please try again, U have $((count-1)) Trials"
						
						if [ $count -gt 1 ]
						then
							count=$[count-1]	
							continue
						else
							echo "U finished your Trials"
							Correct=1
						fi	
					fi
				done
				#set +x
}	

while [ "$Flag" -eq 0  ]
do
   echo "************Main Menu************"
   echo "
   press i to add new contact
   press v to view all contacts
   press s to search for record
   press e to delete all contacts
   press d to delete one contact
   press q to exit
                               "
	
   read -p "Press your Choice: " ANSWER
   array=("i" "s" "v" "e" "d" "q")
   element="$ANSWER"
   if [[ !(${array[@]} =~ $element) ]]
   then
  	echo "U enter a Wrong char, try again later"
	Flag=1
   fi
		
 	case "$ANSWER" in
		 i)
			touch ./database.txt	 
			read -p "Enter your First Name:" FirstName
			read -p "Enter your Last Name:" LastName
			read -p "Enter your E-Mali:" Mail
			read -p "Enter ypur Phone:" Phone
			echo "$FirstName $LastName $Mail $Phone" >>database.txt	
			Asking_User
		 	;;
		 v)
		 	View_Records	
			Asking_User

		 	;;
		 s)
			 Search 's'
			 Asking_User
		 	;;
		 e)
			 > database.txt
			 Asking_User 
			 
		 	;;
		 d)
			Search 'd'
			delete
			Asking_User
		 	;;
		 q)
			 exit
		 	;;

	 esac

 done	 

