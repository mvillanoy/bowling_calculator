enum Type { strike, spare, miss }

class Frame {
  Type type = Type.miss;
  List<int> roll = [];
  String firstRoll = '-';
  String secondRoll = '-';

  Frame(this.firstRoll, this.secondRoll, {isBonus = false}) {
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
    firstRoll = text;
    if (text == 'X') {
      type = Type.strike;
      roll[0] = 10;
    } else {
      roll[0] = text == "-" ? 0 : int.parse(text);
    }
  }

  void setSecondRoll(String text) {
    secondRoll = text;
    if (text == 'X') {
      roll[1] = 10;
    } else if (text == '/') {
      type = Type.spare;
      roll[1] = 10 - roll[0];
    } else {
      roll[1] = text == "-" ? 0 : int.parse(text);
    }
  }
}
