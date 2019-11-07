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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
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
          title: const Text('Flutter Beacon'),
          centerTitle: false,
          actions: <Widget>[
            if (!authorizationStatusOk)
              IconButton(
                  icon: Icon(Icons.portable_wifi_off),
                  color: Colors.red,
                  onPressed: () async {
                    await flutterBeacon.requestAuthorization;
                  }),
            if (!locationServiceEnabled)
              IconButton(
                  icon: Icon(Icons.location_off),
                  color: Colors.red,
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      await flutterBeacon.openLocationSettings;
                    } else if (Platform.isIOS) {

                    }
                  }),
            StreamBuilder<BluetoothState>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final state = snapshot.data;

                  if (state == BluetoothState.stateOn) {
                    return IconButton(
                      icon: Icon(Icons.bluetooth_connected),
                      onPressed: () {},
                      color: Colors.lightBlueAccent,
                    );
                  }

                  if (state == BluetoothState.stateOff) {
                    return IconButton(
                      icon: Icon(Icons.bluetooth),
                      onPressed: () async {
                        if (Platform.isAndroid) {
                          try {
                            await flutterBeacon.openBluetoothSettings;
                          } on PlatformException catch (e) {
                            print(e);
                          }
                        } else if (Platform.isIOS) {

                        }
                      },
                      color: Colors.red,
                    );
                  }

                  return IconButton(
                    icon: Icon(Icons.bluetooth_disabled),
                    onPressed: () {},
                    color: Colors.grey,
                  );
                }

                return SizedBox.shrink();
              },
              stream: streamController.stream,
              initialData: BluetoothState.stateUnknown,
            ),
          ],
        ),
        body: _beacons == null || _beacons.isEmpty
            ? ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 130,
            ),
            Container(
              height: 150,
              child: const Center(child: Image( image: AssetImage('assets/images/logo.png'))),
            ),
            Container(
              height: 50,
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
            new ButtonBar(
              mainAxisSize: MainAxisSize.max, // this will take space as minimum as posible(to center)
              children: <Widget>[
                new RaisedButton(
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
                  onPressed: null,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.horizontal( left: Radius.circular(30.0), right: Radius.circular(30.0)))
                )
              ],
            ),
          new RaisedButton(
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
            Container(
                alignment: Alignment.center,
                child: FlatButton(
                    onPressed: null,
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

          ],
        )
            : ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 50,
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
              height: 150,
              child: const Center(child: Image( image: AssetImage('assets/images/botX.png'))),
            ),
            Container(
              height: 50,
              child:
                const Center(
                    child: Text('is on the way!',
                          style: TextStyle(fontSize: 22, color: const Color(0xff66abbe)))),
            ),
            Container(
              height: 150,
              child: const Center(child: Image( image: AssetImage('assets/images/qrcode.png'))),
            ),
          ],
        )
      ),
    );
  }
}
