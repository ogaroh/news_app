// import 'package:flutter/material.dart';

// class AppRoutes {
//   static Route onGenerateRoutes(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return _materialRoute(const DailyNews());

//       case '/ArticleDetails':
//         return _materialRoute(
//             ArticleDetailsView(article: settings.arguments as ArticleEntity));

//       case '/SavedArticles':
//         return _materialRoute(const SavedArticles());

//       default:
//         return _materialRoute(const DailyNews());
//     }
//   }

//   // custom route builder
//   static Route<dynamic> _materialRoute(Widget view) {
//     return MaterialPageRoute(builder: (_) => view);
//   }
// }
