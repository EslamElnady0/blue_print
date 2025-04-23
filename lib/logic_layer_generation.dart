import 'dart:io';
import 'package:path/path.dart' as path;

import 'features_classes_content.dart';

void createAllLogicLayerFiles({
  required String logicPath,
  required String featureName,
}) {
  final cubitPath = path.join(logicPath, '${featureName}_cubit');
  print('Creating feature layer: $cubitPath');
  Directory(cubitPath).createSync(recursive: true);
  final cubitFilePath = path.join(cubitPath, '${featureName}_cubit.dart');
  final stateFilePath = path.join(cubitPath, '${featureName}_state.dart');
  print('Creating file: $cubitFilePath');
  File(cubitFilePath).writeAsStringSync(cubitContent(featureName));
  print('Creating file: $stateFilePath');
  File(stateFilePath).writeAsStringSync(stateContent(featureName));
}
