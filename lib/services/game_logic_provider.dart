import 'package:flutter/foundation.dart';

enum GameState {
  userWin,
  userLose,
  even,
  playing,
}

enum BoardUnitValue { x, o, empty }

class GameLogic extends ChangeNotifier {
  List<bool> freeBoardUnits = [];
  BoardUnitValue userChoice = BoardUnitValue.o;
  bool isComputerThinking = false;
  List<BoardUnitValue> boardUnitsValues = [];
  List<int> userMoves = [];
  List<int> computerMoves = [];
  bool showAlert = false;

  GameLogic({required this.boardUnitsValues, required this.freeBoardUnits});

  void restartGame() {
    freeBoardUnits.clear();
    freeBoardUnits = [
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
    boardUnitsValues.clear();
    boardUnitsValues = [
      BoardUnitValue.empty,
      BoardUnitValue.empty,
      BoardUnitValue.empty,
      BoardUnitValue.empty,
      BoardUnitValue.empty,
      BoardUnitValue.empty,
      BoardUnitValue.empty,
      BoardUnitValue.empty,
      BoardUnitValue.empty
    ];

    computerMoves.clear();
    userMoves.clear();
    showAlert = false;
    isComputerThinking = false;
    notifyListeners();
  }

  int getRandomPlay() {
    List<int> avalaibles = [];

    for (var i = 0; i < freeBoardUnits.length; i++) {
      if (!freeBoardUnits[i]) {
        avalaibles.add(i);
      }
    }

    if (avalaibles.length > 0) {
      // to get random numbers
      avalaibles.shuffle();
      return avalaibles.last;
    } else {
      return -1;
    }
  }

  bool stillPlaying() {
    bool still = true;
    if (checkState() == GameState.userWin) {
      still = false;
    } else if (checkState() == GameState.userLose) {
      still = false;
    } else if (checkState() == GameState.even) {
      still = false;
    }
    return still;
  }

  Future<void> computerPlay() async {
    isComputerThinking = true;
    print('Computer playing .. ');
    BoardUnitValue computerChoice;
    if (userChoice == BoardUnitValue.o) {
      computerChoice = BoardUnitValue.x;
    } else {
      computerChoice = BoardUnitValue.o;
    }
    if (stillPlaying()) {
      int random = getRandomPlay();

      await Future.delayed(Duration(milliseconds: 400));
      freeBoardUnits[random] = true;
      boardUnitsValues[random] = computerChoice;
      computerMoves.add(random);
      print('Computer played');
      print(boardUnitsValues);
      checkState();
      isComputerThinking = false;
      notifyListeners();
    }
  }

  BoardUnitValue getUserChoice() {
    return userChoice;
  }

  void setUserChoice(BoardUnitValue value) {
    userChoice = value;
    notifyListeners();
  }

  bool getIsComputerThinking() {
    return isComputerThinking;
  }

  bool getShowAlert() {
    return showAlert;
  }

  GameState checkState() {
    GameState state;
    if (isWin()) {
      print(GameState.userWin);
      state = GameState.userWin;
      showAlert = true;
      notifyListeners();
    } else if (isLose()) {
      print(GameState.userLose);
      state = GameState.userLose;
      showAlert = true;
      notifyListeners();
    } else if (isEven()) {
      print(GameState.even);
      state = GameState.even;
      showAlert = true;
      notifyListeners();
    } else {
      print(GameState.playing);
      state = GameState.playing;
    }
    return state;
  }

  bool isWin() {
    if (userMoves.contains(0) &&
            userMoves.contains(1) &&
            userMoves.contains(2) ||
        userMoves.contains(3) &&
            userMoves.contains(4) &&
            userMoves.contains(5) ||
        userMoves.contains(6) &&
            userMoves.contains(7) &&
            userMoves.contains(8) ||
        userMoves.contains(0) &&
            userMoves.contains(3) &&
            userMoves.contains(6) ||
        userMoves.contains(1) &&
            userMoves.contains(4) &&
            userMoves.contains(7) ||
        userMoves.contains(2) &&
            userMoves.contains(5) &&
            userMoves.contains(8) ||
        userMoves.contains(2) &&
            userMoves.contains(4) &&
            userMoves.contains(6) ||
        userMoves.contains(0) &&
            userMoves.contains(4) &&
            userMoves.contains(8)) {
      print('User Won !');
      return true;
    } else {
      return false;
    }
  }

  bool isLose() {
    if (computerMoves.contains(0) &&
            computerMoves.contains(1) &&
            computerMoves.contains(2) ||
        computerMoves.contains(3) &&
            computerMoves.contains(4) &&
            computerMoves.contains(5) ||
        computerMoves.contains(6) &&
            computerMoves.contains(7) &&
            computerMoves.contains(8) ||
        computerMoves.contains(0) &&
            computerMoves.contains(3) &&
            computerMoves.contains(6) ||
        computerMoves.contains(1) &&
            computerMoves.contains(4) &&
            computerMoves.contains(7) ||
        computerMoves.contains(2) &&
            computerMoves.contains(5) &&
            computerMoves.contains(8) ||
        computerMoves.contains(2) &&
            computerMoves.contains(4) &&
            computerMoves.contains(6) ||
        computerMoves.contains(0) &&
            computerMoves.contains(4) &&
            computerMoves.contains(8)) {
      print(GameState.userLose);

      return true;
    } else {
      return false;
    }
  }

  bool isEven() {
    if ((computerMoves.length + userMoves.length) >= 8) {
      return true;
    } else {
      return false;
    }
  }

  void userPlay(int index) {
    if (stillPlaying()) {
      if (!isComputerThinking) {
        if (!freeBoardUnits[index]) {
          freeBoardUnits[index] = true;
          boardUnitsValues[index] = userChoice;
          userMoves.add(index);
          print('User played .. ');
          print(userMoves);
          checkState();
          notifyListeners();
          computerPlay();
        }
      }
    }
  }
}
