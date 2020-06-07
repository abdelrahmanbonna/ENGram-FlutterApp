import 'package:engram/backend/grammarData.dart';
import 'package:engram/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static String id = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String valueSelected;
  List<DropdownMenuItem> menuItems;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await Provider.of<GrammarData>(context, listen: false)
        .getDataFromFirebase();
    menuItems = Provider.of<GrammarData>(context, listen: false).getListItems();
    if (menuItems.length == null) {
      print("error: list is empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppTheme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {}),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "ENGram",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1.merge(
                          TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: DropdownButton(
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .merge(TextStyle(color: kAppTheme.primaryColor)),
                      items: menuItems,
//                      onChanged: (value) {
//                        setState(() {
//                          valueSelected = value;
//                        });
//                      },
                      value: valueSelected,
                      hint: Text(
                        "Choose Grammar name",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .merge(TextStyle(color: kAppTheme.primaryColor)),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Provider.of<GrammarData>(context)
                          .getGrammer(valueSelected),
                      style: kAppTheme.textTheme.subtitle2.merge(
                        TextStyle(color: kAppTheme.primaryColor),
                      ),
                    ),
                    Text(
                      "All Rights Reserved © 2020 AbSolutions",
                      style: kAppTheme.textTheme.subtitle2.merge(
                        TextStyle(color: kAppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
