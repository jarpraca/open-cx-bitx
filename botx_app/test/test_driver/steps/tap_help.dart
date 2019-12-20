import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';


class HelpGiven extends GivenWithWorld<FlutterWorld> {
    HelpGiven() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"Given a user that has the app");

  @override
  Future<void> executeStep() async {
    final help = find.byType("FlatButton");
    await FlutterDriverUtils.isPresent(help, world.driver);
  }
}

class HelpWhen extends WhenWithWorld<FlutterWorld> {
  HelpWhen() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"When the user wants to know some information about the check-in");

  @override
  Future<void> executeStep() async {
    final help = find.byType("FlatButton");
    await FlutterDriverUtils.tap(world.driver, help, timeout: timeout);
    final text = find.text("Your check-in");
    await FlutterDriverUtils.isPresent(text, world.driver);
  }
}

class HelpThen extends ThenWithWorld<FlutterWorld> {
  HelpThen() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"Then the user can see that information in the help section of the app");

  @override
  Future<void> executeStep() async {
    final text = find.text("Your check-in");
    await FlutterDriverUtils.isPresent(text, world.driver);
  }
}