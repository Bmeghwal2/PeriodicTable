#!/bin/bash
#read $1
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
if [[ -z $1 ]]
then
echo Please provide an element as an argument.
else
if [[ $1 =~ ^[0-9]+$ ]]
then
ATOMIC_NUMBER=$1
else
ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol='$1' or name='$1'")
fi
if [[ -z $ATOMIC_NUMBER ]]
then 
echo "I could not find that element in the database."
else 
READ_ALL_DATA=$($PSQL "select name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type, atomic_number from elements full join properties using(atomic_number) full join types using(type_id) where atomic_number=$ATOMIC_NUMBER")
echo $READ_ALL_DATA | while IFS=" | " read NAME SYMBOL ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE ATOMIC_NUMBER
do
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done
fi
fi