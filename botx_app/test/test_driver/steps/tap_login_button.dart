import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class TapLoginButton extends WhenWithWorld<FlutterWorld> {
  TapLoginButton() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"The user should be redirected to the beacon interaction screen");

  @override
  Future<void> executeStep() async {
    final signIn = find.text("Sign In");
    await FlutterDriverUtils.tap(world.driver, signIn, timeout: timeout);
    final code = "1234";
    final insert = find.byType("TextField");
    await FlutterDriverUtils.enterText(world.driver, insert, code);
    final submit = find.text("Submit");
    await FlutterDriverUtils.tap(world.driver, submit, timeout: timeout);
    final checkIn = find.text("QR Code Not Available Yet");
    await FlutterDriverUtils.isPresent(checkIn, world.driver);
  }
}