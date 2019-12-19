import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'dart:ui';
import 'package:flutter/cupertino.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios,
                  color: const Color(0xff66abbe)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Row(children: <Widget>[
              Text('<programming> 2020',
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
              Image(image: AssetImage('assets/images/logo.png'))
            ])),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: <Widget>[
              Container(
                height: 40,
              ),
              Image(
                  image: AssetImage('assets/images/help_button.png'),
                  height: 80),
              Row(children: <Widget>[
                Expanded(
                    flex: 10,
                    child: Divider(
                        color: const Color(0xff66abbe),
                        height: 20.0,
                        thickness: 2.0))
              ]),
              Container(
                padding: const EdgeInsets.all(20),
                height: 300,
                child: const Center(
                    child: Text(
                        'Your check-in is done automatically as soon as we detect that you have entered the premisses, for that to work we need you to turn on your Bluetooth. If you are one of the lucky selected, our robot, BotX, will deliver your welcome package to you itself ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: const Color(0xaaffffff),
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 7.0,
                                  color: const Color(0xff66abbe)),
                              Shadow(
                                  offset: Offset(-1.0, -1.0),
                                  blurRadius: 7.0,
                                  color: const Color(0xff66abbe))
                            ]))),
              ),
              Row(children: <Widget>[
                Expanded(
                    flex: 10,
                    child: Divider(
                        color: const Color(0xff66abbe),
                        height: 20.0,
                        thickness: 2.0))
              ]),
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
                              image: AssetImage('assets/images/bitX.png'),
                              height: 50),
                        ]),
                  )),
            ])));
  }
}