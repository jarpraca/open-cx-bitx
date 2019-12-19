import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class TapHelpButton extends WhenWithWorld<FlutterWorld> {
  TapHelpButton() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"The user can see the information in the help section of the app");

  @override
  Future<void> executeStep() async {
    final help = find.byType("FlatButton");
    await FlutterDriverUtils.tap(world.driver, help, timeout: timeout);
    final text = find.text("Your check-in");
    await FlutterDriverUtils.isPresent(text, world.driver);
  }
}