import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:localization_example/screens/home_screen.dart';
import 'package:localization_example/widgets/language_button.dart';

import 'constants.dart';

void main() async {
  // main 메서드에서 비동기 메서드 사용시 반드시 추가
  WidgetsFlutterBinding.ensureInitialized();
  // 패키지 초기화
  await EasyLocalization.ensureInitialized();
  runApp(
    Phoenix(
      child: EasyLocalization(
        supportedLocales: const [en, ko],
        path: 'assets/langs',
        fallbackLocale: en,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const HomeScreen(),
    );
  }
}
