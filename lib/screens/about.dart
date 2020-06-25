import 'package:engram/screens/home.dart';
import 'package:engram/utilities/constants.dart';
import 'package:engram/utilities/e_n_g_r_a_m_icons.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  static String id = "about";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: kAppTheme.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          ENGRAM.back,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Home.id);
                        }),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "About",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1.merge(
                            TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Text(
                          "ENGram is an English Dictionary which contains Grammar.\n"
                          " Made to help Students to know the grammar faster"
                          "\n\nMade by Abdelrahman Bonna\n"
                          "Email: abdelrahmanbonna@outlook.com\n",
                          style: kAppTheme.textTheme.headline2.merge(
                            TextStyle(color: kAppTheme.primaryColor),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Under BSD 3 License See Github repository for more details",
                          style: kAppTheme.textTheme.subtitle2.merge(
                            TextStyle(color: kAppTheme.primaryColor),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
