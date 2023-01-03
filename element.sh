#!/bin/bash
#read $1
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"
if [[ -z $1 ]]
then
echo Please provide an element as an argument.
#if input is a number
RE='^[0-9]+$'
elif [[ $1 =~ $RE ]]
then
#get atomic name
GET_ATOMIC_NAME=$($PSQL "select name from elements where atomic_number=$1")
echo $GET_ATOMIC_NAME
#string check
STR='^[a-zA-Z]*$'
elif [[ $1 =~ $STR ]]
then
#get symbol
GET_SYMBOL=$($PSQL "select name from elements where symbol like '$1'")
echo $GET_SYMBOL
else
echo nothing is working.
fi