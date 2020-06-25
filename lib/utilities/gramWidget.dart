import 'package:engram/utilities/constants.dart';
import 'package:flutter/material.dart';

class GramWidget extends StatefulWidget {
  final String title, grammar,examples;

  GramWidget({this.title, this.grammar,this.examples});

  @override
  _GramWidgetState createState() => _GramWidgetState();
}

class _GramWidgetState extends State<GramWidget> {
  bool expand = false;
  List<Widget> getColumnList() {
    List<Widget> list = [];
    if (!expand) {
      list = [
        Text(
          widget.title,
          style: kAppTheme.textTheme.bodyText2.merge(
            TextStyle(
                color: kColorWhite, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          textAlign: TextAlign.center,
        ),
      ];
      return list;
    } else {
      list = [
        Text(
          widget.title.isNotEmpty ? widget.title : "Empty",
          style: kAppTheme.textTheme.bodyText2.merge(TextStyle(
              color: kColorWhite, fontWeight: FontWeight.bold, fontSize: 25)),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Text(
          widget.grammar.isNotEmpty ? widget.grammar : "Empty",
          style: kAppTheme.textTheme.bodyText2
              .merge(TextStyle(color: kColorWhite, fontSize: 20)),
          textAlign: TextAlign.center,
        ),SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Text(
          widget.examples.isNotEmpty ? widget.examples : "Empty",
          style: kAppTheme.textTheme.bodyText2
              .merge(TextStyle(color: kColorWhite, fontSize: 20)),
          textAlign: TextAlign.center,
        ),
      ];
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            expand = !expand;
          });
        },
        child: Container(
          width: screen.width * 0.9,
          height: expand ? screen.height * 0.6 : screen.height * 0.05,
          decoration: BoxDecoration(
              color: kAppTheme.primaryColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 3)
              ]),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: getColumnList(),
            ),
          ),
        ),
      ),
    );
  }
}
