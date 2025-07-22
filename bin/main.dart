import 'dart:io';
import 'package:args/args.dart';
import 'package:blueprint_cli/core_classes_content.dart';
import 'package:blueprint_cli/create_files_helper.dart';
import 'package:blueprint_cli/data_layer_generation.dart';
import 'package:blueprint_cli/dependancies.dart';
import 'package:blueprint_cli/folders_structure.dart';
import 'package:blueprint_cli/logic_layer_generation.dart';
import 'package:blueprint_cli/ui_layer_generation.dart';

import 'package:path/path.dart' as path;

void main(List<String> arguments) {
  final parser = ArgParser();
  parser
      .addCommand('create-project')
      .addOption('name', abbr: 'n', help: 'Project name', mandatory: true);
  parser
      .addCommand('add-feature')
      .addOption('name', abbr: 'n', help: 'Feature name', mandatory: true);
  parser
      .addCommand('create-cubit')
      .addOption('feature', abbr: 'f', help: 'Feature name', mandatory: true)
      .addOption('name', abbr: 'n', help: 'Cubit name', mandatory: true);

  final results = parser.parse(arguments);

  if (results.command == null) {
    print('Usage: blue_print <command>');
    print('Commands: create-project, add-feature, create-cubit');
    exit(1);
  }

  if (results.command!.name == 'create-project') {
    createProject(results.command!['name'] as String);
  } else if (results.command!.name == 'add-feature') {
    addFeature(results.command!['name'] as String);
  } else if (results.command!.name == 'create-cubit') {
    createCubit(
      results.command!['feature'] as String,
      results.command!['name'] as String,
    );
  }
}

void createProject(String projectName) {
  checkIfFlutterExistsIfSoCreate(projectName);

  // Define and validate project path
  final projectPath = path.join(Directory.current.path, projectName);
  print('Project path: $projectPath');

  final libPath = path.join(projectPath, 'lib');
  if (!Directory(libPath).existsSync()) {
    print('Error: lib directory not found at $libPath');
    exit(1);
  }
  //------------------------------------------------------------------------
  //create core structure
  final corePath = path.join(libPath, 'core');
  print('Creating core directory: $corePath');
  createCoreStructure(corePath);
  //------------------------------------------------------------------------
  // Create all files in core's sub folders

  createAllFilesInCore(corePath: corePath);
  //------------------------------------------------------------------------
  // Create empty features folder
  final featuresPath = path.join(libPath, 'features');
  print('Creating features directory: $featuresPath');
  try {
    Directory(featuresPath).createSync(recursive: true);
  } catch (e) {
    print('Error creating features directory: $e');
    exit(1);
  }
  //------------------------------------------------------------------------
  // Create main.dart file
  final mainPath = path.join(libPath, 'main.dart');
  print('Creating main file: $mainPath');
  final pascalCaseName = projectName.toPascalCase();
  File(mainPath).writeAsStringSync(mainFileContent(pascalCaseName));
  //------------------------------------------------------------------------
  // Add dependencies to pubspec.yaml
  addDependenciesToPubspec(projectPath, projectName);
  print('Dependencies fetched for $projectName.');
}

void addFeature(String featureName) {
  final featurePath = path.join(
    Directory.current.path,
    'lib',
    'features',
    featureName,
  );

  // Feature structure
  for (var folder in featureFolders) {
    final layerPath = path.join(featurePath, folder);
    print('Creating feature layer: $layerPath');
    Directory(layerPath).createSync(recursive: true);
  }
  // Create data layer files
  createAllLayersFiles(featurePath: featurePath, featureName: featureName);
  print(
    'Feature $featureName added with data, domain, and presentation layers.',
  );
}

void createCubit(String featureName, String cubitName) {
  final featurePath = path.join(
    Directory.current.path,
    'lib',
    'features',
    featureName,
  );

  if (!Directory(featurePath).existsSync()) {
    print('Error: Feature $featureName not found at $featurePath');
    exit(1);
  }

  final logicPath = path.join(featurePath, 'logic');
  createCubitFiles(logicPath: logicPath, cubitName: cubitName);
  print(
    'Cubit $cubitName created in feature $featureName.',
  );
}

void createAllLayersFiles({
  required String featurePath,
  required String featureName,
}) {
  final dataPath = path.join(featurePath, 'data');
  final logicPath = path.join(featurePath, 'logic');
  final uiPath = path.join(featurePath, 'ui');
  createAllDataLayerFiles(dataPath: dataPath, featureName: featureName);
  createAllLogicLayerFiles(logicPath: logicPath, featureName: featureName);
  createAllUiLayerFiles(uiPath: uiPath, featureName: featureName);
}

void createAllFilesInCore({required String corePath}) {
  final networkPath = path.join(corePath, 'network');
  final helperPath = path.join(corePath, 'helpers');
  final themePath = path.join(corePath, 'themes');
  final routesPath = path.join(corePath, 'routes');
  final widgetsPath = path.join(corePath, 'widgets');
  final diPath = path.join(corePath, 'dependency injection');

  createFilesWithContent(
    folderPath: networkPath,
    files: networkFiles,
    filesContent: networkFilesContent,
  );
  createFilesWithContent(
    folderPath: helperPath,
    files: helpersFiles,
    filesContent: helpersFilesContent,
  );
  createFilesWithContent(
    folderPath: routesPath,
    files: routesFiles,
    filesContent: routesFilesContent,
  );
  createFilesWithContent(
    folderPath: diPath,
    files: diFiles,
    filesContent: diFilesContent,
  );
  createFilesWithContent(
    folderPath: themePath,
    files: themeFiles,
    filesContent: themeFilesContent,
  );
  createFilesWithContent(
    folderPath: widgetsPath,
    files: widgetsFiles,
    filesContent: widgetsFilesContent,
  );
}

/// Add dependencies to pubspec.yaml and run flutter pub get then runs build_runner to generate files
void addDependenciesToPubspec(String projectPath, String projectName) {
  //
  for (var dep in dependencies) {
    print('Adding dependency: $dep');
    final result = Process.runSync(
      'dart',
      ['pub', 'add', dep == "freezed_annotation" ? "$dep:^2.4.4" : dep],
      workingDirectory: projectPath,
      runInShell: true,
    );
    if (result.exitCode != 0) {
      print('Error adding $dep: ${result.stderr}');
      exit(1);
    }
  }
  // Add dev dependencies
  for (var devDep in devDependencies) {
    print('Adding dev dependency: $devDep');
    final result = Process.runSync(
      'dart',
      [
        'pub',
        'add',
        devDep == "freezed" ? 'dev:$devDep:^2.5.7' : 'dev:$devDep',
      ],
      workingDirectory: projectPath,
      runInShell: true,
    );
    if (result.exitCode != 0) {
      print('Error adding dev dependency $devDep: ${result.stderr}');
      exit(1);
    }
  }

  // Run flutter pub get to ensure all dependencies are resolved
  print('Running flutter pub get in $projectPath');
  final pubGetResult = Process.runSync(
    'flutter',
    ['pub', 'get'],
    workingDirectory: projectPath,
    runInShell: true,
  );

  if (pubGetResult.exitCode != 0) {
    print('Error running flutter pub get: ${pubGetResult.stderr}');
    exit(1);
  }
  // Run build_runner to generate files
  final buildRunnerResult = Process.runSync(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    workingDirectory: projectPath,
    runInShell: true,
  );
  if (buildRunnerResult.exitCode != 0) {
    print('Error running build_runner: ${buildRunnerResult.stderr}');
    print(
      'build_runner failed. Run `dart run build_runner build` manually after defining models.',
    );
  } else {
    print('build_runner completed for $projectName.');
  }
}
