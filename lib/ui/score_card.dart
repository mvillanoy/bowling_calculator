import 'package:bowling_calculator/constants/styles.dart';
import 'package:bowling_calculator/model/frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoreCardPage extends StatefulWidget {
  const ScoreCardPage({Key? key}) : super(key: key);

  @override
  State<ScoreCardPage> createState() => _ScoreCardPageState();
}

class _ScoreCardPageState extends State<ScoreCardPage> {
  late List<Frame> frames = [];
  TextInputFormatter allowedCharsFilter =
      FilteringTextInputFormatter.allow(RegExp("[0-9/Xx-]"));

  @override
  void initState() {
    initFrames();
    super.initState();
  }

  void initFrames() {
    for (int i = 0; i < 11; i++) {
      frames.add(Frame("-", "-", i == frames.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget singleItemList(int index) {
      return Container(
        height: 65,
        decoration: cardStyle,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              index == frames.length - 1 ? "Bonus" : (index + 1).toString(),
              style: titleStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 50,
                child: TextFormField(
                  decoration: defaultScoreInputStyle,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  inputFormatters: <TextInputFormatter>[
                    allowedCharsFilter,
                  ],
                  maxLength: 1,
                  onChanged: (text) {
                    frames[index].setFirstRoll(text);
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 50,
                child: TextFormField(
                  decoration: defaultScoreInputStyle,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  inputFormatters: <TextInputFormatter>[
                    allowedCharsFilter,
                  ],
                  // keyboardType: TextInputType.number,
                  onChanged: (text) {
                    setState(() {
                      frames[index].setSecondRoll(text);
                    });
                  },
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bowling Score Card"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                  children: List.generate(
                    10,
                    (index) {
                      return singleItemList(index);
                    },
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: singleItemList(10)),
                Container(
                  decoration: cardStyle,
                  height: 65,
                  alignment: Alignment.center,
                  child: Text("Total: " + Frame.computeScore(frames).toString(),
                      style: titleStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
