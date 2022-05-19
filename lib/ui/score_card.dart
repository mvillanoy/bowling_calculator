import 'package:bowling_calculator/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../model/frame.dart';

class ScoreCardPage extends StatefulWidget {
  const ScoreCardPage({Key? key}) : super(key: key);

  @override
  State<ScoreCardPage> createState() => _ScoreCardPageState();
}

class _ScoreCardPageState extends State<ScoreCardPage> {
  late List<Frame> frames = List.filled(11, Frame("-", "-"));
  TextInputFormatter allowedCharsFilter =
      FilteringTextInputFormatter.allow(RegExp("[0-9/Xx-]"));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget singleItemList(int index) {
      Frame item = frames[index];
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
                    item.setFirstRoll(text);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                // height: 50,
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
                    item.setSecondRoll(text);
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
                  child: Text("Total: " + 10.toString(), style: titleStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
