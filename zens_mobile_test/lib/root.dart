import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zens_mobile_test/screens/main_screen.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: AppBuilder(
            child: child!,
          ),
        );
      },
      child: const MainScreen(),
    );
  }
}

class AppBuilder extends StatelessWidget {
  const AppBuilder({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MediaQuery.withNoTextScaling(
      child: child,
    );
  }
}
