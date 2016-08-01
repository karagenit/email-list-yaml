#!/bin/bash

infile=$1
outfile=$2

count=0
total=`wc -l < $infile`

# Setup File
echo "members: " > $outfile

# For each line
while read line
do
	# Parse data
	
	# For those like * (*);
	 name=`echo $line | sed -E "s/([A-Za-z. ]{1,})[(]([A-Za-z0-9!@#$%^&-_.]{1,})[)][;]/\\1/"` 
	email=`echo $line | sed -E "s/([A-Za-z. ]{1,})[(]([A-Za-z0-9!@#$%^&-_.]{1,})[)][;]/\\2/"`
	fname=`echo $name | sed -E "s/([A-Za-z.]{1,})[ ]([A-Za-z]{0,})/\\1/"`
	lname=`echo $name | sed -E "s/([A-Za-z.]{1,})[ ]([A-Za-z]{0,})/\\2/"`

	# For those like *;
	email=`echo $email | sed -E "s/([A-Za-z0-9!@#$%^&.-_]{1,})[;]/\\1/"`
	fname=`echo $fname | sed -E "s/([A-Za-z0-9!@#$%^&.-_]{1,})[;]//"`
	lname=`echo $lname | sed -E "s/([A-Za-z0-9!@#$%^&.-_]{1,})[;]//"`

	# Write data
	echo "   - member: " >> $outfile
	echo "      first: \"${fname}\"" >> $outfile
	echo "      last:  \"${lname}\"" >> $outfile
	echo "      email: \"${email}\"" >> $outfile

	# Update UI
	((count++))
	echo -ne "Processing... $(((count * 100 ) / total))%\r"

done < $infile
