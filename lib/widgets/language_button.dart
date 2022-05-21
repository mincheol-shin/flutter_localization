import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

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
