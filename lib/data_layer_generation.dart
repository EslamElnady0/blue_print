import 'dart:io';
import 'package:blue_print/features_classes_content.dart';
import 'package:blue_print/folders_structure.dart';
import 'package:path/path.dart' as path;

void createRepoFiles({required String dataPath, required String featureName}) {
  final repoPath = path.join(dataPath, 'repos');
  print('Creating feature layer: $repoPath');
  Directory(repoPath).createSync(recursive: true);
  final repoFilePath = path.join(
    repoPath,
    '${featureName}_${reposFiles[0]}.dart',
  );
  print('Creating file: $repoFilePath');
  File(repoFilePath).writeAsStringSync(repoContent(featureName));
}

void createDataSourcesFiles({
  required String dataPath,
  required String featureName,
}) {
  for (var folder in dataFolders) {
    final folderPath = path.join(dataPath, folder);
    print('Creating feature layer: $folderPath');
    Directory(folderPath).createSync(recursive: true);
  }
  final dataSourcesPath = path.join(dataPath, 'data sources');
  for (var i = 0; i < dataSourcesFiles.length; i++) {
    final fileName = dataSourcesFiles[i];
    final filePath = path.join(
      dataSourcesPath,
      '${featureName}_$fileName.dart',
    );
    print('Creating file: $filePath');
    File(filePath).writeAsStringSync(
      i == 1
          ? remoteDataSourceContent(featureName)
          : localDataSourceContent(featureName),
    );
  }
}

createAllDataLayerFiles({
  required String dataPath,
  required String featureName,
}) {
  createDataSourcesFiles(dataPath: dataPath, featureName: featureName);
  createRepoFiles(dataPath: dataPath, featureName: featureName);
}
