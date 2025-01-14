import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [RegExp('features/*.*.feature')]
    //..features = [Glob(r"./features/purchase_ticket.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..hooks = []
    ..stepDefinitions = []
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";
    //..tagExpression = "@smoke"; // uncomment to see an example of running scenarios based on tag expressions
  return GherkinRunner().execute(config);
}