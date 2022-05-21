import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/language_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 기기의 언어 설정이 한국어일경우 ko, 영어일 경우 en, 그 외일경우 기본값인 en 출력
    debugPrint('Locale : ${context.locale}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('appBar').tr(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            LanguageButton(
              text: '한국어',
              locale: ko,
            ),
            SizedBox(height: 12),
            LanguageButton(
              text: 'English',
              locale: en,
            ),
          ],
        ),
      ),
    );
  }
}
