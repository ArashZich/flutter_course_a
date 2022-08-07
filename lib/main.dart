import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_a/logic/providers/CryptoDataProvider.dart';
import 'package:flutter_course_a/logic/providers/MarketViewProvider.dart';
import 'package:flutter_course_a/logic/providers/ThemeProvider.dart';
import 'package:flutter_course_a/logic/providers/UserDataProvider.dart';
import 'package:flutter_course_a/Presentation/ui/MainWrapper.dart';
import 'package:flutter_course_a/Presentation/ui/SignUpScreen.dart';
import 'package:flutter_course_a/Presentation/ui/ui_helper/ThemeSwitcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // turn off landscape
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  // Add Provider in App
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => CryptoDataProvider()),
    ChangeNotifierProvider(create: (context) => MarketViewProvider()),
    ChangeNotifierProvider(create: (context) => UserDataProvider())
  ], child: const MyMaterialApp()));
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    // Consumer (Provider) listen to change Providers
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        debugShowCheckedModeBanner: false,
        // when change language not change direction app ==> Directionality
        home: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              SharedPreferences sharedPreferences = snapshot.data!;
              var loggedInState =
                  sharedPreferences.getBool('LoggedIn') ?? false;

              if (loggedInState) {
                return const MainWrapper();
              } else {
                return const SignUpScreen();
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    });
  }
}
