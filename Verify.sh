#!/bin/bash

#######################################################################################
# Author : Anurag Deb @ Aricent
#   	   Pratosh Kumar @ Aricent
# Description : This scripts extracts, formats and comapares 62 and 71 extracted data of VN.
#				This also gives you a detailed report about the differences.
######################################################################################

Forg_set_colors()
{
     NORMAL="\033[0m"
     RED="\033[31m"
     GREEN="\033[32m"
     BROWN="\033[33m"
     YELLOW="\033[33;1m"
     BLUE="\033[34m"
     MAGENTA="\033[35m"
     PINK="\033[35;1m"
     CYAN="\033[36m"
     WHITE="\033[37m"
     BOLD="\033[1m"
     UNDERLINE='\033[4m'
}

Initialize()
{
dos2unix $1
}


#setting colors
Forg_set_colors
# This will clear the screen before displaying the menu.
clear
Initialize list_tables
Initialize sql_common.cmd
Initialize *.pl
Initialize *.sh

printf "*********************************************************\n\n"   | tee -a verify_vn.log
printf $YELLOW
printf "Extracting Data from ECNVN***************\n"    | tee -a verify_vn.log
printf $BROWN
perl extract.pl $1 >> verify_vn.log

printf $YELLOW
printf "Extracting DONE***************\n"    | tee -a verify_vn.log
printf "*********************************************************\n\n"   | tee -a verify_vn.log
printf $YELLOW 
echo "Formatting 71 Data" | tee -a verify_vn.log
python format_71_data.py  | tee -a verify_vn.log
printf $BLUE
printf "**************Removing temporary files********************\n"   | tee -a verify_vn.log
printf $CYAN
printf "***************\n"
printf "***************Checking Data for Difference***************\n"   | tee -a verify_vn.log
sh difference.sh      >>  verify_vn.log
printf $CYAN 
printf "*********************************************************\n\n"  | tee -a verify_vn.log
printf $YELLOW
printf "                Final Report for VN\n\n" | tee -a verify_vn.log


cd Difference
ls sqlload_*.txt_modified_diff* > tables
Initialize tables

while read filename
do
  var1=$(sed 's/.\{18\}$//' <<< "$filename")
  var2=$(sed 's/^.\{7\}.//' <<< "$var1")
  
  number=$(cat "$filename" | wc -l) 
  echo $var2 " " $number >> report.txt

done <tables	

rm tables

ls  new_sqlload_* > tables2
Initialize tables2

while read newfile
do
  var1=$(sed 's/.\{4\}$//' <<< "$newfile")
  var2=$(sed 's/^.\{11\}.//' <<< "$var1")
  
  number=$(cat "$newfile" | wc -l) 
  echo $var2 " " $number >> report1.txt

done <tables2	


printf $CYAN 
printf "\n##################################################\n\n"
printf $YELLOW
printf "Differences in File"
printf $GREEN
printf "\n##################################################\n\n"
if [ -f "report.txt" ];
then
	printf $YELLOW
	awk '{printf "# %-30s:  %-18s\n",$1,$2}'  report.txt | tee -a ../verify_vn.log
else
	printf $GREEN
	printf "\nNo Difference in common data\n\n"
fi
printf $CYAN
printf "##################################################\n\n"
printf $YELLOW
printf "New Data"   
printf $CYAN
printf "\n##################################################\n\n"
if [ -f "report1.txt" ];
then
	printf $YELLOW
	awk '{printf "# %-30s:  %-18s\n",$1,$2}'  report1.txt | tee -a ../verify_vn.log
else
	printf $GREEN
	printf "No New Data"
fi	
printf "\n##################################################\n\n"

printf $NORMAL

rm report*.txt 2>/dev/null >>  ../verify_vn.log
cd ..
rm 1*.* 2>/dev/null          >> verify_vn.log
rm *.txt 2>/dev/null         >> verify_vn.log




  
