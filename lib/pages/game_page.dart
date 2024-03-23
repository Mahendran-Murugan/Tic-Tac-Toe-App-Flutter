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
  String result = "";
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

  static var customFont = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 28.0,
      color: MainColors.secondaryColor,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Score Board",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          color: MainColors.secondaryColor,
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
            const Expanded(
              flex: 1,
              child: Text(
                "Start",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _isTapped(int index) {
    setState(() {
      if (!clicked[index]) {
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
        result = 'Player ${board[0]} Wins';
      });
    }
  }
}
