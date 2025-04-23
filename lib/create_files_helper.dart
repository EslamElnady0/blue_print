import 'dart:io';
import 'package:path/path.dart' as path;
import 'folders_structure.dart';

void checkIfFlutterExistsIfSoCreate(String projectName) {
  print('Current working directory: ${Directory.current.path}');

  // Verify flutter command exists
  final flutterCheck = Process.runSync('where', ['flutter'], runInShell: true);
  if (flutterCheck.exitCode != 0 || flutterCheck.stdout.isEmpty) {
    print('Error: flutter command not found in PATH.');
    print(
      'Ensure Flutter SDK is installed and added to PATH (e.g., C:\\flutter\\bin).',
    );
    exit(1);
  }
  print('Flutter command found: ${flutterCheck.stdout}');

  // Run flutter create
  final flutterCreateResult = Process.runSync(
    'flutter',
    ['create', projectName],
    workingDirectory: Directory.current.path,
    runInShell: true, // Ensure shell environment on Windows
  );

  if (flutterCreateResult.exitCode != 0) {
    print('Error running flutter create: ${flutterCreateResult.stderr}');
    exit(1);
  }

  print('Flutter project $projectName created.');
}

void createCoreStructure(String corePath) {
  try {
    Directory(corePath).createSync(recursive: true);
    for (var folder in coreFolders) {
      final folderPath = path.join(corePath, folder);
      print('Creating folder: $folderPath');
      Directory(folderPath).createSync(recursive: true);
    }
  } catch (e) {
    print('Error creating core structure: $e');
    exit(1);
  }
}

void createFilesWithContent({
  required String folderPath,
  required List<String> files,
  required Map<String, String> filesContent,
}) {
  try {
    Directory(folderPath).createSync(recursive: true);
    for (var file in files) {
      final filePath = path.join(folderPath, '$file.dart');
      print('Creating file: $filePath');
      File(filePath).writeAsStringSync(filesContent[file]!);
    }
  } catch (e) {
    print('Error creating network structure: $e');
    exit(1);
  }
}

extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
  String toPascalCase() {
    return split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join('');
  }

  String toCamelCase() {
    if (isEmpty) return this;

    // Split by underscore, filter out empty parts, and convert to camel case
    final parts = split('_').where((part) => part.isNotEmpty).toList();

    if (parts.isEmpty) return '';

    // Convert first part to lowercase, others to title case
    return parts
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final word = entry.value;
          if (word.isEmpty) return '';
          return index == 0
              ? word.toLowerCase()
              : word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join('');
  }
}
