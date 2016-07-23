# Email List to YAML Conversion Script

I have a list of emails which is very large and needs parsing. 

I've decided I'm going to put the contents into a YAML file.

## Usage

```Bash
convert.sh [ INPUT FILE ] [ OUTPUT FILE ]
```

It will **not** write to the input file. 

## Input Syntax

```
email@site;
First Last (email@site);
First (email@site);
```

That is all of the possible inputs to my knowledge. 

