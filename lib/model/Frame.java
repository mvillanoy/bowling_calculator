class Frame {
    Type type = Type.miss;
    List<int> roll = [];
    Frame(String frameString){

        if(frameString == 'X' || frameString == 'x'){
            this.type = Type.strike;
            this.roll.add(10);
        } else if(frameString.contains("/")){
            this.type = Type.spare;
            this.roll.add(frameString[0] == "-" ? 0 : int.parse(frameString[0]));
            this.roll.add(10-this.roll[0]);
            if(frameString.length > 2){
              this.roll.add(int.parse(frameString[2]));
            }
        } else {
            this.roll.add(frameString[0] == "-" ? 0 : int.parse(frameString[0]));
            this.roll.add(frameString[1] == "-" ? 0 : int.parse(frameString[1]));
        }
    }
}