import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CodeRecoveryGiven extends GivenWithWorld<FlutterWorld> {
  CodeRecoveryGiven() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"Given a user that has bought a ticket");

  @override
  Future<void> executeStep() async {
    final signIn = find.text("Sign In");
    await FlutterDriverUtils.tap(world.driver, signIn, timeout: timeout);
    final forgot = find.text("Forgot your password?");
    await FlutterDriverUtils.tap(world.driver, forgot, timeout: timeout);
  }
}

class CodeRecoveryWhen extends WhenWithWorld<FlutterWorld> {
  CodeRecoveryWhen() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"When i forget my code");

  @override
  Future<void> executeStep() async {
    final code = "teste@gmail.com";
    final insert = find.byType("TextField");
    await FlutterDriverUtils.enterText(world.driver, insert, code);
    final submit = find.text("Submit");
    await FlutterDriverUtils.tap(world.driver, submit, timeout: timeout);
  }
}

class CodeRecoveryThen extends ThenWithWorld<FlutterWorld> {
  CodeRecoveryThen() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"Then i receive an email with my code");

  @override
  Future<void> executeStep() async {
    final recover = find.text("Recover Password");
    await FlutterDriverUtils.isPresent(recover, world.driver);
  }
}