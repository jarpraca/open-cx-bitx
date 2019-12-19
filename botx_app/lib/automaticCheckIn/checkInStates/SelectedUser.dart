import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'dart:ui';
import 'package:flutter/cupertino.dart';

class SelectedUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user_id = "01234567890";
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
        body: Padding(padding: const EdgeInsets.all(8), child: Column(children: <Widget>[
          Container(height: 40),
          Container(
            height: 50,
            child: const Center(
                child: Text('You have been selected!',
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
          Container(
            height: 100,
            child: const Center(
                child: Image(image: AssetImage('assets/images/botX.png'))),
          ),
          Container(
              height: 50,
              child: const Center(
                  child: Text(
                    'is on the way!',
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
                        ]),
                  ))),
          Row(children: <Widget>[
            Expanded(
                flex: 10,
                child: Divider(
                    color: const Color(0xff66abbe), height: 40.0, thickness: 2.0))
          ]),
          Container(
            height: 230,
            child: Center(
              //child: Image(image: AssetImage('assets/images/qrcode.png'))
              child: QrImage(
                data: user_id,
                version: QrVersions.auto,
                size: 200.0,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Row(children: <Widget>[
            Expanded(
                flex: 10,
                child: Divider(
                    color: const Color(0xff66abbe), height: 40.0, thickness: 2.0))
          ]),
          Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child:
                Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
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
                  Image(image: AssetImage('assets/images/bitX.png'), height: 50),
                ]),
              )),
        ])));
  }
}
