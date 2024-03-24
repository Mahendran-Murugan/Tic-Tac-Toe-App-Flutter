import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/constants/colors.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool player1Turn = true;
  int player1Score = 0;
  int player2Score = 0;
  String result = "";
  bool isWon = false;
  int filledBoxs = 0;
  int matchNo = 0;
  List<int> winningIndexes = [];
  List<String> board = ["", "", "", "", "", "", "", "", ""];
  List<bool> clicked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  static var customFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      fontSize: 20.0,
      color: MainColors.secondaryColor,
      fontWeight: FontWeight.bold,
    ),
  );

  static var customFontScore = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      fontSize: 18.0,
      color: MainColors.secondaryColor,
      fontWeight: FontWeight.bold,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Matchs",
                            style: customFontScore,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "$matchNo",
                            style: customFontScore,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Player 1",
                                style: customFontScore,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "$player1Score",
                                style: customFontScore,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Player 2",
                                style: customFontScore,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "$player2Score",
                                style: customFontScore,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                flex: 4,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext contex, int index) {
                      return GestureDetector(
                        onTap: () => {
                          _isTapped(index),
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              width: 5,
                              color: MainColors.primaryColor!,
                            ),
                            color: winningIndexes.contains(index)
                                ? MainColors.accentColor
                                : MainColors.secondaryColor,
                          ),
                          child: Center(
                            child: Text(
                              board[index],
                              style: GoogleFonts.reggaeOne(
                                textStyle: TextStyle(
                                  fontSize: 60,
                                  color: MainColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        result,
                        style: customFont,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 13),
                      ),
                      onPressed: () => _clearBoard(),
                      child: Text(
                        (matchNo > 0) ? "Play Again !" : "Play !",
                        style: GoogleFonts.reggaeOne(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: MainColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _isTapped(int index) {
    setState(() {
      if (!clicked[index] && !isWon) {
        filledBoxs++;
        clicked[index] = true;
        board[index] = (player1Turn && board[index] == "")
            ? "X"
            : (!player1Turn && board[index] == "")
                ? "O"
                : board[index];
        player1Turn = !player1Turn;
        _isWon();
      }
    });
  }

  void _isWon() {
    if (board[0] == board[1] && board[1] == board[2] && board[0] != '') {
      setState(() {
        result = 'Player ${(board[0] == 'X') ? 1 : 2} Wins';
        _incrementScore(board[0]);
        winningIndexes.addAll([0, 1, 2]);
      });
      isWon = true;
    }
    if (board[3] == board[4] && board[4] == board[5] && board[3] != '') {
      setState(() {
        result = 'Player ${(board[3] == 'X') ? 1 : 2} Wins';
        _incrementScore(board[3]);
        winningIndexes.addAll([3, 4, 5]);
      });
      isWon = true;
    }
    if (board[6] == board[7] && board[7] == board[8] && board[6] != '') {
      setState(() {
        result = 'Player ${board[6]} Wins';
        _incrementScore(board[6]);
        winningIndexes.addAll([6, 7, 8]);
      });
      isWon = true;
    }
    if (board[0] == board[3] && board[3] == board[6] && board[0] != '') {
      setState(() {
        result = 'Player ${(board[0] == 'X') ? 1 : 2} Wins';
        _incrementScore(board[0]);
        winningIndexes.addAll([0, 3, 6]);
      });
      isWon = true;
    }
    if (board[1] == board[4] && board[4] == board[7] && board[1] != '') {
      setState(() {
        result = 'Player ${(board[1] == 'X') ? 1 : 2} Wins';
        _incrementScore(board[1]);
        winningIndexes.addAll([1, 4, 7]);
      });
      isWon = true;
    }
    if (board[2] == board[5] && board[5] == board[8] && board[2] != '') {
      setState(() {
        result = 'Player ${(board[2] == 'X') ? 1 : 2} Wins';
        _incrementScore(board[2]);
        winningIndexes.addAll([2, 5, 8]);
      });
      isWon = true;
    }
    if (board[0] == board[4] && board[4] == board[8] && board[0] != '') {
      setState(() {
        result = 'Player ${(board[0] == 'X') ? 1 : 2} Wins';
        _incrementScore(board[0]);
        winningIndexes.addAll([0, 4, 8]);
      });
      isWon = true;
    }
    if (board[2] == board[4] && board[4] == board[6] && board[2] != '') {
      setState(() {
        result = 'Player ${(board[2] == 'X') ? 1 : 2} Wins';
        _incrementScore(board[2]);
        winningIndexes.addAll([2, 4, 6]);
      });
      isWon = true;
    }
    if (filledBoxs == 9 && !isWon) {
      setState(() {
        result = 'It\'s a Draw ';
      });
      matchNo++;
    }
  }

  void _incrementScore(String winner) {
    (winner == 'X') ? player1Score++ : player2Score++;
    matchNo++;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        board[i] = '';
        clicked[i] = false;
      }
      result = "";
      winningIndexes.clear();
    });
    filledBoxs = 0;
    isWon = false;
    player1Turn = true;
  }
}
