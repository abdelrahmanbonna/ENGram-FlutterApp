import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engram/screens/about.dart';
import 'package:engram/utilities/constants.dart';
import 'package:engram/utilities/e_n_g_r_a_m_icons.dart';
import 'package:engram/utilities/gramWidget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  static String id = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String valueSelected;

  List<DropdownMenuItem> menuItems;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  _launchURL() async {
    const url = 'https://github.com/abdelrahmanbonna/ENGram-FlutterApp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.855,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('grammar')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Text("No Data yet"),
                            );
                          } else {
                            final grammars = snapshot.data.documents;
                            List<GramWidget> bubbles = [];

                            for (var grammar in grammars) {
                              bubbles.add(GramWidget(
                                title: grammar.data['"name"'].toString().trim(),
                                grammar:
                                    "${grammar.data['"grammar"'].toString().trim()}",
                                examples: "\nExamples:\n" +
                                    "${grammar.data['"examples"'].toString().trim()}",
                              ));
                            }
                            return Column(
                              children: bubbles,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "All Rights Reserved © 2020 AbSolutions",
                  style: kAppTheme.textTheme.subtitle2.merge(
                    TextStyle(color: kColorWhite),
                  ),
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
