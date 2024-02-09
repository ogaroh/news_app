import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'config/routes/routes.dart';
import 'config/theme/theme.dart';
import 'features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/news/presentation/bloc/article/remote/remote_article_event.dart';
import 'features/news/presentation/pages/home/news.dart';
import 'injection_container.dart';
import 'l10n/l10n.dart';
import 'l10n/provider/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {

  // initialize dependencies
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: ChangeNotifierProvider(
        create: (context) => LocaleModel(),
        child: Consumer<LocaleModel>(builder: (context, localeModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme(),
            darkTheme: darkTheme(),
            themeMode: ThemeMode.system,
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            home: const NewsHome(),
            // localization & language set up
            supportedLocales: L10n.all,
            locale: localeModel.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
          );
        }),
      ),
    );
  }
}
