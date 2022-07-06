#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guessing --tuples-only -c"

NTG=$(( $RANDOM % 1000 + 1 ))  # NTG = number to guess
#echo $NTG

echo "Enter your username:"
read USERNAME

USERNAME_S=$(echo $USERNAME | sed -r 's/^ *| *$//g') # VAR_S - spaces removed

#if user not exists
USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")
if [[ -z $USER_ID ]]
then
	ADD_USER=$($PSQL "INSERT INTO users(name) VALUES ('$USERNAME')")
	echo "Welcome, $USERNAME_S! It looks like this is your first time here."
	USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")
else
	GAMES_PLAYED=$($PSQL "SELECT COUNT(user_id) FROM games INNER JOIN users USING(user_id) WHERE user_id = $USER_ID") 
	BEST_GAME=$($PSQL "SELECT MIN(score) FROM games INNER JOIN users USING(user_id) WHERE user_id = $USER_ID") 
	GAMES_PLAYED_S=$(echo $GAMES_PLAYED | sed -r 's/^ *| *$//g') 
	BEST_GAME_S=$(echo $BEST_GAME | sed -r 's/^ *| *$//g') 
	echo "Welcome back, $USERNAME_S! You have played $GAMES_PLAYED_S games, and your best game took $BEST_GAME_S guesses." 
fi

C=0 # variable to count guesses


echo "Guess the secret number between 1 and 1000:"

GUESS() {
	C=$((C+=1))    # +1 to count
	read GN 	# GN=guess number
	while [[ ! $GN =~ ^[0-9]+$ ]]
	do
		echo "That is not an integer, guess again:"
		read GN
	done

	if [[ $GN -lt $NTG ]]
	then
		echo "It's lower than that, guess again:"
		GUESS
	elif [[ $GN -gt $NTG ]]
	then
		echo "It's higher than that, guess again:"
		GUESS
	fi

}

GUESS

# insert score to games table
SCORE=$($PSQL "INSERT INTO games(score, user_id) VALUES ($C, $USER_ID)")

C_S=$(echo $C | sed -r 's/^ *| *$//g') 
NTG_S=$(echo $NTG | sed -r 's/^ *| *$//g') 

echo "You guessed it in $C_S tries. The secret number was $NTG_S. Nice job!"
