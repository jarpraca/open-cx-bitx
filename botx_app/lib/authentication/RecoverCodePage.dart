import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'dart:ui';
import 'package:flutter/cupertino.dart';

class RecoverCode extends StatelessWidget {
  final submitController = TextEditingController();

  void _showDialog(context, message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Recover Password"),
              content: new Text(message),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('Close'))
              ]
          );
        }
    );
  }
  void handleSubmit(context) {
    if(submitController.text == "teste@gmail.com"){
      _showDialog(context, "An email as been sent with instructions for recovery");
    }
    else{
      _showDialog(context, "Please insert a valid email");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                height: 130,
              ),
              Container(
                height: 80,
                child: const Center(
                    child: Text('Insert your email',
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
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: new TextField(
                    controller: submitController,
                    style: new TextStyle(color: const Color(0xaaffffff), fontSize: 20),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xff66abbe)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xff66abbe)),
                      ),
                    ),
                  )),
              SizedBox(
                  width: 400.0,
                  height: 80.0,
                  child: MaterialButton(
                      child: Text('Submit',
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
                        handleSubmit(context);
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: const Color(0xff66abbe),
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(40)))),
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
