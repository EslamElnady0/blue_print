import 'package:blueprint_cli/create_files_helper.dart';

String remoteDataSourceContent(String featureName) => '''
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/api_constants.dart';
part '${featureName}_remote_data_source.g.dart';

//if this file is created for the first time or modified
//run the command:
//?=> dart run build_runner build --delete-conflicting-outputs
//to generate the .g.dart file
@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ${featureName.toPascalCase()}RemoteDataSource {
  factory ${featureName.toPascalCase()}RemoteDataSource(Dio dio,
      {String baseUrl, ParseErrorLogger? errorLogger}) = _${featureName.toPascalCase()}RemoteDataSource;
}
''';
String localDataSourceContent(String featureName) => '''
abstract class ${featureName.toPascalCase()}LocalDataSource {}
''';

String repoContent(String featureName) => '''
import '../data sources/${featureName}_local_data_source.dart';
import '../data sources/${featureName}_remote_data_source.dart';

class ${featureName.toPascalCase()}Repo {
  final ${featureName.toPascalCase()}RemoteDataSource remoteDataSource;
  final ${featureName.toPascalCase()}LocalDataSource localDataSource;

  ${featureName.toPascalCase()}Repo({
    required this.remoteDataSource,
    required this.localDataSource,
  });

}
''';
String cubitContent(String featureName) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/${featureName}_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '${featureName}_state.dart';
part '${featureName}_cubit.freezed.dart';
class ${featureName.toPascalCase()}Cubit extends Cubit<${featureName.toPascalCase()}State> {
  final ${featureName.toPascalCase()}Repo _repo;
  ${featureName.toPascalCase()}Cubit(this._repo) : super(const ${featureName.toPascalCase()}State.initial());
}
''';

String stateContent(String featureName) => '''
part of '${featureName}_cubit.dart';
@freezed
class ${featureName.toPascalCase()}State<T> with _\$${featureName.toPascalCase()}State {
  const factory ${featureName.toPascalCase()}State.initial() = _Initial;
  const factory ${featureName.toPascalCase()}State.${featureName.toCamelCase()}Loading() = ${featureName.toPascalCase()}Loading;
  const factory ${featureName.toPascalCase()}State.${featureName.toCamelCase()}Success(T data) = ${featureName.toPascalCase()}Success<T>;
  const factory ${featureName.toPascalCase()}State.${featureName.toCamelCase()}Failure(String error) = ${featureName.toPascalCase()}Failure;
}
''';
String viewContent(String featureName) => '''
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_scaffold.dart';

class ${featureName.toPascalCase()}View extends StatelessWidget {
  static const String routeName = '/$featureName';
  const ${featureName.toPascalCase()}View({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: Column(),
    );
  }
}
''';
