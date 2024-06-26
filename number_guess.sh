#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER_INFO=$($PSQL "SELECT user_id, username, games_played, best_game FROM users WHERE username='$USERNAME'")

if [[ -z $USER_INFO ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
else
  echo $USER_INFO | while IFS="|" read USER_ID USERNAME GAMES_PLAYED BEST_GAME
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0

echo "Guess the secret number between 1 and 1000:"

while true
do
  read GUESS
  if ! [[ $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  else
    ((NUMBER_OF_GUESSES++))
    if [[ $GUESS -lt $SECRET_NUMBER ]]
    then
      echo "It's higher than that, guess again:"
    elif [[ $GUESS -gt $SECRET_NUMBER ]]
    then
      echo "It's lower than that, guess again:"
    else
      echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      if [[ -z $USER_INFO ]]
      then
        UPDATE_USER_RESULT=$($PSQL "UPDATE users SET games_played = 1, best_game = $NUMBER_OF_GUESSES WHERE username='$USERNAME'")
      else
        echo $USER_INFO | while IFS="|" read USER_ID USERNAME GAMES_PLAYED BEST_GAME
        do
          NEW_GAMES_PLAYED=$(( GAMES_PLAYED + 1 ))
          if [[ -z $BEST_GAME || $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
          then
            NEW_BEST_GAME=$NUMBER_OF_GUESSES
          else
            NEW_BEST_GAME=$BEST_GAME
          fi
          UPDATE_USER_RESULT=$($PSQL "UPDATE users SET games_played = $NEW_GAMES_PLAYED, best_game = $NEW_BEST_GAME WHERE username='$USERNAME'")
        done
      fi

      break
    fi
  fi
done