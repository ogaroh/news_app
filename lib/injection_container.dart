import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'features/news/data/repository/article_repository_impl.dart';
import 'features/news/data/sources/local/app_database.dart';
import 'features/news/data/sources/remote/news_api_service.dart';
import 'features/news/domain/repository/article_repository.dart';
import 'features/news/domain/usecases/delete_local_article.dart';
import 'features/news/domain/usecases/get_local_articles.dart';
import 'features/news/domain/usecases/get_remote_articles.dart';
import 'features/news/domain/usecases/save_article.dart';
import 'features/news/presentation/bloc/article/local/local_article_bloc.dart';
import 'features/news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Register your network request dependencies (Dio, Retrofit, etc.)
  sl.registerSingleton<Dio>(Dio());

  // Register Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  // Register UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  // Register the state management BLoCs
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));

  sl.registerFactory<LocalArticleBloc>(
      () => LocalArticleBloc(sl(), sl(), sl()));
}
