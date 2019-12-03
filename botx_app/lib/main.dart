import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
BehaviorSubject<String>();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {@required this.id,
        @required this.title,
        @required this.body,
        @required this.payload});
}

/// IMPORTANT: running the following code on its own won't work as there is setup required for each platform head project.
/// Please download the complete example app from the GitHub repository where all the setup has been done
Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  // NOTE: if you want to find out if the app was launched via notification then you could use the following call and then do something like
  // change the default route of the app
  // var notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload);
      });
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class Login extends StatelessWidget {
  TextEditingController submitController = TextEditingController();

  void _showDialog(context) {
      showDialog(
        context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: new Text("Login"),
                content: new Text("Please insert a code"),
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
    if(submitController.text != ""){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BeaconInteraction()),
      );
    }
    else{
      _showDialog(context);
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
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Container(
                height: 130,
              ),
              Container(
                height: 80,
                child: const Center(
                    child: Text('Insert your code',
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
                  width: MediaQuery.of(context).size.width * 0.40,
                  alignment: Alignment.center,
                  child: new TextField(
                    controller: submitController,
                    style: new TextStyle(color: const Color(0xaaffffff), fontSize: 20),
                    textAlign: TextAlign.center,
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
              Container(
                alignment: Alignment.center,
                height: 100.0,
                child: new MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecoverCode()),
                    );
                  },
                  child: Text("Forgot your password?",
                      textAlign: TextAlign.center,
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
                ),
              ),
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

class NotCheckedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: <Widget>[
          Container(height: 40),
          Container(
            height: 150,
            child: const Center(
                child: Image(image: AssetImage('assets/images/logo.png'))),
          ),
          Container(
            height: 120,
            child: const Center(
                child: Text('QR Code Not Available Yet',
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
                  child: Text('Check-In: Not Completed',
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
                  onPressed: null,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: const Color(0xff66abbe),
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(40)))),
          Container(height: 40),
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

class NotSelectedUser extends StatelessWidget {
  final user_id = "01234567890";

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
        body: Padding(padding: const EdgeInsets.all(8), child: Column(children: <Widget>[
          Container(height: 40),
          Container(
            height: 100,
            child: const Center(
                child: Text("Sorry!\nYou haven't been selected!",
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
                        ]))),
          ),
          Row(children: <Widget>[
            Expanded(
                flex: 10,
                child: Divider(
                    color: const Color(0xff66abbe),
                    height: 40.0,
                    thickness: 2.0))
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
                    color: const Color(0xff66abbe),
                    height: 40.0,
                    thickness: 2.0))
          ]),
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
        ])));
  }
}

class TurnOnBluetooth extends StatelessWidget {
  final StreamController<BluetoothState> streamController = StreamController();

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
        body: Padding(padding: const EdgeInsets.all(8), child: Column(children: <Widget>[
          Container(height: 60),
          Row(children: <Widget>[
            Expanded(
                flex: 10,
                child: Divider(
                    color: const Color(0xff66abbe),
                    height: 40.0,
                    thickness: 2.0))
          ]),
          Container(
            height: 100,
            child: const Center(
                child: Text("Please turn on your bluetooth",
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
                        ]))),
          ),
          IconButton(
            iconSize: 100,
            icon: Icon(Icons.bluetooth),
            onPressed: () async {
              if (Platform.isAndroid) {
                try {
                  await flutterBeacon.openBluetoothSettings;
                } on PlatformException catch (e) {
                  print(e);
                }
              }
            },
            color: const Color(0xff66abbe),
          ),
          Row(children: <Widget>[
            Expanded(
                flex: 10,
                child: Divider(
                    color: const Color(0xff66abbe),
                    height: 200.0,
                    thickness: 2.0))
          ]),
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
        ])));
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    print("heelo");
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Homepage(),
      ),
    );
  }
}

class BeaconInteraction extends StatefulWidget with WidgetsBindingObserver {
  @override
  BeaconInteractionState createState() => BeaconInteractionState();
}

class BeaconInteractionState extends State<BeaconInteraction> with WidgetsBindingObserver {
  final StreamController<BluetoothState> streamController = StreamController();
  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];
  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;
  final MethodChannel platform = MethodChannel('crossingthestreams.io/resourceResolver');

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    listeningState();

    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
              },
            )
          ],
        ),
      );
    });
    selectNotificationSubject.stream.listen((String payload) async {
      print("hello");
    });
  }
  
  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '<Programming>2020', 'You have been checked in', platformChannelSpecifics,
        payload: 'item x');
  }

  listeningState() async {
    print('Listening to bluetooth state');
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      print('BluetoothState = $state');
      streamController.add(state);

      switch (state) {
        case BluetoothState.stateOn:
          initScanBeacon();
          break;
        case BluetoothState.stateOff:
          await pauseScanBeacon();
          await checkAllRequirements();
          if (!this.bluetoothEnabled) {
            if (Platform.isAndroid) {
              try {
                await flutterBeacon.openBluetoothSettings;
              } on PlatformException catch (e) {
                print(e);
              }
            }
          }
          break;
      }
    });
  }

  checkAllRequirements() async {
    final bluetoothState = await flutterBeacon.bluetoothState;
    final bluetoothEnabled = bluetoothState == BluetoothState.stateOn;
    final authorizationStatus = await flutterBeacon.authorizationStatus;
    final authorizationStatusOk =
        authorizationStatus == AuthorizationStatus.allowed ||
            authorizationStatus == AuthorizationStatus.always;
    final locationServiceEnabled =
        await flutterBeacon.checkLocationServicesIfEnabled;

    setState(() {
      this.authorizationStatusOk = authorizationStatusOk;
      this.locationServiceEnabled = locationServiceEnabled;
      this.bluetoothEnabled = bluetoothEnabled;
    });
  }

  initScanBeacon() async {
    await flutterBeacon.initializeScanning;
    await checkAllRequirements();
    if (!authorizationStatusOk ||
        !locationServiceEnabled ||
        !bluetoothEnabled) {
      print('RETURNED, authorizationStatusOk=$authorizationStatusOk, '
          'locationServiceEnabled=$locationServiceEnabled, '
          'bluetoothEnabled=$bluetoothEnabled');
      return;
    }
    final regions = <Region>[
      Region(
        identifier: 'ibeacon',
        proximityUUID: '6460fa75-64ba-4131-82a7-89748fea68d0',
      ),
    ];

    if (_streamRanging != null) {
      if (_streamRanging.isPaused) {
        _streamRanging.resume();
        return;
      }
    }

    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      print(result);
      if (result != null && mounted) {
        setState(() {
          _regionBeacons[result.region] = result.beacons;
          _beacons.clear();
          _regionBeacons.values.forEach((list) {
            _beacons.addAll(list);
          });
          _beacons.sort(_compareParameters);
        });
      }
    });
  }

  pauseScanBeacon() async {
    _streamRanging?.pause();
    if (_beacons.isNotEmpty) {
      setState(() {
        _beacons.clear();
      });
    }
  }

  int _compareParameters(Beacon a, Beacon b) {
    int compare = a.proximityUUID.compareTo(b.proximityUUID);

    if (compare == 0) {
      compare = a.major.compareTo(b.major);
    }

    if (compare == 0) {
      compare = a.minor.compareTo(b.minor);
    }

    return compare;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null && _streamBluetooth.isPaused) {
        _streamBluetooth.resume();
      }
      await checkAllRequirements();
      if (authorizationStatusOk && locationServiceEnabled && bluetoothEnabled) {
        await initScanBeacon();
      } else {
        await pauseScanBeacon();
        await checkAllRequirements();
      }
    } else if (state == AppLifecycleState.paused) {
      _streamBluetooth?.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    streamController?.close();
    _streamRanging?.cancel();
    _streamBluetooth?.cancel();
    flutterBeacon.close;
    super.dispose();
  }

  void navigateToCheckedIn() {
   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SelectedUser()));
  }

  static var rang = new Random();
  int rand = rang.nextInt(2);
  bool displayNotChecked=true;
  bool sendNotification = true;
  @override
  Widget build(BuildContext context) {
    if(displayNotChecked && (_beacons == null || _beacons.isEmpty)){
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios,
                  color: const Color(0xff66abbe)),
              onPressed: () => Navigator.pop(context),
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

        body: NotCheckedIn());

    }

    displayNotChecked=false;

    if(sendNotification)
      _showNotification();
    sendNotification= false;

    if(rand == 1)
          return SelectedUser();
        else
          return NotSelectedUser();
  }
}