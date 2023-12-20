import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/provider/locale.dart';

class LocaleSwitcher extends StatelessWidget {
  const LocaleSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleModel>(builder: (context, localeModel, child) {
      return DropdownButton(
        hint: const Text("Change Language"),
        value: localeModel.locale ?? const Locale("en"),
        items: const [
          DropdownMenuItem(
            value: Locale("en"),
            child: Text("English"),
          ),
          DropdownMenuItem(
            value: Locale("sw"),
            child: Text("Swahili"),
          ),
          DropdownMenuItem(
            value: Locale("fr"),
            child: Text("Français"),
          ),
          DropdownMenuItem(
            value: Locale("es"),
            child: Text("Espanol"),
          ),
        ],
        onChanged: (value) {
          log(value.runtimeType.toString());
          if (value != null) {
            localeModel.set(value);
          }
        },
      );
    });
  }
}
