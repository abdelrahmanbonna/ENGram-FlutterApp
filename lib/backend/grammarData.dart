import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engram/backend/grammar.dart';
import 'package:engram/utilities/constants.dart';
import 'package:flutter/material.dart';

class GrammarData extends ChangeNotifier {
  List<Grammar> _list = [];
  String _input;
  var _fire = Firestore.instance;

  Future<void> getDataFromFirebase() async {
    _list.clear();
    final grammars = await _fire.collection('grammar').getDocuments();

    for (var grammar in grammars.documents) {
      Map<dynamic, dynamic> map =
          json.decode(grammar.data.toString()) as Map<String, dynamic>;
      _list.add(Grammar(
        name: map['name'].toString(),
        grammar: map['grammar'].toString(),
      ));
    }

    notifyListeners();
  }

  List<DropdownMenuItem> getListItems() {
    List<DropdownMenuItem> listofItems = [];
    for (var grammar in _list) {
      listofItems.add(
        DropdownMenuItem(
          child: Text(
            grammar.name,
            style: kAppTheme.textTheme.subtitle2.merge(
              TextStyle(color: kAppTheme.primaryColor),
            ),
          ),
        ),
      );
    }

    return listofItems;
  }

  setInput(String inp) {
    _input = inp;
    notifyListeners();
  }

  String getGrammar() {
    String grammar = "";
    for (var item in _list) {
      print("this is the name  " + item.name);
      print("this is the input  " + _input);
      if (item.name == _input) {
        grammar = item.grammar;
      }
    }

    return grammar;
  }
}
