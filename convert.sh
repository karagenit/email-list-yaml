#!/bin/bash

infile=$1
outfile=$2

count=0
limit=20
total=`wc -l < $infile`

# UI
function update-progress {

	echo -ne "Processing... $(((count * 100 ) / total))%\r"
}



# Setup File
echo ""
echo "members: " > $outfile

# For each line
while read line
do
	# Parse data
	
	# IF like * (*);
	 name=`echo $line | sed -E "s/([A-Za-z ]{1,})[(]([A-Za-z0-9!@#$%^&.]{1,})[)][;]/\\1/"` 
	email=`echo $line | sed -E "s/([A-Za-z ]{1,})[(]([A-Za-z0-9!@#$%^&.]{1,})[)][;]/\\2/"`
	fname=`echo $name | sed -E "s/([A-Za-z]{1,})[ ]([A-Za-z]{0,})/\\1/"`
	lname=`echo $name | sed -E "s/([A-Za-z]{1,})[ ]([A-Za-z]{0,})/\\2/"`

	# ELIF like *;
		
	email=`echo $email | sed -E "s/([A-Za-z0-9!@#$%^&.]{1,})[;]/\\1/"`
	fname=`echo $fname | sed -E "s/([A-Za-z0-9!@#$%^&.]{1,})[;]//"`
	lname=`echo $lname | sed -E "s/([A-Za-z0-9!@#$%^&.]{1,})[;]//"`

	# Write data
	echo "   - member: " >> $outfile
	echo "      first: \"${fname}\"" >> $outfile
	echo "      last:  \"${lname}\"" >> $outfile
	echo "      email: \"${email}\"" >> $outfile

	((count++))
	update-progress

done < $infile

echo ""
