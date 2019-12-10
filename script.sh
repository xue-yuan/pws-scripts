#! /bin/bash

clear
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m'

echo -e "${GREEN}"
echo "   _____ _____ ____     _____             __ _       "
echo "  / ____|_   _|  _ \   / ____|           / _(_)      "
echo " | (___   | | | |_) | | |     ___  _ __ | |_ _  __ _ "
echo "  \___ \  | | |  _ <  | |    / _ \| '_ \|  _| |/ _  |"
echo "  ____) |_| |_| |_) | | |___| (_) | | | | | | | (_| |"
echo " |_____/|_____|____/   \_____\___/|_| |_|_| |_|\__, |"
echo "                                                __/ |"
echo "                                               |___/"
echo -e "${NC}"

echo "[#] System Information Block Setting API"

while true
do
    echo -e "${PURPLE}[!] Killing Process...\n${NC}"

    sudo pkill srsepc
    sudo pkill srsenb
    
    echo "------------------------------------"
    printf  "${YELLOW}[?] which type of SIB would like to use? (10/11/12/[Q]uit): ${NC}"
    read sib_type

    if [ $sib_type == "q" ] || [ $sib_type == "Q" ]; then
        echo -e "${PURPLE}[!] Quit.\n${NC}"
        break

    elif [ $sib_type != "10" ] && [ $sib_type != "11" ] && [ $sib_type != "12" ]; then
        echo -e "${RED}[X] Please Select Correct Type of SIB.\n${NC}"
        continue
    fi

    echo -e "[!] Switch to ${CYAN}SIB[$sib_type]${NC}.\n"
    sudo sed -i "s/si_mapping_info = \[..\]/si_mapping_info = [$sib_type]/g" /etc/srslte/sib.conf


    if [ $sib_type == "10" ]; then
        echo -e "${GREEN}[*] Running Program...${NC}"
        sudo srsepc &
        sudo srsenb
        echo -e "${GREEN}[!] End of Program.\n${NC}"
    
    elif [ $sib_type == "11" ]; then
        printf "${YELLOW}[?] Type the Message which you would like to alert: ${NC}"
        IFS="" read -r message

        echo -e "[*] Execute JavaScript...\n"
        node parser.js $message

        echo -e "${GREEN}[*] Running Program...${NC}"
        sudo srsepc &
        sudo srsenb
        echo -e "${GREEN}[!] End of Program.\n${NC}"

    elif [ $sib_type == "12" ]; then
        printf "${YELLOW}[?] Type the Message which you would like to alert: ${NC}"
        IFS="" read -r message
        
        echo -e "[*] Execute JavaScript...\n"
        node parser.js $message

        echo -e "${GREEN}[*] Running Program...${NC}"
        sudo srsepc &
        sudo srsenb
        echo -e "${GREEN}[!] End of Program.\n${NC}"
    fi
done

echo -e "${GREEN}[!] Exiting the API...${NC}\n"
