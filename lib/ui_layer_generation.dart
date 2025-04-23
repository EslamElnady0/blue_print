import 'dart:io';

import 'package:path/path.dart' as path;

import 'features_classes_content.dart';

createAllUiLayerFiles({required String uiPath, required String featureName}) {
  final viewsPath = path.join(uiPath, 'views');
  final widgetPath = path.join(uiPath, 'widgets');
  Directory(viewsPath).createSync(recursive: true);
  Directory(widgetPath).createSync(recursive: true);
  final viewFilePath = path.join(viewsPath, '${featureName}_view.dart');
  File(viewFilePath).writeAsStringSync(viewContent(featureName));
}
