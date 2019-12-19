import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class TapBuyTicketButton extends WhenWithWorld<FlutterWorld> {
  TapBuyTicketButton() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"The user should be redirected to the beacon interaction screen");

  @override
  Future<void> executeStep() async {
    final buy = find.text("Don't own a ticket?\n    Buy one now");
    await FlutterDriverUtils.tap(world.driver, buy, timeout: timeout);
    await FlutterDriverUtils.isAbsent(world.driver, buy);
  }
}