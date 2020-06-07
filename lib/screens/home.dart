import 'package:engram/backend/grammarData.dart';
import 'package:engram/screens/about.dart';
import 'package:engram/utilities/constants.dart';
import 'package:engram/utilities/e_n_g_r_a_m_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  static String id = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String valueSelected, grammars = "";
  List<DropdownMenuItem> menuItems;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    getData();
  }

  _launchURL() async {
    const url = 'https://github.com/abdelrahmanbonna/ENGram-FlutterApp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void getData() async {
    await Provider.of<GrammarData>(context, listen: false)
        .getDataFromFirebase();
    menuItems = Provider.of<GrammarData>(context, listen: false).getListItems();
    if (menuItems.length == null) {
      print("error: list is empty");
    }
  }

  getGrammar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 40,
        child: Container(
          color: kAppTheme.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                color: kAppTheme.accentColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, About.id);
                        },
                        padding: EdgeInsets.all(10),
                        color: kAppTheme.primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              ENGRAM.about,
                              size: 50,
                              color: kColorWhite,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            Text(
                              'About',
                              style: kAppTheme.textTheme.subtitle2
                                  .merge(TextStyle(color: kColorWhite)),
                            )
                          ],
                        ),
                      ),
                    ),
                    FlatButton(
                      color: kAppTheme.primaryColor,
                      onPressed: () {
                        _launchURL();
                      },
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            ENGRAM.github_image,
                            size: 50,
                            color: kColorWhite,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Text(
                            'Github Repository',
                            style: kAppTheme.textTheme.subtitle2
                                .merge(TextStyle(color: kColorWhite)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      }),
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
                      onChanged: (value) {
                        valueSelected = value;
                      },
                      value: valueSelected,
                      elevation: 0,
                      onTap: () {
                        Provider.of<GrammarData>(context, listen: false)
                            .setInput(valueSelected);
                      },
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
                      Provider.of<GrammarData>(context, listen: true)
                          .getGrammar(),
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
