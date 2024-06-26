# Number-Guessing-Game 🎲

### Description
This is a simple number guessing game implemented in Bash, interacting directly with a PostgreSQL database. The game allows users to guess a randomly generated secret number between 1 and 1000.

### Features
- **Welcome and Registration**: Upon starting the game, the user is prompted to enter their username. If it's their first time playing, they are automatically registered in the database.
- **User Recognition**: If the user has played before, a personalized welcome message is displayed along with previous game statistics.
- **Number Guessing**: The user attempts to guess the secret number. After each guess, a hint is provided to help refine the next guess.
- **Statistics Update**: After each successful game, the user's statistics are updated in the database, including total games played and best game in terms of guesses.

### Usage
1. **Environment Setup**
   - Ensure PostgreSQL is installed and properly configured.
   - Run the `number-guessing-game.sh` script in a Unix/Linux terminal.

2. **Instructions**
   - Follow the instructions provided in the terminal to play the game.
   - Input an integer when prompted to guess the secret number.

### System Requirements
- Bash (Unix/Linux shell)
- PostgreSQL
