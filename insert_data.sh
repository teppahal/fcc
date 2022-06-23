#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE teams, games RESTART IDENTITY")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
	# insert to names
	if [[ $WINNER != "winner" ]]
	then
	       	# get winner's name id
	  	TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
       		# if not found
       		if [[ -z $TEAM_ID ]]
        	then
            		# insert winner name
            		INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
            		if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
	    		then
		  		echo Inserted into name, $WINNER
            		fi
        	fi  
  	fi

	if [[ $OPPONENT != "opponent" ]]
 	then
      		# get opponent's name id
      		TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        	# if not found
        	if [[ -z $TEAM_ID ]]
        	then
            		# insert opponent name
            		INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
            		if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
            		then
                  		echo Inserted into name, $OPPONENT
            		fi
        	fi
  	fi
done

# insert to games
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
	# get winner and opponent id from teams table
	if [[ $WINNER != "winner" ]]
	then
       		WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
       		OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
		# get game id
		GAME_ID=$($PSQL "SELECT game_id FROM games 
				 WHERE winner_id=$WINNER_ID 
				 AND opponent_id=$OPPONENT_ID
				 AND round='$ROUND'")
		# if not found
		if [[ -z $GAME_ID ]]
		then
			INSERT_GAME=$($PSQL "INSERT INTO 
		 	    games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
		            VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, 
			   $WINNER_GOALS, $OPPONENT_GOALS)")
            		if [[ $INSERT_GAME == "INSERT 0 1" ]]
            		then
                  		echo Inserted into games, $YEAR - $ROUND, $WINNER - $OPPONENT, $WINNER_GOALS:$OPPONENT_GOALS  
            		fi
				   
		fi
	fi

done
