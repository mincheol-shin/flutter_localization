# 📌 **Showcase**

<img src = "https://user-images.githubusercontent.com/55150540/169638060-54328d0e-54df-45c5-a914-71b31e153989.gif" width = 200>


# 📌 **Installation**

### ✔️ 패키지 추가 & 디렉토리 선언 (`pubspec.yaml`)

```yaml
dependencies:
  easy_localization: ^3.0.0 # 현지화
  flutter_phoenix: ^1.0.0  # 앱 재시작

flutter:
  assets:
   - assets/langs/
  
```
<br>

### ✔️ 폴더와 번역 파일 추가
```
assets
└── langs
    ├── ko.json                  
    └── en.json
```

- 국가 코드와 같이 사용할 수 있으나, 디바이스의 locale 정보에 따라 인식을 하지 못하는 경우도 발생 하므로  본 예제에서는 언어 코드만 사용
    - ko : 한국어
    - en : 영어
    - locale : 언어 코드 + 국가 코드
        - ex) 디바이스의 언어는 영어, 지역은 대한민국일경우 → en_KR
            - 번역 파일을 ko_KR로 추가할경우 언어 코드가 맞지 않으므로 기본값으로 설정됨

<br>

### ✔️ iOS

- `ios/Runner/Info.plist` 파일에 지원되는 locale 정보 추가

```swift
<key>CFBundleLocalizations</key>
<array>
   <string>en</string>
   <string>ko</string>
</array>
```

<br>
<br>

# 📌  Example



```dart
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
        supportedLocales: const [en, ko], // 지원하는 언어 리스트
        path: 'assets/langs', // 언어 파일이 있는 경로
        fallbackLocale: en, // 기본값 
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

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    Key? key,
    required this.text,
    required this.locale,
  }) : super(key: key);

  final String text;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        await context.setLocale(locale);
        await EasyLocalization.ensureInitialized();
        Phoenix.rebirth(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Text(text),
      ),
    );
  }
}
```

<br>

### ✔️ locale 변경

```dart
await context.setLocale(locale);
```

<br>

### ✔️ 번역 (`tr()`)

- ../en.json
```json
{
  "appBar" : "Localization Example"
}

```

- ../ko.json

```json
{
  "appBar" : "Localization 예제"
}
```

```dart
// en : Localization Example
// ko : Localization 예제
const Text('appBar').tr(),
```

<br>

### ✔️ 앱 재시작

```dart
Phoenix.rebirth(context);
```
