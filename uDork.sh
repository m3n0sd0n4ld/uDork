#!/bin/bash

##################################################################################################
# 									COOKIES CONFIGURATION										 #
##################################################################################################
# ATENTION!!! Add your cookies as follows:
# cookies="c_user=xxxxxxxxxxxxxxx; xs=xxxxxxxxxxxxxxxxxx;"
# Instructions: https://c43s4rs.blogspot.com/2020/03/udork-tu-herramienta-para-google-dorks.html
cookies="c_user=HEREYOUCOOKIE; xs=HEREYOUCOOKIE;" 
##################################################################################################

# Variables
url=$1
action=$2
flag=$3
report=$4
fileReport="$5"
page=$6
numPage=$7
tiempo="2s"
maximo_lineas=700

# Colors
cRojo=`tput setaf 1`
cVerde=`tput setaf 2`
cAmarillo=`tput setaf 3`

# Effects
cBold=`tput bold`
cNormal=`tput sgr0` #No color, No bold

# Dorks
d_filetype="dorks/filetype.txt"
d_intext="dorks/intext.txt"
d_inurl="dorks/inurl.txt"
d_intitle="dorks/intitle.txt"
d_global="dorks/global.txt"
d_admin="dorks/admin.txt"
d_directories="dorks/directories.txt"
d_usernames="dorks/usernames.txt"
d_passwords="dorks/passwords.txt"
d_webservers="dorks/webservers.txt"
d_vulnerable_files="dorks/vulnerable_files.txt"
d_vulnerable_servers="dorks/vulnerable_servers.txt"
d_error_messages="dorks/error_messages.txt"
d_vulnerable_networks="dorks/vulnerable_networks.txt"
d_portal_logins="dorks/portal_logins.txt"
d_devices="dorks/devices.txt"

# Functions
# Startup logo
banner_uDork(){
	echo """                                                                
       _____             _    
      |  __ \           | |   
 _   _| |  | | ___  _ __| | __
| | | | |  | |/ _ \| '__| |/ /
| |_| | |__| | (_) | |  |   < 
 \__,_|_____/ \___/|_|  |_|\_\ ${cBold}v.2.0
	${cBold}by ${cRojo}M3n0sD0n4ld${cNormal} - (${cBold}${cAmarillo}@David_Uton${cNormal})
"""
separador
}
# Menu
menu(){
echo " ./uDork.sh <Domain/IP> [option] <string> / all"
echo ""
echo '======================== OPCIONES ========================
 -e <extension> / <all> : Search files by extension. Use 'all' to find the list extension.
 -s <text> / <all> : Find text in website content.
 -u <string> / <all> : Locate text strings within the URL.
 -t <string> / <all> : Lists text string in site title.
 -g <dork_name> : Attack a site with a predefined list of dorks. Review list <-l>. 
 -l : Shows the list of predefined dorks (Exploit-DB).
 -f <custom_list> : Use your own personalized list of dorks.
 -p <number> : Number of pages to search in Google. (By default 1 pages).
 -o <name_file> : Export results to a file.

======================== EXAMPLES ========================
 ./uDork.sh host.com -e pdf -p 3 (Search for .pdf files on the indicated website)
 ./uDork.sh host.com -e all (Search files by all extensions)
 ./uDork.sh host.com -t "Twitter David" (Find errors by the indicated chain)
 ./uDork.sh host.com -u all (Find the most used chains)
 ./uDork.sh host.com -g admin (Lists administration panels)

 -h : Show this help.
'
}
# List of predefined dorks
listado_dorks(){
	echo "======================== DORKS LISTING ========================"
	echo " admin : Access panels of all kinds (administration, login, CMS, ...)
 directories : Sensitive directories (drupal, wordpress, phpmyadmin ...)
 usernames : Find files containing user names.
 passwords : Find files that contain passwords.
 webservers: Find web servers.
 vulnerable_files : Find vulnerable files. 
 vulnerable_servers : Find vulnerable servers.
 error_messages : Show error messages.
 vulnerable_networks : Find software data on vulnerable networks.
 portal_logins : List portal logins.
 devices :  Find connected devices (printers, webcams, thermostats, ...)"
	echo ""
	echo "======================== EXAMPLES ========================"
	echo " ./uDork.sh host.com -g admin"
	echo " ./uDork.sh host.com -g portal_logins"
}
# Displays tool information in case of error
banner_error(){
	echo "Error, missing parameters to be passed." 
	echo "Type ./uDork.sh -h for more information."
}
# Massive message
msgMassive(){
   	echo "${cBold}${cRojo}[!]${cNormal} The results will appear below. This may take several minutes, please wait ..."
	echo ""
}
# Checking pages
checkPages(){
	if [[ $report == "-p" ]] || [[ $page == "-p" ]]; then
		checkNum='?(-)+([0-9])'
		if [[ $fileReport == $checkNum ]];then 
			pages=${fileReport}
		elif [[ $numPage == $checkNum ]];then
			pages=${numPage}
		else
			pages="0"
		fi
	else
		pages="0"
	fi
}
# Search
search(){
	flagEnc=$(echo "$flag" | sed 's/ /%2520/')
	# Associate rate per share
	if [[ $action == "-e" ]]; then
		type="filetype"
	elif [[ $action == "-s" ]]; then
		type="intext"
	elif [[ $action == "-u" ]]; then
		type="inurl"
	elif [[ $action == "-t" ]] || [[ $action == "-f" ]]; then
		type="intitle"
	elif [[ $action == "-g" ]]; then
		if [[ $withDork == "1" ]]; then
			type="intitle"
		else
			type="inurl"
		fi
	fi
	# Execution
	if [[ $type == "intext" ]]; then
		resultado=$(curl -s --cookie "$cookies" https://developers.facebook.com/tools/debug/echo/?q=https://www.google.com/search?q=${type}%3A${flagEnc}%2520${url}%26start%3D${i}0 |grep 'url?q=' | cut -d ' ' -f3 | cut -d "=" -f3 | sed 's/\(&am\).*//' | sed '/&gt/d' | sed '/like,/d' | sed '/xpd/d' | sed '/^ *$/d' | sed '/s3v9rd/d')
	elif [[ $type == "intitle" ]]; then
		if [[ $withDork == "1" ]]; then
			resultado=$(curl -s --cookie "$cookies" https://developers.facebook.com/tools/debug/echo/?q=https://www.google.com/search?q=site%3A${url}%2520"${flagEnc}"%26start%3D${i}0 |grep 'url?q=' | cut -d ' ' -f3 | cut -d "=" -f3 | sed 's/\(&am\).*//' | sed '/&gt/d' | sed '/like,/d' | sed '/xpd/d' | sed '/^ *$/d' | sed '/s3v9rd/d')
		else
			resultado=$(curl -s --cookie "$cookies" https://developers.facebook.com/tools/debug/echo/?q=https://www.google.com/search?q=site%3A${url}%2520${type}%3A"${flagEnc}"%26start%3D${i}0 |grep 'url?q=' | cut -d ' ' -f3 | cut -d "=" -f3 | sed 's/\(&am\).*//' | sed '/&gt/d' | sed '/like,/d' | sed '/xpd/d' | sed '/^ *$/d' | sed '/s3v9rd/d')
		fi
	else
		resultado=$(curl -s --cookie "$cookies" https://developers.facebook.com/tools/debug/echo/?q=https://www.google.com/search?q=site%3A${url}%2520${type}%3A${flagEnc}%26start%3D${i}0 |grep 'url?q=' | cut -d ' ' -f3 | cut -d "=" -f3 | sed 's/\(&am\).*//' | sed '/&gt/d' | sed '/like,/d' | sed '/xpd/d' | sed '/^ *$/d' | sed '/s3v9rd/d')
	fi
}
# URL Encoder/Decoder
urlencode() {
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C
    
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
    
    LC_COLLATE=$old_lc_collate
}
urldecode(){
	decoded_url=$(perl -MURI::Escape -e 'print uri_unescape($ARGV[0])' "$resultado")
	echo "$decoded_url"
}
# Shows the result
banner_resultado(){
	if [[ $resultado > 0 ]]; then
		if [[ $i == "0" ]] || [[ $flag == "all" ]]; then
			if [[ $report == "-o" ]]; then
				banner_inicio | tee -a "$fileReport"
				separador | tee -a "$fileReport"
			elif [[ $page == "-o" ]]; then
				banner_inicio | tee -a $numPage
				separador | tee -a $numPage
			else
				banner_inicio
				separador
			fi
		fi
		if [[ $report == "-o" ]]; then 
			urldecode $resultado | tee -a "$fileReport"
			contador
		elif [[ $page == "-o" ]]; then
			urldecode $resultado | tee -a "$numPage"
			contador
		else
			urldecode $resultado
			contador
		fi
	fi
}
banner_inicio(){
	echo "Domain/IP: ${cBold}$url${cNormal}"
	echo "Find links with: ${cBold}$flag${cNormal}"
}
banner_final(){
	separador
	echo "Files ${cRojo}$flag${cNormal} found: ${cBold}${cRojo}$numTotal${cNormal}"
	echo ""
}
contador(){
	total=$(echo "$resultado" | wc -l)
	numTotal=$((numTotal+$total))
}
# Line spacer
separador(){
	echo "----------------------------------------------------------------------"
}
# Maximum line count dorks list
max_lineas(){
	lineas=$(wc -l ${listDorks} | cut -d " " -f 1)
	return $lineas
}
# Massive mode
massiveMode(){
	max_lineas ${listDorks}
	if [[ $lineas -gt $maximo_lineas ]]; then
		echo "The file: ${listDorks} must contain less than $maximo_lineas lines."
	else
		msgMassive
		while IFS= read -r flag
		do
			checkPages
			for ((i=0;i<=$pages;i++)); do
				search
				banner_resultado
			done
			# Report
			finalReport
			total="0"
			numTotal="0"
			# Stopping between requests
			sleep $tiempo
		done < ${listDorks}
	fi
}
# Final report
finalReport(){
	if [[ $total -ne "0" ]]; then
		if [[ $report == "-o" ]]; then
			banner_final | tee -a "$fileReport"
		elif [[ $page == "-o" ]]; then
			banner_final | tee -a $numPage
		else
			banner_final
		fi
	fi
}
# Cookies Status
cookiesStatus(){
	if [[ -z "$cookies" ]]; then
		echo "You need to set your Facebook cookies for uDork to work. Edit uDork.sh and set your cookies."
		exit
	fi
}
# Listing
lista(){
	case $flag in
		directorios )
			max_lineas $d_directorios
			;;
		usernames )
			max_lineas $d_usernames
			;;
		passwords )
			max_lineas $d_passwords
			;;
		webservers )
			max_lineas $d_webservers
			;;
		vulnerable_files )
			max_lineas $d_vulnerable_files
			;;
		vulnerable_servers )
			max_lineas $d_vulnerable_servers
			;;
		error_messages )
			max_lineas $d_error_messages
			;;
		vulnerable_networks )
			max_lineas $d_vulnerable_networks
			;;
		portal_logins )
			max_lineas $d_portal_logins
			;;
		devices )
			max_lineas $d_devices
			;;
	esac
}

# Testing cookies
cookiesStatus

if [[ -n "$url" ]] || [[ -n "$action" ]] && [[ -n "$flag" ]]; then
	banner_uDork
	# Google Dorks basics
	if [[ "$action" == "-e" ]] || [[ "$action" == "-s" ]] || [[ "$action" == "-u" ]] || [[ "$action" == "-t" ]]; then
		# Arguments with listings
		if [[ "$flag" == "all" ]]; then
			if [[ $action == "-e" ]]; then
				listDorks="$d_filetype"
			elif [[ $action == "-s" ]]; then
				listDorks="$d_intext"
			elif [[ $action == "-u" ]]; then
				listDorks="$d_inurl"
			elif [[ $action == "-t" ]]; then
				listDorks="$d_intitle"
				withDork="1"
			else
				banner_error
				exit
			fi
			# Massive
			massiveMode
		else
			checkPages
			for ((i=0;i<=$pages;i++)); do
				search
				banner_resultado
			done
			
			# Report
			finalReport
		fi
	# Google Dorks - Exploit-DB
	elif [[ "$action" == "-g" ]]; then
		if [[ "$flag" == "admin" ]]; then
			listDorks="$d_admin"
		elif [[ "$flag" == "directories" ]]; then
			listDorks="$d_directories"
			withDork="1"
		elif [[ "$flag" == "usernames" ]]; then
			listDorks="$d_usernames"
			withDork="1"
		elif [[ "$flag" == "passwords" ]]; then
			listDorks="$d_passwords"
			withDork="1"
		elif [[ "$flag" == "webservers" ]]; then
			listDorks="$d_webservers"
			withDork="1"
		elif [[ "$flag" == "vulnerable_files" ]]; then
			listDorks="$d_vulnerable_files"
			withDork="1"
		elif [[ "$flag" == "vulnerable_servers" ]]; then
			listDorks="$d_vulnerable_servers"
			withDork="1"
		elif [[ "$flag" == "error_messages" ]]; then
			listDorks="$d_error_messages"
			withDork="1"
		elif [[ "$flag" == "vulnerable_networks" ]]; then
			listDorks="$d_vulnerable_networks"
			withDork="1"
		elif [[ "$flag" == "portal_logins" ]]; then
			listDorks="$d_portal_logins"
			withDork="1"
		elif [[ "$flag" == "devices" ]]; then
			listDorks="$d_devices"
			withDork="1"
		else
			banner_error
			exit
		fi
		# Massive
		massiveMode	
	# Google Dorks - Custom
	elif [[ "$action" == "-f" ]]; then
		if [[ -f $3 ]]; then
			listDorks="$3"
			withDork="1"
		else
			echo "The file does not exist: ${cBold}$3${cNormal}"
			exit
		fi
		# Massive
		massiveMode
	# Error when typing command or flags
	else
		banner_error
		exit
	fi		
# Displays the menu with the options
elif [[ $1 == "-h" ]]; then
	banner_uDork
	menu
# Google Dorks - List of predefined dorks
elif [[ $1 == "-l" ]]; then
	banner_uDork
	listado_dorks
else
	banner_uDork
	banner_error
fi
