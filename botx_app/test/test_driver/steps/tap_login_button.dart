import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';


class LoginGiven extends GivenWithWorld<FlutterWorld> {
  LoginGiven() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"Given a user with a ticket");

  @override
  Future<void> executeStep() async {
    final signIn = find.text("Sign In");
    await FlutterDriverUtils.tap(world.driver, signIn, timeout: timeout);
    final loginScreen = find.text("Insert your code");
    await FlutterDriverUtils.isPresent(loginScreen, world.driver);
  }
}

class LoginWhen extends WhenWithWorld<FlutterWorld> {
  LoginWhen() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"When the user tries to access the app and inserts the code");

  @override
  Future<void> executeStep() async {

    final code = "1234";
    final insert = find.byType("TextField");
    await FlutterDriverUtils.enterText(world.driver, insert, code);
    final submit = find.text("Submit");
    await FlutterDriverUtils.tap(world.driver, submit, timeout: timeout);
  }
}

class LoginThen extends ThenWithWorld<FlutterWorld> {
  LoginThen() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"Then the user should be redirected to the beacon interaction screen");

  @override
  Future<void> executeStep() async {
    final checkIn = find.text("QR Code Not Available Yet");
    await FlutterDriverUtils.isPresent(checkIn, world.driver);
  }
}



