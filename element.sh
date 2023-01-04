#!/bin/bash
#read $1
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
echo Please provide an element as an argument.
else
if [[ $1 =~ ^[0-9]+$ ]]
then
INPUT=$1
else
INPUT=$($PSQL "select atomic_number from elements where symbol='$1' or name='$1'")
fi
READ_ALL_DATA=$($PSQL "select name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type, atomic_number from elements full join properties using(atomic_number) full join types using(type_id) where atomic_number='$INPUT'")
echo $READ_ALL_DATA | while IFS=" | " read NAME SYMBOL ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE ATOMIC_NUMBER
do
if [[ -z $READ_ALL_DATA ]]
then
echo "I could not find that element in the database."
else
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
done
fi
