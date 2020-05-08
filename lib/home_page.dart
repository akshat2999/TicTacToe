import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tick_tak_toe2/custom_dialog.dart';
import 'package:tick_tak_toe2/game_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var player1;
  var player2;
  var activePlayer;
  List<GameButton> buttonList;
  @override
  void initState() {
    super.initState();
    buttonList = init();
  }

  List<GameButton> init() {
    player1 = List();
    player2 = List();
    activePlayer = 1;

    var gameButton = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButton;
  }

  void PlayGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.title = 'X';
        gb.bg = Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.title = 'O';
        gb.bg = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      var winner = Winner();
      if (winner == -1) {
        if (buttonList.every((p) => p.title != "")) {
          showDialog(
              context: context,
              builder: (_) => new CustomDialog("Game Tied",
                  "Press the reset button to start again.", resetGame));
        } else {
          activePlayer == 2 ? autoplay() : null;
        }
      }
    });
  }

  void autoplay() {
    var emptyCells = new List();
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonList.indexWhere((p) => p.id == cellID);
    PlayGame(buttonList[i]);
  }

  int Winner() {
    var winner = -1;
    if ((player1.contains(1) && player1.contains(2) && player1.contains(3)) ||
        (player1.contains(4) && player1.contains(5) && player1.contains(6)) ||
        (player1.contains(7) && player1.contains(8) && player1.contains(9)) ||
        (player1.contains(1) && player1.contains(4) && player1.contains(7)) ||
        (player1.contains(2) && player1.contains(5) && player1.contains(8)) ||
        (player1.contains(3) && player1.contains(6) && player1.contains(9)) ||
        (player1.contains(1) && player1.contains(5) && player1.contains(9)) ||
        (player1.contains(3) && player1.contains(5) && player1.contains(7)))
      winner = 1;
    if ((player2.contains(1) && player2.contains(2) && player2.contains(3)) ||
        (player2.contains(4) && player2.contains(5) && player2.contains(6)) ||
        (player2.contains(7) && player2.contains(8) && player2.contains(9)) ||
        (player2.contains(1) && player2.contains(4) && player2.contains(7)) ||
        (player2.contains(2) && player2.contains(5) && player2.contains(8)) ||
        (player2.contains(3) && player2.contains(6) && player2.contains(9)) ||
        (player2.contains(1) && player2.contains(5) && player2.contains(9)) ||
        (player2.contains(3) && player2.contains(5) && player2.contains(7)))
      winner = 2;
    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                'Player1 Won', 'Press reset to play again', resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                'Player2 Won', 'Press reset to play again', resetGame));
      }
    }
    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonList = init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tick Tak Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 9,
                crossAxisSpacing: 9,
                childAspectRatio: 1.0,
              ),
              padding: EdgeInsets.all(10),
              itemCount: buttonList.length,
              itemBuilder: (context, i) => SizedBox(
                height: 100,
                width: 100,
                child: RaisedButton(
                  padding: EdgeInsets.all(8),
                  onPressed: buttonList[i].enabled
                      ? () => PlayGame(buttonList[i])
                      : null,
                  child: Text(
                    buttonList[i].title,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: buttonList[i].bg,
                  disabledColor: buttonList[i].bg,
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: resetGame,
            color: Colors.red,
            child: Text(
              'Reset',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.all(10),
          )
        ],
      ),
    );
  }
}
