#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
exit 0
fi
# atomic_number = AN

ERROR() {
    if  [[ -z $AN ]] || [[ -z $SYMBOL ]] || [[ -z $NAME ]] 
    then
	echo "I could not find that element in the database."
	exit 0
    fi
}

#check if number
if [[ ! $1 =~ ^[0-9]+$ ]]
then
    # count symbols
    COUNT=$(echo -n "$1" | wc -c)
    if [ $COUNT -lt 3 ]
    then
        SYMBOL=$1
        AN=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
        NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
	ERROR
	else
        if [ $COUNT -gt 2 ]
        then
            NAME=$1
            AN=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
            SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
	    ERROR
	fi
    fi
else
    AN=$1
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
    ERROR
fi

# get data variables
TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number = $AN")

MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number = $AN")

MELT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number = $AN")

BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number = $AN")

# edit spaces
AN_S=$(echo $AN | sed -r 's/^ *| *$//g')
NAME_S=$(echo $NAME | sed -r 's/^ *| *$//g')
SYMBOL_S=$(echo $SYMBOL | sed -r 's/^ *| *$//g')
TYPE_S=$(echo $TYPE | sed -r 's/^ *| *$//g')
MASS_S=$(echo $MASS | sed -r 's/^ *| *$//g')
MELT_S=$(echo $MELT | sed -r 's/^ *| *$//g')
BOIL_S=$(echo $BOIL | sed -r 's/^ *| *$//g')

echo -e "The element with atomic number $AN_S is $NAME_S ($SYMBOL_S). It's a $TYPE_S, with a mass of $MASS_S amu. $NAME_S has a melting point of $MELT_S celsius and a boiling point of $BOIL_S celsius."
