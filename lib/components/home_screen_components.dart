import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/models/models.dart';
import 'package:tic_tac_toe/controllers/providers.dart';
import 'package:tic_tac_toe/controllers/sound_seffects_provider.dart';

class PlayerPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
            color: kPrimaryColor,
          ),
          height: MediaQuery.of(context).size.height / 12,
          width: MediaQuery.of(context).size.width / 1.5,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!Provider.of<GameBoard>(context, listen: false)
                        .hasAlreadyPlayed()) {
                      Provider.of<GameBoard>(context, listen: false)
                          .setIsX(true);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        topLeft: Radius.circular(14),
                      ),
                      color: Provider.of<GameBoard>(context).isX
                          ? kSelectedColor
                          : kUnSelectedColor,
                    ),
                    child: Center(
                      child: Text(
                        'X',
                        style: kBigChoice,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!Provider.of<GameBoard>(context, listen: false)
                        .hasAlreadyPlayed()) {
                      Provider.of<GameBoard>(context, listen: false)
                          .setIsX(false);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                      color: Provider.of<GameBoard>(context).isX
                          ? kUnSelectedColor
                          : kSelectedColor,
                    ),
                    child: Center(
                      child: Text(
                        'O',
                        style: kBigChoice,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ScorWidget extends StatefulWidget {
  @override
  _ScorWidgetState createState() => _ScorWidgetState();
}

class _ScorWidgetState extends State<ScorWidget> {
  String label = 'Playing ...';
  String getLabel() {
    if (Provider.of<GameBoard>(context).gameState == GameState.userWin) {
      Provider.of<GameSounds>(context, listen: false).win();

      return 'You Won 👌';
    } else if (Provider.of<GameBoard>(context).gameState ==
        GameState.userLose) {
      return 'You Lost 🤕';
    } else if (Provider.of<GameBoard>(context).gameState == GameState.even) {
      return 'You are even 🤝';
    } else
      return label;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        getLabel(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class BoardUnitWidget extends StatefulWidget {
  BoardUnitWidget({required this.index, required this.uniqueKey});
  final int index;
  final UniqueKey uniqueKey;
  @override
  _BoardUnitWidgetState createState() => _BoardUnitWidgetState();
}

class _BoardUnitWidgetState extends State<BoardUnitWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Provider.of<GameBoard>(context, listen: false).turn) {
          Provider.of<GameSounds>(context, listen: false).buttonClick();
          Provider.of<GameBoard>(context, listen: false).userPlay(widget.index);
        }
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              border: Border.all(color: Colors.black, width: 2)),
          margin: EdgeInsets.all(2),
          height: MediaQuery.of(context).size.width / 5.5,
          width: MediaQuery.of(context).size.width / 6.5,
          child: Center(
            child: Text(
              Provider.of<GameBoard>(context).gameBoardString[widget.index],
              style: kMainTextStyle,
            ),
          )),
    );
  }
}

class PlayAgain extends StatefulWidget {
  const PlayAgain({Key? key}) : super(key: key);

  @override
  State<PlayAgain> createState() => _PlayAgainState();
}

class _PlayAgainState extends State<PlayAgain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Provider.of<GameBoard>(context).showAlert
          ? GestureDetector(
              onTap: () {
                Provider.of<GameBoard>(context, listen: false).reset();
              },
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  margin: EdgeInsets.only(bottom: 0),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Play again !',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
