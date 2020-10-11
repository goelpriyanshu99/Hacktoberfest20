#!/bin/bash

#A simple password locker coded in BASH.do not use this for storing sensitive information.only use this for educational purposes only.y


function requirements_banner      #function for printing requirements installation confirmation dialogue 
{
	echo -e "\e[31m\nDid you run requirments.sh before executing this script?(Y/N)\e[0m"
	read choice
	case $choice in
		y|Y)
			echo "You Are Good To Go..Starting " | lolcat
			sleep 2
		        clear
			;;
		n|N )
			echo -e  "\n\e[42m\e[30mPlease run requirements.sh before executing this script\e[0m"
			echo -e "\n\e[1;31mExiting\e[0m"
			sleep 2
			exit
			;;
	esac
}

welcome_banner()      #function for printing welcome message
{
	figlet "SafePass" | lolcat 2>&1 
        echo -e "\n\e[1m          KEEP KEYRINGS SAFE\e[0m" |lolcat
	echo -e  "\n<<coded by @codedtrap>>" | lolcat
	echo -e "\n<<Instagram:@codedtrap>>" | lolcat
	echo -e "\n\e[1m***DO NOT SAVE SENSITIVE DATA WITH THIS***\e[0m" | lolcat
#lolcat is the ruby package used for graphical alterations
}
sign()          #function for creating profile 
{
	read -p  "Please Enter Password:" password
	read -sp "Confirm Password:" password_2
	if [ $password == $password_2 ]
	then
		echo -e "\nCreating Your Profile..." | lolcat
		echo $password | md5sum > .safepass_saved.config
		#writing password md5 hash sum to config file for enhanced security
		echo $password | gpg --batch --yes --passphrase-fd 0 -c .safepass_saved.config
		#gpg used for encryption of passwords
		rm .safepass_saved.config
		#thus encrypted file created,deleting source file used for encryption
	else
		echo -e "\nSorry..The Entered Passwords Doesn't Match..."
		sign
		#using recursion for retrying on failed password matches
	fi
}

auth_start()                #function for storing and encrypting passwords through menu
{
	sec_file=".safepass_saved.config.gpg"
	if [ -e "$sec_file" ]          #checking if encrypted file exists
	then
		echo -e  "\nWelcome Back,Do you want to use your existing account(Y/n)\e[1m\nSelecting NO will erase all your data!!!\e[0m" | lolcat
		read choice   #reading variable for user's choice about account management
		case $choice in
			Y|y|YES|yes)
				read -sp "Enter Password:"  test_pass
				echo $test_pass | gpg --batch --yes --passphrase-fd 0 ".safepass_saved.config.gpg" 2> .safepass_latest_logs.txt
				local filename=".safepass_saved.config"
				if [ -e "$filename" ]
				then
					clear
					figlet "welcome" | lolcat
					figlet "       TO       " | lolcat
					welcome_banner
					echo -e "\nStarting...please wait.." | lolcat
					echo $test_pass | gpg --batch --yes --passphrase-fd 0 -c ".safepass_saved.config"
					rm .safepass_saved.config
					date >> .safepass_latest_logs.txt
					#storing date for classification of log entries
					sleep 3
					show_menu
				else
					echo -e "\nSorry..Your keyring doesn't match..." | lolcat
					echo -e "\nPlease try again..." | lolcat
				  	auth_start
				fi
				;;
			N|NO|n|no)
				rm ".safepass_saved.config.gpg"  #deleting encrypted file
				rm -rf .safepass  #deleting secret folder 
				rm .safepass_latest_logs.txt  #deleting log file
				echo -e  "\n\e[1mAll Data Deleted!!!Restarting...\e[0m" | lolcat
				sleep 3
				auth_start #starting again using recursion
				;;
		esac
	else
		echo -e "\e[1mWELCOME.PLEASE CREATE YOUR PROFILE...\e[0m"
		sign     #function for creating new_profile
		date >> .safepass_latest_logs.txt  
		show_menu    # jumping to menu for storing passwords
	fi
}

show_menu()
{
	echo -e "\n\n\e[1m     PLEASE CHOOSE AN OPTION     \e[0m" | lolcat
	echo -e "\n\e[1;33m[\e[0m\e[1;32m1\e[0m\e[1;33m]\e[0m \e[1;31mFacebook\e[0m"
	echo -e "\n\e[1;33m[\e[0m\e[1;32m2\e[0m\e[1;33m]\e[0m \e[1;31mInstagram\e[0m"
	echo -e "\n\e[1;33m[\e[0m\e[1;32m3\e[0m\e[1;33m]\e[0m \e[1;31mGoogle\e[0m"
	echo -e "\n\e[1;33m[\e[0m\e[1;32m4\e[0m\e[1;33m]\e[0m \e[1;31mCustom App Keyrings\e[0m"
	if [ -e ".safepass_saved.config.gpg" ]
	then
		echo -e "\n\e[1;33m[\e[0m\e[1;32mR\e[0m\e[1;33m]\e[0m \e[1;31mReset Account\e[0m"
	fi
	if [ -e "safepass/.cred_secured/.fb_creds/.sec_cred.txt.gpg" ]
	then
		echo -e "\n\e[1;33m[\e[0m\e[1;32m5\e[0m\e[1;33m]\e[0m \e[1;31mGet Your Saved Keys\e[0m"
	elif [ -e ".safepass/.cred_secured/.ig_creds/.sec_cred.txt.gpg" ]
	then
		echo -e "\n\e[1;33m[\e[0m\e[1;32m5\e[0m\e[1;33m]\e[0m \e[1;31mGet Your Saved Keys\e[0m"
	elif [ -e ".safepass/.cred_secured/.go_creds/.sec_cred.txt.gpg" ]
	then
		echo -e "\n\e[1;33m[\e[0m\e[1;32m5\e[0m\e[1;33m]\e[0m \e[1;31mGet Your Saved Keys\e[0m"
	elif [ -e ".safepass/.cred_secured/.custom" ]
	then
		echo -e "\n\e[1;33m[\e[0m\e[1;32m5\e[0m\e[1;33m]\e[0m \e[1;31mGet Your Saved Keys\e[0m"
	fi
	echo -e "\n\e[1;33m[\e[0m\e[1;32mX\e[0m\e[1;33m]\e[0m \e[1;31mExit\e[0m"	
	read -p "Enter Your Option:" option_1    #reading variable option_1 for choice of user
	accept_choice $option_1  #passing read variable to accept_choice function as arguement
}

accept_choice()
{
	tmp=$1    #reading passed arguement
	case $tmp in
		1)
			local fbname    #fb_user_name
			local fbpass   #fb_password
			read -p "Enter Username:" fbname
			read -sp "Enter Password:" fbpass
			mkdir -p .safepass/.cred_secured/.fb_creds
			echo -e "\n\n"
			read -sp "Enter password to save:" pass_007 | lolcat
			echo $pass_007 | gpg --batch --yes --passphrase-fd 0 ".safepass_saved.config.gpg" 2>> .safepass_latest_logs.txt
			local filename=".safepass_saved.config"
			if [ -e "$filename" ]
			then
				rm ".safepass_saved.config.gpg"
				echo $fbname > .safepass/.cred_secured/.fb_creds/.sec_cred.txt
				echo $fbpass >> .safepass/.cred_secured/.fb_creds/.sec_cred.txt
				echo $pass_007 | gpg --batch --yes --passphrase-fd 0 -c ".safepass/.cred_secured/.fb_creds/.sec_cred.txt"
				echo -e "\nChecking Password......"
				unset fbname
				unset fbpass
				sleep 2
				echo -e "\n Data Saved" | lolcat
				echo $pass_007 | gpg --batch --yes --passphrase-fd 0 -c ".safepass_saved.config"
				rm ".safepass_saved.config"
				show_menu
			else
				echo -e "\nThe entered password was wrong" | lolcat
				echo -e "\nPlease try again..." | lolcat
				show_menu     #jumping back to menu
			fi
			;;
		2)
			local igpass     #ig_password
			local igname     #ig_username
			read -p "Enter Username:" igname
			read -sp "Enter Password:" igpass
			mkdir -p .safepass/.cred_secured/.ig_creds
			echo -e "\n\n"
			read -sp "Enter password to save:" pass_007
			echo $pass_007 | gpg --batch --yes --passphrase-fd 0 ".safepass_saved.config.gpg" 2>> .safepass_latest_logs.txt
			local filename=".safepass_saved.config"
			if [ -e "$filename" ]
			then
				rm ".safepass_saved.config.gpg"
				echo $igname > .safepass/.cred_secured/.ig_creds/.sec_cred.txt
				echo $igpass >> .safepass/.cred_secured/.ig_creds/.sec_cred.txt
				echo $pass_007 | gpg --batch --yes --passphrase-fd 0 -c ".safepass/.cred_secured/.ig_creds/.sec_cred.txt"
				echo -e "\nChecking Password......"
				unset igname
				unset igpass
				sleep 2
				echo -e "\n Data Saved" | lolcat
				echo $pass_007 | gpg --batch --yes --passphrase-fd 0 -c ".safepass_saved.config"
				rm ".safepass_saved.config"
				show_menu
			else
				echo -e "\nThe entered password was wrong" | lolcat
				echo -e "\nPlease try again..." | lolcat
				show_menu
			fi
			;;
		3)
			local gname   #google_username
			local gpass   #google_password
			read -p "Enter Username:" gname
			read -sp "Enter Password:" gpass
			mkdir -p .safepass/.cred_secured/.go_creds
			echo -e "\n\n"
			read -sp "Enter password to save:" pass_007
			echo $pass_007 | gpg --batch --yes --passphrase-fd 0 ".safepass_saved.config.gpg" 2>> .safepass_latest_logs.txt
			local filename=".safepass_saved.config"
			if [ -e "$filename" ]
			then
				rm ".safepass_saved.config.gpg"
				echo $gname > .safepass/.cred_secured/.go_creds/.sec_cred.txt
				echo $gpass >> .safepass/.cred_secured/.go_creds/.sec_cred.txt
				echo $pass_007 | gpg --batch --yes --passphrase-fd 0 -c ".safepass/.cred_secured/.go_creds/.sec_cred.txt"
				echo -e "\nChecking Password......"
				unset gname
				unset gpass
				sleep 2
				echo -e "\n Data Saved" | lolcat
				echo $pass_007 | gpg --batch --yes --passphrase-fd 0 -c ".safepass_saved.config"
				rm ".safepass_saved.config"
				show_menu
			else
				echo -e "\nThe entered password was wrong" | lolcat
				echo -e "\nPlease try again..." | lolcat
				show_menu
			fi
			;;
		4)
			local appname      #custom_app_name variable
			local cuname      #custom_app user name
			local cupass      #custom_app password
			read -p "Enter Appname:" appname
			read -p "Enter Username:" cuname
			read -sp "Enter Password:" cupass
			appname=$( echo $appname | awk '{ print tolower($0) }')
			mkdir -p .safepass/.cred_secured/.custom/.$appname
			echo -e "\n\n\n"
			read -sp "Enter Password To Save:" pass_007
			echo $pass_007 | gpg --batch --yes --passphrase-fd 0 ".safepass_saved.config.gpg" 2>> .safepass_latest_logs.txt
			local filename=".safepass_saved.config"
			if [ -e "$filename" ]
			then
				rm ".safepass_saved.config.gpg"
				echo $cuname > .safepass/.cred_secured/.custom/.$appname/.sec_cred.txt
				echo $cupass >> .safepass/.cred_secured/.custom/.$appname/.sec_cred.txt
				echo $pass_007 | gpg --batch --yes --passphrase-fd 0 -c ".safepass/.cred_secured/.custom/.$appname/.sec_cred.txt"
				echo -e "\nChecking Password......"
				unset cuname
				unset cupass
				sleep 2
				echo -e "\n Data Saved" | lolcat
				echo $pass_007 | gpg --batch --yes --passphrase-fd 0 -c ".safepass_saved.config"
				rm ".safepass_saved.config"
				show_menu
			else
				echo -e "\nThe entered password was wrong" | lolcat
				echo -e "\nPlease try again..." | lolcat
				show_menu
			fi
			;;
		5)
			local loc=".safepass/.cred_secured"
			if [ -d "$loc" ]
			then
				if [ -e "safepass/.cred_secured/.fb_creds/.sec_cred.txt.gpg" ]
				then
					echo -e "\n\e[1;33m[\e[0m\e[1;32m1\e[0m\e[1;33m]\e[0m \e[1;31mFacebook\e[0m"
				fi
				if [ -e ".safepass/.cred_secured/.ig_creds/.sec_cred.txt.gpg" ]
				then
					echo -e "\n\e[1;33m[\e[0m\e[1;32m2\e[0m\e[1;33m]\e[0m \e[1;31mInstagram\e[0m"
				fi
				if [ -e ".safepass/.cred_secured/.go_creds/.sec_cred.txt.gpg" ]
				then
					echo -e "\n\e[1;33m[\e[0m\e[1;32m3\e[0m\e[1;33m]\e[0m \e[1;31mGoogle\e[0m"
				fi
				if [ -e ".safepass/.cred_secured/.custom" ]
				then
					echo -e "\n\e[1;33m[\e[0m\e[1;32m4\e[0m\e[1;33m]\e[0m \e[1;31mCustom Entries\e[0m"
				fi
				echo -e "\n\e[1;33m[\e[0m\e[1;32mX\e[0m\e[1;33m]\e[0m \e[1;31mBack\e[0m"	
			retrieve
			else
				echo -e "\n Invalid Option"
				clear
				welcome_banner
				show_menu
			fi
			;;
		x|exit|X|q|Q|QUIT|quit)	
			exit
			;;
		R|r|RESET|reset)
			if [ -e ".safepass_saved_config.gpg" ]
			then
				rm ".safepass_saved.config.gpg"
				rm -rf .safepass
				rm .safepass_latest_logs.txt
				auth_start
			else
				echo "INVALID OPTION...Please Retry..."
				show_menu
			fi
	esac
}

retrieve()                 #function for retrieving saved entries
{
	read -p "Enter Your Choice:" choice
	local mpass      #referring master_password
	case $choice in
		1)
			read -sp "Enter Master Password:" mpass
			echo $mpass | gpg --batch --yes --passphrase-fd 0 ".safepass/.cred_secured/.fb_creds/.sec_cred.txt.gpg" 2>> .safepass_latest_logs.txt
			rm ".safepass/.cred_secured/.fb_creds/.sec_cred.txt.gpg" 
			echo -e "\e[5m\e[1;31m\nGET YOUR USERNAME AND PASSWORD\e[0m\n\n"
			echo -e "\n---------------------------"
			echo -e "\n\e[5mUsername:::$(head -1 ".safepass/.cred_secured/.fb_cred/.sec_cred.txt" )"
			echo -e "\n\e[5mPassword:::$(tail -1 ".safepass/.cred_secured/.fb_creds/.sec_cred.txt" )"
			echo -e "\n----------------------------"
			echo $mpass | gpg --batch --yes --passphrase-fd 0 -c ".safepass/.cred_secured/.fb_creds/.sec_cred.txt"
			rm ".safepass/.cred_secured/.fb_creds/.sec_cred.txt"
			unset mpass    #deleting mpass variable for preventing loss of data
			show_menu
			;;
		2)
			read -sp "Enter Master Keyring:" mpass
			echo $mpass | gpg --batch --yes --passphrase-fd 0 ".safepass/.cred_secured/.ig_creds/.sec_cred.txt.gpg" 2>> .safepass_latest_logs.txt
			rm ".safepass/.cred_secured/.ig_creds/.sec_cred.txt.gpg"
			echo -e "\e[5m\e[1;31m\nGET YOUR USERNAME AND PASSWORD\e[0m\n\n"
			echo -e "\n----------------------------"
			echo -e "\n\e[5mUsername:::$(head -1 ".safepass/.cred_secured/.ig_creds/.sec_cred.txt" )"
			echo -e "\n\e[5mPassword:::$(tail -1 ".safepass/.cred_secured/.ig_creds/.sec_cred.txt" )"
			echo -e "\n-----------------------------"
			echo $mpass | gpg --batch --yes --passphrase-fd 0 -c ".safepass/.cred_secured/.ig_creds/.sec_cred.txt"
			rm ".safepass/.cred_secured/.ig_creds/.sec_cred.txt"
			unset mpass
			show_menu
			;;
		3)
			read -sp "Enter Master Keyring:" mpass
			echo $mpass | gpg --batch --yes --passphrase-fd 0 ".safepass/.cred_secured/.go_creds/.sec_cred.txt.gpg" 2>> .safepass_latest_logs.txt
			rm ".safepass/.cred_secured/.go_creds/.sec_cred.txt.gpg"
			echo -e "\e[5m\e[1;31m\nGET YOUR USERNAME AND PASSWORD\e[0m\n"
			echo -e "\n-----------------------------"
			echo -e "\n\e[5mUsername:::$(head -1 ".safepass/.cred_secured/.go_creds/.sec_cred.txt" )"
			echo -e "\n\e[5mPassword:::$(tail -1 ".safepass/.cred_secured/.go_creds/.sec_cred.txt" )"
			echo -e "\n------------------------------"
			echo $mpass | gpg --batch --yes --passphrase-fd 0 -c ".safepass/.cred_secured/.go_creds/.sec_cred.txt"
			rm ".safepass/.cred_secured/.go_creds/.sec_cred.txt"
			show_menu
			;;
		4)
			read -sp "Enter Master Keyring:" mpass
			echo "\n"
			read -p "Enter Appname:" app
			app=$(echo "$app" | awk '{print tolower($0)}')
			echo $mpass | gpg --batch --yes --passphrase-fd 0 ".safepass/.cred_secured/.custom/.$app/.sec_cred.txt.gpg" 2>> .safepass_latest_logs.txt
			rm ".safepass/.cred_secured/.custom/.$app/.sec_cred.txt.gpg" 2>> .safepass_latest_logs.txt
			echo -e "\e[5m\e[1;31m\nGET YOUR USERNAME AND PASSWORD\e[0m\n\n"
			echo -e "\n------------------------------"
			echo -e "\n\e[5mUsername:::$(head -1 ".safepass/.cred_secured/.custom/.$app/.sec_cred.txt" )" 2>> .safepass_latest_logs.txt  
			echo -e "\n\e[5mPassword:::$(tail -1 ".safepass/.cred_secured/.custom/.$app/.sec_cred.txt" )" 2>> .safepass_latest_logs.txt
			echo -e  "\n-----------------------------"
			echo $mpass | gpg --batch --yes --passphrase-fd 0 -c ".safepass/.cred_secured/.custom/.$app/.sec_cred.txt" 2>> .safepass_latest_logs.txt
			rm ".safepass/.cred_secured/.custom/.$app/.sec_cred.txt" 2>> .safepass_latest_logs.txt
			show_menu
			;;
		x|X|BACK|back)
			show_menu
			;;
		reset|R|RESET|r)
			if [ -e ".safepass_saved_config.gpg" ]
			then
				rm ".safepass_saved.config.gpg"
				rm -rf .safepass
				rm .safepass_latest_logs.txt
				auth_start
			else
				echo "INVALID OPTION...Please Retry..."
				show_menu
			fi
		esac
}

bye()      #function for executing at EXIT signal
{
	echo "Exiting......." | lolcat
	sleep 2
	figlet "BYE..." | lolcat
}

ctrl_c()    #function for executing when (CTRL+C) detects
{
	echo -e  "\n(CTRL+C) Detected!!Deleting Unencrypted Files....." | lolcat
	local fb=".safepass/.cred_secured/.fb_creds/.sec_cred.txt"
	local ig=".safepass/.cred_secured/.ig_creds/.sec_cred.txt"
	local go=".safepass/.cred_secured/.ig_creds/.sec_cred.txt"
	if [ -e "$fb" ]
	then
		rm "$fb"
	fi
	if [ -e "$ig" ]
	then
		rm "$ig"
	fi
	if [ -e "$go" ]
	then
		rm "$go"
	fi
	echo -e  "\nExiting......." | lolcat
	sleep 2
	exit
}
trap ctrl_c SIGINT      #catching interruption signal
requirements_banner	#printing startup confirmation scene
welcome_banner         #printing welcome banner
auth_start            #authentication menu
trap bye EXIT              #catching EXIT signal\
