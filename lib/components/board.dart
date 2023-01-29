import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/home_screen_components.dart';
import 'package:tic_tac_toe/constants.dart';

class TheBoard extends StatefulWidget {
  TheBoard();

  @override
  _TheBoardState createState() => _TheBoardState();
}

class _TheBoardState extends State<TheBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
          color: kSecondaryColor.withOpacity(0.2),
        ),
        child: Column(
          children: [
            Row(
              children: [
                BoardUnitWidget(
                  index: 0,
                  uniqueKey: UniqueKey(),
                ),
                BoardUnitWidget(
                  index: 1,
                  uniqueKey: UniqueKey(),
                ),
                BoardUnitWidget(
                  index: 2,
                  uniqueKey: UniqueKey(),
                ),
              ],
            ),
            Row(
              children: [
                BoardUnitWidget(
                  index: 3,
                  uniqueKey: UniqueKey(),
                ),
                BoardUnitWidget(
                  index: 4,
                  uniqueKey: UniqueKey(),
                ),
                BoardUnitWidget(
                  index: 5,
                  uniqueKey: UniqueKey(),
                ),
              ],
            ),
            Row(
              children: [
                BoardUnitWidget(
                  index: 6,
                  uniqueKey: UniqueKey(),
                ),
                BoardUnitWidget(
                  index: 7,
                  uniqueKey: UniqueKey(),
                ),
                BoardUnitWidget(
                  index: 8,
                  uniqueKey: UniqueKey(),
                ),
              ],
            ),
          ],
        ));
  }
}
