import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_a/logic/providers/ThemeProvider.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get Provider data
    final themeProvider = Provider.of<ThemeProvider>(context);
    var switchIcon = Icon(themeProvider.isDarkMode
        ? CupertinoIcons.sun_max_fill
        : CupertinoIcons.moon_fill);

    return IconButton(
        onPressed: () {
          themeProvider.toggleTheme();
        },
        icon: switchIcon);
  }
}
