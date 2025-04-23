Map<String, String> networkFilesContent = {
  'api_constants': '''
class ApiConstants {
  const ApiConstants._();
  static const String apiBaseUrl = 'https://api.example.com/';
}
class ApiErrors {}
''',

  //-------------------------------------------------------------------------------------------------------------------------
  'api_error_handler': '''
import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handleError(dynamic error) {
    // if (error is DioException) {
    //   switch (error.type) {
    //     case DioExceptionType.connectionTimeout:
    //       return ApiErrorModel(message: "connection timeout, please try again");
    //     case DioExceptionType.sendTimeout:
    //       return ApiErrorModel(message: "");
    //     case DioExceptionType.receiveTimeout:
    //       return ApiErrorModel(message: "timeout, please try again");
    //     case DioExceptionType.badResponse:
    //       return ApiErrorModel.fromJson(error.response?.data);
    //     case DioExceptionType.cancel:
    //       return ApiErrorModel(message: "error cancelled");
    //     case DioExceptionType.connectionError:
    //     case DioExceptionType.badCertificate:
    //       return ApiErrorModel(message: "bad certificate, please try again");
    //     case DioExceptionType.unknown:
    //       return ApiErrorModel(message: "unknown error, please try again");
    //   }
    // } else {
    //   return ApiErrorModel(message: "error, please try again");
    // }

    return ApiErrorModel(message: "error, please try again");
  }
}
''',

  //-------------------------------------------------------------------------------------------------------------------------
  'api_result': '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'api_error_model.dart';
part 'api_result.freezed.dart';
@Freezed()
abstract class ApiResult<T> with _\$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.failure(ApiErrorModel apiErrorModel) = Failure<T>;
}
''',
  //-------------------------------------------------------------------------------------------------------------------------
  'api_error_model': '''
import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
    final String message;
    ApiErrorModel({required this.message});

    factory ApiErrorModel.fromJson(Map<String, dynamic> json) => _\$ApiErrorModelFromJson(json);
}
''',
  //-------------------------------------------------------------------------------------------------------------------------
  'dio_factory': '''
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();
  static Dio? dio;

  static Future<Dio> getDio() async {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      await addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static Future<void> addDioHeaders() async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      // 'Authorization':'Bearer \${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}',
    };
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
      ),
    );
  }
}

''',
};

Map<String, String> themeFilesContent = {
  'app_colors': '''
import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
''',
  //-------------------------------------------------------------------------------------------------------------------------
  'app_text_styles': '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();
    static TextStyle font14BlackRegular = TextStyle(
    fontSize: 14.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.regular,
  );
}
class FontWeightHelper {
  static FontWeight thin = FontWeight.w100;
  static FontWeight extraLight = FontWeight.w200;
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;
}
''',
  //-------------------------------------------------------------------------------------------------------------------------
  'app_theme': '''
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // primaryColor: AppColors.primaryColor,

  );

  static final ThemeData darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // primaryColor: AppColors.primaryColor,
  );
}
''',
};

Map<String, String> helpersFilesContent = {
  'app_assets': '''
class AppAssets {
  const AppAssets._();
}''',
  //-------------------------------------------------------------------------------------------------------------------------
  'constants': '''
class Constants {
  const Constants._();
}
''',
  //-------------------------------------------------------------------------------------------------------------------------
  'extensions': '''
import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension BuildContextExtension<T> on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.of(this).size.width;

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  double get bottomViewPadding => MediaQuery.of(this).viewPadding.bottom;

  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  EdgeInsets get padding => MediaQuery.of(this).padding;

  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ScaffoldMessengerState get scaffoldMassenger => ScaffoldMessenger.of(this);

  Size get screenSize => MediaQuery.of(this).size;

  T? get argument => ModalRoute.of(this)?.settings.arguments as T?;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

''',
  //-------------------------------------------------------------------------------------------------------------------------
  'shared_perf_keys': '''
class SharedPrefKeys {
  const SharedPrefKeys._();
  static const String userToken = 'userToken';
}
''',
  //-------------------------------------------------------------------------------------------------------------------------
  'shared_pref_helper': '''
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  SharedPrefHelper._();

  /// Removes a value from SharedPreferences with given [key].
  static removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : \$key has been removed');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static setData(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper : setData with key : \$key and value : \$value");
    switch (value.runtimeType) {
      case String:
        await sharedPreferences.setString(key, value);
        break;
      case int:
        await sharedPreferences.setInt(key, value);
        break;
      case bool:
        await sharedPreferences.setBool(key, value);
        break;
      case double:
        await sharedPreferences.setDouble(key, value);
        break;
      default:
        return null;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static getBool(String key) async {
    debugPrint('SharedPrefHelper : getBool with key : \$key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  static getDouble(String key) async {
    debugPrint('SharedPrefHelper : getDouble with key : \$key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static getInt(String key) async {
    debugPrint('SharedPrefHelper : getInt with key : \$key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  static getString(String key) async {
    debugPrint('SharedPrefHelper : getString with key : \$key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  // static setSecuredString(String key, String value) async {
  //   const flutterSecureStorage = FlutterSecureStorage();
  //   debugPrint(
  //       "FlutterSecureStorage : setSecuredString with key : \$key and value : \$value");
  //   await flutterSecureStorage.write(key: key, value: value);
  // }

  /// Gets an String value from FlutterSecureStorage with given [key].
  // static getSecuredString(String key) async {
  //   const flutterSecureStorage = FlutterSecureStorage();
  //   debugPrint('FlutterSecureStorage : getSecuredString with key :');
  //   return await flutterSecureStorage.read(key: key) ?? '';
  // }

  /// Removes all keys and values in the FlutterSecureStorage
  // static clearAllSecuredData() async {
  //   debugPrint('FlutterSecureStorage : all data has been cleared');
  //   const flutterSecureStorage = FlutterSecureStorage();
  //   await flutterSecureStorage.deleteAll();
  // }
}
''',
  //-------------------------------------------------------------------------------------------------------------------------
  'spacing': '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox vGap(double height) => SizedBox(
  height: height.h,
);

SizedBox hGap(double width) => SizedBox(
  width: width.w,
);
''',
  //-------------------------------------------------------------------------------------------------------------------------
  'validators_regex': '''
class ValidatorsRegex{
  const ValidatorsRegex._();

  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)\$')
        .hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,}\$")
        .hasMatch(password);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(010|011|012|015)[0-9]{8}\$').hasMatch(phoneNumber);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*?[#?!@\$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }
}

''',
};

Map<String, String> routesFilesContent = {
  'app_router': '''
import 'package:flutter/material.dart';
import '../widgets/custom_scaffold.dart';
class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':       
        return _viewMaterialRoute(
            view: const CustomScaffold(),
        );      
      default:
        return null;
    }
  }

  static MaterialPageRoute<dynamic> _viewMaterialRoute(
      {required Widget view, Object? arguments}) {
    return MaterialPageRoute(
        builder: (context) => view,
        settings: RouteSettings(arguments: arguments));
  }
}
''',
};

Map<String, String> diFilesContent = {
  'get_it': '''
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../network/dio_factory.dart';
final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  Dio dio = await DioFactory.getDio();
  // Register your services and repositories here

}
''',
};
Map<String, String> widgetsFilesContent = {
  'custom_scaffold': '''
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? drawer;
  final bool extendBody;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool? resizeToAvoidBottomInset;
  final Key? scaffoldKey;
  const CustomScaffold(
      {super.key,
      this.appBar,
      this.body,
      this.bottomNavigationBar,
      this.bottomSheet,
      this.drawer,
      this.extendBody = false,
      this.floatingActionButton,
      this.floatingActionButtonAnimator,
      this.floatingActionButtonLocation,
      this.resizeToAvoidBottomInset,
      this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBar,
      key: scaffoldKey,
      body:body,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      drawer: drawer,
      extendBody: extendBody,
      floatingActionButton: floatingActionButton,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    ));
  }
}
''',
};

//-------------------------------------------------------------------------------------------------------------------------

String mainFileContent(String pascalCaseName) {
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/dependency injection/get_it.dart';
import 'core/routes/app_router.dart';
import 'core/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  await ScreenUtil.ensureScreenSize();

  runApp(const ${pascalCaseName}App());
}

class ${pascalCaseName}App extends StatelessWidget {
  const ${pascalCaseName}App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        title: '$pascalCaseName',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
''';
}
