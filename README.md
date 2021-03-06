# πΒ **Showcase**

<img src = "https://user-images.githubusercontent.com/55150540/169638060-54328d0e-54df-45c5-a914-71b31e153989.gif" width = 200>


<br>
<br>

# πΒ **Installation**

### βοΈΒ ν¨ν€μ§ μΆκ° & λλ ν λ¦¬ μ μΈ (`pubspec.yaml`)

```yaml
dependencies:
  easy_localization: ^3.0.0 # νμ§ν
  flutter_phoenix: ^1.0.0  # μ± μ¬μμ

flutter:
  assets:
   - assets/langs/
  
```
<br>

### βοΈ ν΄λμ λ²μ­ νμΌ μΆκ°
```
assets
βββ langs
    βββ ko.json                  
    βββ en.json
```

- κ΅­κ° μ½λμ κ°μ΄ μ¬μ©ν  μ μμΌλ, λλ°μ΄μ€μ locale μ λ³΄μ λ°λΌ μΈμμ νμ§ λͺ»νλ κ²½μ°λ λ°μ νλ―λ‘  λ³Έ μμ μμλ μΈμ΄ μ½λλ§ μ¬μ©
    - ko : νκ΅­μ΄
    - en : μμ΄
    - locale : μΈμ΄ μ½λ + κ΅­κ° μ½λ
        - ex) λλ°μ΄μ€μ μΈμ΄λ μμ΄, μ§μ­μ λνλ―Όκ΅­μΌκ²½μ° β en_KR
            - λ²μ­ νμΌμ ko_KRλ‘ μΆκ°ν κ²½μ° μΈμ΄ μ½λκ° λ§μ§ μμΌλ―λ‘ κΈ°λ³Έκ°μΌλ‘ μ€μ λ¨

<br>

### βοΈ iOS

- `ios/Runner/Info.plist` νμΌμ μ§μλλ locale μ λ³΄ μΆκ°

```swift
<key>CFBundleLocalizations</key>
<array>
   <string>en</string>
   <string>ko</string>
</array>
```

<br>
<br>

# πΒ  Example



```dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:localization_example/screens/home_screen.dart';
import 'package:localization_example/widgets/language_button.dart';

import 'constants.dart';

void main() async {
  // main λ©μλμμ λΉλκΈ° λ©μλ μ¬μ©μ λ°λμ μΆκ°
  WidgetsFlutterBinding.ensureInitialized();
  // ν¨ν€μ§ μ΄κΈ°ν
  await EasyLocalization.ensureInitialized();
  runApp(
    Phoenix(
      child: EasyLocalization(
        supportedLocales: const [en, ko], // μ§μνλ μΈμ΄ λ¦¬μ€νΈ
        path: 'assets/langs', // μΈμ΄ νμΌμ΄ μλ κ²½λ‘
        fallbackLocale: en, // κΈ°λ³Έκ° 
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
    // κΈ°κΈ°μ μΈμ΄ μ€μ μ΄ νκ΅­μ΄μΌκ²½μ° ko, μμ΄μΌ κ²½μ° en, κ·Έ μΈμΌκ²½μ° κΈ°λ³Έκ°μΈ en μΆλ ₯
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
              text: 'νκ΅­μ΄',
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

### βοΈΒ locale λ³κ²½

```dart
await context.setLocale(locale);
```

<br>

### βοΈΒ λ²μ­ (`tr()`)

- ../en.json
```json
{
  "appBar" : "Localization Example"
}

```

- ../ko.json

```json
{
  "appBar" : "Localization μμ "
}
```

```dart
// en : Localization Example
// ko : Localization μμ 
const Text('appBar').tr(),
```

<br>

### βοΈΒ μ± μ¬μμ

```dart
Phoenix.rebirth(context);
```
