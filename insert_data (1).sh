#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

$PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY CASCADE;"

# Read through each line in the CSV file
cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
  if [[ $year != "year" ]]; then
    # Insert teams
    $PSQL "INSERT INTO teams(name) VALUES('$winner') ON CONFLICT (name) DO NOTHING;"
    $PSQL "INSERT INTO teams(name) VALUES('$opponent') ON CONFLICT (name) DO NOTHING;"

    # Insert game data
    $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals)
           VALUES ($year, '$round',
           (SELECT team_id FROM teams WHERE name = '$winner'),
           (SELECT team_id FROM teams WHERE name = '$opponent'),
           $winner_goals, $opponent_goals);"
  fi
done
