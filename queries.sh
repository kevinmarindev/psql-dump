#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "select Sum(winner_goals) + Sum(opponent_goals) from games;")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "select avg(winner_goals) from games;")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "select ROUND(avg(winner_goals), 2) from games;")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "select ROUND(avg(winner_goals) + avg(opponent_goals), 16) from games;")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "select MAX( Greatest(winner_goals, opponent_goals)) from games;")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "select COUNT(*) from games WHERE winner_goals > 2;")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT teams.name FROM games INNER JOIN teams ON games.winner_id = teams.team_id WHERE games.round = 'Final' AND games.year = 2018;")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "select name from teams INNER JOIN games on teams.team_id = games.winner_id WHERE round = 'Eighth-Final' AND year = 2014 UNION select name from teams INNER JOIN games on teams.team_id = games.opponent_id WHERE round = 'Eighth-Final' AND year = 2014;")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT name from teams INNER JOIN games on teams.team_id = games.winner_id ORDER BY name ASC;")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "select games.year, teams.name from teams INNER JOIN games on teams.team_id = games.winner_id WHERE round= 'Final' ORDER BY year ASC;")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name from teams WHERE name LIKE 'Co%';")"
