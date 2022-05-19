enum Type { strike, spare, miss }

class Frame {
  Type type = Type.miss;
  List<int> roll = [];
  String firstRoll = '-';
  String secondRoll = '-';
  bool isBonus = false;

  Frame(this.firstRoll, this.secondRoll, this.isBonus) {
    if (firstRoll == 'X') {
      type = Type.strike;
      roll.add(10);
      if (isBonus) {
        roll.add(firstRoll == 'X' ? 10 : int.parse(secondRoll));
      }
    } else if (secondRoll == '/') {
      type = Type.spare;
      roll.add(firstRoll == "-" ? 0 : int.parse(firstRoll));
      roll.add(10 - roll[0]);
    } else {
      roll.add(firstRoll == "-" ? 0 : int.parse(firstRoll));
      roll.add(secondRoll == "-" ? 0 : int.parse(secondRoll));
    }
  }

  void setFirstRoll(String text) {
    if (text.isEmpty) {
      firstRoll = "-";
      roll[0] = 0;
      return;
    }

    firstRoll = text;
    if (text == 'X') {
      type = Type.strike;
      roll[0] = 10;
    } else {
      roll[0] = text == "-" ? 0 : int.parse(text);
    }
  }

  void setSecondRoll(String text) {
    if (text.isEmpty) {
      firstRoll = "-";
      roll[0] = 0;
      return;
    }
    secondRoll = text;
    if (text == 'X') {
      roll[1] = 10;
    } else if (text == '/' || int.parse(text) == 10 - roll[0]) {
      type = Type.spare;
      roll[1] = 10 - roll[0];
    } else {
      roll[1] = text == "-" ? 0 : int.parse(text);
    }
  }

  static int computeScore(List<Frame> frames) {
    int score = 0;
    for (int i = 0; i < 10; i++) {
      if (frames[i].type == Type.strike) {
        score = score +
            frames[i].roll[0] +
            frames[i + 1].roll[0] +
            ((frames[i + 1].type == Type.strike && i != 9)
                ? frames[i + 2].roll[0]
                : frames[i + 1].roll[1]);
      } else if (frames[i].type == Type.spare) {
        score = score +
            frames[i].roll[0] +
            frames[i].roll[1] +
            frames[i + 1].roll[0];
      } else {
        score = score + frames[i].roll[0] + frames[i].roll[1];
      }
    }
    return score;
  }
}
