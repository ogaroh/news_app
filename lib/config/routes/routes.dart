import 'package:flutter/material.dart';

import '../../features/news/domain/entities/article.dart';
import '../../features/news/presentation/pages/article_details/article_details.dart';
import '../../features/news/presentation/pages/home/news.dart';
import '../../features/news/presentation/pages/new_article/new_article.dart';
import '../../features/news/presentation/pages/saved/saved_articles.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const NewsHome());

      case '/new-article':
        return _materialRoute(const NewArticle());

      case '/article-details':
        return _materialRoute(
            ArticleDetailsView(article: settings.arguments as ArticleEntity));

      case '/saved-articles':
        return _materialRoute(const SavedArticles());

      default:
        return _materialRoute(const NewsHome());
    }
  }

  // custom route builder
  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
