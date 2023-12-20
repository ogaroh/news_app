import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/routes/routes.dart';
import 'config/theme/theme.dart';
import 'features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/news/presentation/bloc/article/remote/remote_article_event.dart';
import 'features/news/presentation/pages/home/news.dart';
import 'injection_container.dart';

Future<void> main() async {
  // load .env file
  await dotenv.load(fileName: ".env");

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const NewsHome(),
      ),
    );
  }
}
