import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
  title: Row(
        children: <Widget>[Text('<programming> 2020',
      style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
          shadows: <Shadow>[
            Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: const Color(0xff66abbe)
            ),
            Shadow(
                offset: Offset(-1.0, -1.0),
                blurRadius: 3.0,
                color: const Color(0xff66abbe)
            )])),
          Image( image: AssetImage('assets/images/logo.png')
  )])),
  body: ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 130,
        ),

        Container(
          height: 80,
          child:
          const Center(
              child: Text('Insert your code',
                  style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)
                        ),
                        Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)
                        )]))),
        ),

        Container(
            height: 80,
            child: new TextField(
                style: new TextStyle(color: const Color(0xaaffffff)),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xff66abbe)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xff66abbe)),
                  ),
                ),
                )
        ),
        SizedBox(
            width: 40.0,
            height: 80.0,
            child: MaterialButton(
                child: Text('Submit', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          ),
                          Shadow(
                              offset: Offset(-1.0, -1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          )])),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BluetoothInteraction()),
                  );
                },
                shape: RoundedRectangleBorder(side: BorderSide(
                    color: const Color(0xff66abbe), width: 1.0,style: BorderStyle.solid ),  borderRadius: BorderRadius.circular(40))
            )
        ),

        Container(
          alignment: Alignment.center,
          height:100.0,
          child: new MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecoverCode()),
              );
            },
            child: Text("Forgot your password?", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: const Color(0xaaffffff),
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: const Color(0xff66abbe)
                      ),
                      Shadow(
                          offset: Offset(-1.0, -1.0),
                          blurRadius: 3.0,
                          color: const Color(0xff66abbe)
                      )])),
          ),
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: Column(
              children: <Widget> [
                Text("Powered by", style: TextStyle(fontSize: 16, color: const Color(0xaaffffff),
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: const Color(0xff66abbe)
                      ),
                      Shadow(
                          offset: Offset(-1.0, -1.0),
                          blurRadius: 3.0,
                          color: const Color(0xff66abbe)
                      )])),
                Image( image: AssetImage('assets/images/bitX.png'), height:50),
              ]),
        ),

      ]
  )
  );
}}

class RecoverCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Row(
                children: <Widget>[Text('<programming> 2020',
                    style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          ),
                          Shadow(
                              offset: Offset(-1.0, -1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          )])),
                  Image( image: AssetImage('assets/images/logo.png')
                  )])),
        body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Container(
                height: 130,
              ),

              Container(
                height: 80,
                child:
                const Center(
                    child: Text('Insert your email',
                        style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 3.0,
                                  color: const Color(0xff66abbe)
                              ),
                              Shadow(
                                  offset: Offset(-1.0, -1.0),
                                  blurRadius: 3.0,
                                  color: const Color(0xff66abbe)
                              )]))),
              ),

              Container(
                  height: 80,
                  child: new TextField(
                    style: new TextStyle(color: const Color(0xaaffffff)),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xff66abbe)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xff66abbe)),
                      ),
                    ),
                  )
              ),
              SizedBox(
                  width: 40.0,
                  height: 80.0,
                  child: MaterialButton(
                      child: Text('Submit', textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: const Color(0xff66abbe)
                                ),
                                Shadow(
                                    offset: Offset(-1.0, -1.0),
                                    blurRadius: 3.0,
                                    color: const Color(0xff66abbe)
                                )])),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectedUser()),
                        );
                      },
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: const Color(0xff66abbe), width: 1.0,style: BorderStyle.solid ),  borderRadius: BorderRadius.circular(40))
                  )
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                    children: <Widget> [
                      Text("Powered by", style: TextStyle(fontSize: 16, color: const Color(0xaaffffff),
                          shadows: <Shadow>[
                            Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: const Color(0xff66abbe)
                            ),
                            Shadow(
                                offset: Offset(-1.0, -1.0),
                                blurRadius: 3.0,
                                color: const Color(0xff66abbe)
                            )])),
                      Image( image: AssetImage('assets/images/bitX.png'), height:50),
                    ]),
              ),

            ]
        )
    );
  }}

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Row(
                children: <Widget>[Text('<programming> 2020',
                    style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          ),
                          Shadow(
                              offset: Offset(-1.0, -1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          )])),
                  Image( image: AssetImage('assets/images/logo.png')
                  )])),
        body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Container(
                height: 40,
              ),
              Image( image: AssetImage('assets/images/help_button.png'), height:100),

        Row(
          children: <Widget>[
          Expanded(
          flex: 10,
          child: Divider(color: const Color(0xff66abbe), height:20.0, thickness:2.0))]),
        Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          child:
          const Center(
            child: Text('Your check-in is done automatically as soon as we detect that you have entered the premisses, for that to work we need you to turn on your Bluetooth. If you are one of the lucky selected, our robot, BotX, will deliver your welcome package to you itself ',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 24, color: const Color(0xaaffffff),
                shadows: <Shadow>[
                  Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 7.0,
                      color: const Color(0xff66abbe)
                  ),
                  Shadow(
                      offset: Offset(-1.0, -1.0),
                      blurRadius: 7.0,
                      color: const Color(0xff66abbe)
                  )]))),
        ),
        Row(
            children: <Widget>[
              Expanded(
                  flex: 10,
                  child: Divider(color: const Color(0xff66abbe), height:20.0, thickness:2.0))]),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
              children: <Widget> [
                Text("Powered by", style: TextStyle(fontSize: 16, color: const Color(0xaaffffff),
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: const Color(0xff66abbe)
                      ),
                      Shadow(
                          offset: Offset(-1.0, -1.0),
                          blurRadius: 3.0,
                          color: const Color(0xff66abbe)
                      )])),
                Image( image: AssetImage('assets/images/bitX.png'), height:50),
              ]),
        ),

      ]
  )
    );
  }}

class NotCheckedIn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(
    padding: const EdgeInsets.all(8),
    children: <Widget>[
      Container(
        height: 40),
      Container(
        height: 150,
        child: const Center(child: Image( image: AssetImage('assets/images/logo.png'))),
      ),
      Container(
      height: 120,
      child:
      const Center(
      child: Text('QR Code Not Available Yet',
      style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
      shadows: <Shadow>[
      Shadow(
      offset: Offset(1.0, 1.0),
      blurRadius: 3.0,
      color: const Color(0xff66abbe)
      ),
      Shadow(
      offset: Offset(-1.0, -1.0),
      blurRadius: 3.0,
      color: const Color(0xff66abbe)
      )]))),
      ),
      SizedBox(
          width: 40.0,
          height: 80.0,
          child: MaterialButton(
              child: Text('Check-In: Not Completed', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)
                        ),
                        Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)
                        )])),
              onPressed:null,
              shape: RoundedRectangleBorder(side: BorderSide(
                  color: const Color(0xff66abbe), width: 1.0,style: BorderStyle.solid ),  borderRadius: BorderRadius.circular(40))
          )
      ),
      Container(
        height: 150,
          alignment: Alignment.center,
          child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Help()),
                );},
              padding: EdgeInsets.all(0.0),
              child: Image.asset('assets/images/help_button.png'))),
      Align(
        alignment: Alignment.bottomRight,
        child: Column(
            children: <Widget> [
              Text("Powered by", style: TextStyle(fontSize: 16, color: const Color(0xaaffffff),
                  shadows: <Shadow>[
                    Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: const Color(0xff66abbe)
                    ),
                    Shadow(
                        offset: Offset(-1.0, -1.0),
                        blurRadius: 3.0,
                        color: const Color(0xff66abbe)
                    )])),
              Image( image: AssetImage('assets/images/bitX.png'), height:50),
            ]),
      ),


    ]);
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 40,
        ),
        Container(
          height: 150,
          child: const Center(child: Image( image: AssetImage('assets/images/logo.png'))),
        ),
        Container(
          height: 80,
          child:
          const Center(
              child: Text('<programming> 2020',
                  style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)
                        ),
                        Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)
                        )]))),
        ),
        SizedBox(
            width: 40.0,
            height: 80.0,
            child: MaterialButton(
                child: Text('Sign In', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          ),
                          Shadow(
                              offset: Offset(-1.0, -1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          )])),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                shape: RoundedRectangleBorder(side: BorderSide(
                    color: const Color(0xff66abbe), width: 1.0,style: BorderStyle.solid ),  borderRadius: BorderRadius.circular(40))
            )
        ),

        Container(
          alignment: Alignment.center,
          height:100.0,
          child: new RaisedButton(
            onPressed: null,
            child: Text("Don't own a ticket?\nBuy one now", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: const Color(0xaaffffff),
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: const Color(0xff66abbe)
                      ),
                      Shadow(
                          offset: Offset(-1.0, -1.0),
                          blurRadius: 3.0,
                          color: const Color(0xff66abbe)
                      )])),
          ),
        ),

        Container(
            alignment: Alignment.center,
            child: FlatButton(
                onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Help()),
                    );},
                padding: EdgeInsets.all(0.0),
                child: Image.asset('assets/images/help_button.png'))),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
              children: <Widget> [
                Text("Powered by", style: TextStyle(fontSize: 16, color: const Color(0xaaffffff),
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: const Color(0xff66abbe)
                      ),
                      Shadow(
                          offset: Offset(-1.0, -1.0),
                          blurRadius: 3.0,
                          color: const Color(0xff66abbe)
                      )])),
                Image( image: AssetImage('assets/images/bitX.png'), height:50),
              ]),
        ),

      ]
    );
}}

class SelectedUser extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
              Container(
              height:40),
            Container(
              height:50,
              child:
              const Center(
                  child: Text('You have been selected!',
                      style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                          shadows: <Shadow>[
                            Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: const Color(0xff66abbe)
                            ),
                            Shadow(
                                offset: Offset(-1.0, -1.0),
                                blurRadius: 3.0,
                                color: const Color(0xff66abbe)
                            )]))),
            ),
            Container(
              height: 100,
              child: const Center(child: Image( image: AssetImage('assets/images/botX.png'))),
            ),
            Container(
              height: 50,
              child:
              const Center(
                  child: Text('is on the way!',
                      style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                        shadows: <Shadow>[
                        Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: const Color(0xff66abbe)
                        ),
                        Shadow(
                        offset: Offset(-1.0, -1.0),
                        blurRadius: 3.0,
                        color: const Color(0xff66abbe)
                        )]),
            ))),
            Row(
                children: <Widget>[
                  Expanded(
                      flex: 10,
                      child: Divider(color: const Color(0xff66abbe), height:40.0, thickness:2.0))]),
            Container(
              height: 230,
              child: const Center(child: Image( image: AssetImage('assets/images/qrcode.png'))),
            ),
            Row(
                children: <Widget>[
                  Expanded(
                      flex: 10,
                      child: Divider(color: const Color(0xff66abbe), height:40.0, thickness:2.0))]),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                  children: <Widget> [
                    Text("Powered by", style: TextStyle(fontSize: 16, color: const Color(0xaaffffff),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          ),
                          Shadow(
                              offset: Offset(-1.0, -1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          )])),
                    Image( image: AssetImage('assets/images/bitX.png'), height:50),
                  ]),
            ),

          ]
        );
  }}

class NotSelectedUser extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
        title: Row(
        children: <Widget>[Text('<programming> 2020',
        style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
          shadows: <Shadow>[
          Shadow(
          offset: Offset(1.0, 1.0),
          blurRadius: 3.0,
          color: const Color(0xff66abbe)
          ),
          Shadow(
          offset: Offset(-1.0, -1.0),
          blurRadius: 3.0,
          color: const Color(0xff66abbe)
          )])),
        Image( image: AssetImage('assets/images/logo.png')
        )])),
        body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
            Container(
            height: 40),
          Container(
            height: 100,
            child:
            const Center(
                child: Text("Sorry!\nYou haven't been selected!", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          ),
                          Shadow(
                              offset: Offset(-1.0, -1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          )]))),
          ),
          Row(
              children: <Widget>[
                Expanded(
                    flex: 10,
                    child: Divider(color: const Color(0xff66abbe), height:40.0, thickness:2.0))]),
          Container(
            height: 200,
            child: const Center(child: Image( image: AssetImage('assets/images/qrcode.png'))),
          ),
          Row(
              children: <Widget>[
                Expanded(
                    flex: 10,
                    child: Divider(color: const Color(0xff66abbe), height:40.0, thickness:2.0))]),
          Container(
              alignment: Alignment.center,
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Help()),
                    );},
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset('assets/images/help_button.png'))),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
                children: <Widget> [
                  Text("Powered by", style: TextStyle(fontSize: 16, color: const Color(0xaaffffff),
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)
                        ),
                        Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)
                        )])),
                  Image( image: AssetImage('assets/images/bitX.png'), height:50),
                ]),
          ),
        ]
    ));
  }}

class TurnOnBluetooth extends StatelessWidget{
  final StreamController<BluetoothState> streamController = StreamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
        title: Row(
        children: <Widget>[Text('<programming> 2020',
        style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
    shadows: <Shadow>[
    Shadow(
    offset: Offset(1.0, 1.0),
    blurRadius: 3.0,
    color: const Color(0xff66abbe)
    ),
    Shadow(
    offset: Offset(-1.0, -1.0),
    blurRadius: 3.0,
    color: const Color(0xff66abbe)
    )])),
    Image( image: AssetImage('assets/images/logo.png')
    )])),
    body:ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
              height: 100),
          Row(
              children: <Widget>[
                Expanded(
                    flex: 10,
                    child: Divider(color: const Color(0xff66abbe), height:40.0, thickness:2.0))]),
          Container(
            height: 100,
            child:
            const Center(
                child: Text("Please turn on your bluetooth", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          ),
                          Shadow(
                              offset: Offset(-1.0, -1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          )]))),
          ),

        IconButton(
        icon: Icon(Icons.bluetooth, size: 100),
            onPressed: () async {
            if (Platform.isAndroid) {
            try {
            await flutterBeacon.openBluetoothSettings;
            } on PlatformException catch (e) {
            print(e);
            }}},
          color: const Color(0xff66abbe),
        ),
          Row(
              children: <Widget>[
                Expanded(
                    flex: 10,
                    child: Divider(color: const Color(0xff66abbe), height:200.0, thickness:2.0))]),
          Container(
              alignment: Alignment.center,
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Help()),
                    );},
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset('assets/images/help_button.png'))),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
                children: <Widget> [
                  Text("Powered by", style: TextStyle(fontSize: 16, color: const Color(0xaaffffff),
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)
                        ),
                        Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)
                        )])),
                  Image( image: AssetImage('assets/images/bitX.png'), height:50),
                ]),
          ),
        ]
    ));
  }}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final StreamController<BluetoothState> streamController = StreamController();
  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;
  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();

    listeningState();
  }

  listeningState() async {
    print('Listening to bluetooth state');
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      print('BluetoothState = $state');
      streamController.add(state);
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null && _streamBluetooth.isPaused) {
        _streamBluetooth.resume();
      }
      await checkAllRequirements();
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

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          title: Text(""),
          centerTitle: false,
        ),
        body: Homepage(),
      ),
    );
  }
}

class BluetoothInteraction extends StatefulWidget with WidgetsBindingObserver{
  @override
  BluetoothInteractionState createState() => BluetoothInteractionState();
}

class BluetoothInteractionState extends State<BluetoothInteraction> with WidgetsBindingObserver {
  final StreamController<BluetoothState> streamController = StreamController();
  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;
  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();

    listeningState();
  }

  listeningState() async {
    print('Listening to bluetooth state');
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      print('BluetoothState = $state');
      streamController.add(state);
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null && _streamBluetooth.isPaused) {
        _streamBluetooth.resume();
      }
      await checkAllRequirements();
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

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          title: Text(""),
          centerTitle: false,
        ),
        body:                 StreamBuilder<BluetoothState>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final state = snapshot.data;

              if (state == BluetoothState.stateOn) {
                return BeaconInteraction();
              }

              if (state == BluetoothState.stateOff) {
                return TurnOnBluetooth();
              }

              return TurnOnBluetooth();
            }

            return SizedBox.shrink();
          },
          stream: streamController.stream,
          initialData: BluetoothState.stateUnknown,
        ),
      ),
    );
  }
}
class BeaconInteraction extends StatefulWidget with WidgetsBindingObserver{
  @override
  BeaconInteractionState createState() => BeaconInteractionState();
}

class BeaconInteractionState extends State<BeaconInteraction> with WidgetsBindingObserver{
  final StreamController<BluetoothState> streamController = StreamController();
  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];
  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();

    listeningState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Row(
                children: <Widget>[Text('<programming> 2020',
                    style: TextStyle(fontSize: 22, color: const Color(0xaaffffff),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          ),
                          Shadow(
                              offset: Offset(-1.0, -1.0),
                              blurRadius: 3.0,
                              color: const Color(0xff66abbe)
                          )])),
                  Image( image: AssetImage('assets/images/logo.png')
                  )])),
        body:
       _beacons == null || _beacons.isEmpty
              ? NotCheckedIn()
              : SelectedUser()
      );
  }
}

