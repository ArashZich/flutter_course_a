import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_a/providers/ThemeProvider.dart';
import 'package:flutter_course_a/ui/MainWrapper.dart';
import 'package:flutter_course_a/ui/ui_helper/ThemeSwitcher.dart';
import 'package:provider/provider.dart';

void main() {
  // turn off landscape
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  // Add Provider in App
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
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
        home: const Directionality(
            textDirection: TextDirection.ltr, child: MainWrapper()),
      );
    });
  }
}
