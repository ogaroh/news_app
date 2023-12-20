import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/provider/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleSwitcher extends StatelessWidget {
  const LocaleSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleModel>(builder: (context, localeModel, child) {
      return PopupMenuButton<Locale>(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: Locale("en"),
            child: Text("English"),
          ),
          const PopupMenuItem(
            value: Locale("sw"),
            child: Text("Kiswahili"),
          ),
          const PopupMenuItem(
            value: Locale("fr"),
            child: Text("Français"),
          ),
          const PopupMenuItem(
            value: Locale("es"),
            child: Text("Español"),
          ),
        ],
        offset: const Offset(0, 50),
        elevation: 2,
        icon: const Icon(Icons.language),
        tooltip:
            AppLocalizations.of(context)?.changeLanguage ?? 'Change Language',
        onSelected: (value) => localeModel.set(value),
      );
    });
  }
}
