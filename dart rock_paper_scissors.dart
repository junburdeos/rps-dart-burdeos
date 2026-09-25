import 'dart:io';

const List<String> moves = ['rock', 'paper', 'scissors'];

/// Gets the player's name, or uses a default name if empty.
String getPlayerName(String defaultName) {
  stdout.write('Enter $defaultName name: ');
  String? input = stdin.readLineSync();
  String name = input?.trim() ?? '';

  if (name.isEmpty) {
    print('(No name entered. Using "$defaultName".)');
    return defaultName;
  }
  return name;
}

/// Returns the move in lowercase if valid, otherwise null.
String? validateMove(String? input) {
  String move = input?.trim().toLowerCase() ?? '';
  return moves.contains(move) ? move : null;
}

/// Asks the player for a move until it is valid.
String getMove(String playerName) {
  String? move;

  // Keep asking until the move is valid.
  while (move == null) {
    stdout.write('$playerName, enter your move (rock/paper/scissors): ');
    move = validateMove(stdin.readLineSync());

    if (move == null) {
      print('Invalid move. Please type rock, paper, or scissors.');
    }
  }
  return move;
}

/// Returns 1 if Player 1 wins, 2 if Player 2 wins, or null if draw.
int? decideWinner(String move1, String move2) {
  if (move1 == move2) return null;

  // Rock beats scissors, paper beats rock, scissors beats paper.
  if ((move1 == 'rock' && move2 == 'scissors') ||
      (move1 == 'paper' && move2 == 'rock') ||
      (move1 == 'scissors' && move2 == 'paper')) {
    return 1;
  }
  return 2;
}

/// Runs the Rock, Paper, Scissors game.
void main() {
  print('===== ROCK, PAPER, SCISSORS =====');

  String playerOne = getPlayerName('Player 1');
  String playerTwo = getPlayerName('Player 2');
  int scoreOne = 0;
  int scoreTwo = 0;
  int round = 1;
  String? answer;

  do {
    print('\n--- Round $round ---');

    String moveOne = getMove(playerOne);

    // Print 30 blank lines to hide Player 1's move.
    for (int i = 0; i < 30; i++) {
      print('');
    }

    String moveTwo = getMove(playerTwo);
    print('$playerOne chose $moveOne. $playerTwo chose $moveTwo.');

    // Find the winner (null means draw).
    int? winner = decideWinner(moveOne, moveTwo);
    String? result;

    if (winner == 1) {
      result = '$playerOne wins the round!';
      scoreOne++;
    } else if (winner == 2) {
      result = '$playerTwo wins the round!';
      scoreTwo++;
    }

    // If result is null, print "It's a draw!".
    print('Result: ${result ?? "It's a draw!"}');
    print('Score -> $playerOne: $scoreOne | $playerTwo: $scoreTwo');

    stdout.write('Play again? (y/n): ');
    answer = stdin.readLineSync();
    round++;
  } while (answer?.trim().toLowerCase() != 'n');

  print('\n===== FINAL SCORE =====');
  print('$playerOne: $scoreOne | $playerTwo: $scoreTwo');

  String? overallWinner;
  if (scoreOne > scoreTwo) overallWinner = playerOne;
  if (scoreTwo > scoreOne) overallWinner = playerTwo;
  print('Overall winner: ${overallWinner ?? "It's a draw!"}');
}
