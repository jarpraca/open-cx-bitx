import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:ui';
import 'package:flutter/cupertino.dart';

import 'package:botx_app/authentication/LoginPage.dart';
import 'package:botx_app/utilities/HelpPage.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Container(
            height: 100,
          ),
          Container(
            height: 150,
            child: const Center(
                child: Image(image: AssetImage('assets/images/logo.png'))),
          ),
          Container(
            height: 80,
            child: const Center(
                child: Text('<programming> 2020',
                    style: TextStyle(
                        fontSize: 22,
                        color: const Color(0xaaffffff),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)),
                          Shadow(
                              offset: Offset(-1.0, -1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe))
                        ]))),
          ),
          SizedBox(
              width: 400.0,
              height: 80.0,
              child: MaterialButton(
                  child: Text('Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: const Color(0xaaffffff),
                          shadows: <Shadow>[
                            Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: const Color(0xff66abbe)),
                            Shadow(
                                offset: Offset(-1.0, -1.0),
                                blurRadius: 3.0,
                                color: const Color(0xff66abbe))
                          ])),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: const Color(0xff66abbe),
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(40)))),
          new Center(
              heightFactor: 4,
              child: new RichText(
                text: new TextSpan(
                  text: "Don't own a ticket?\n    Buy one now",

                  style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xaaffffff),
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)),
                        Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe))
                      ]),
                  recognizer: new TapGestureRecognizer()..onTap = () => launch('https://2020.programming-conference.org/'),
                ),
              )),
          Container(
              alignment: Alignment.center,
              height: 80,
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Help()),
                    );
                  },
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset('assets/images/help_button.png'))),
          Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Powered by",
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color(0xaaffffff),
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: const Color(0xff66abbe)),
                                Shadow(
                                    offset: Offset(-1.0, -1.0),
                                    blurRadius: 3.0,
                                    color: const Color(0xff66abbe))
                              ])),
                      Image(
                          image: AssetImage('assets/images/bitX.png'), height: 50),
                    ]),
              )),
        ]));
  }
}
