import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/article.dart';
import '../../bloc/article/remote/remote_article_bloc.dart';
import '../../bloc/article/remote/remote_article_state.dart';
import '../../widgets/article_widget.dart';
import '../../widgets/locale_switcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      leading: const LocaleSwitcher(),
      title: Text(
        AppLocalizations.of(context)?.headlines ?? 'Headlines',
      ),
      actions: [
        IconButton(
          onPressed: () => _onShowSavedArticlesViewTapped(context),
          icon: const Icon(Icons.bookmark),
          tooltip: AppLocalizations.of(context)?.savedArticles ?? 'Bookmarks',
        )
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (_, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ArticleWidget(
                article: state.articles![index],
                onArticlePressed: (article) =>
                    _onArticlePressed(context, article),
              );
            },
            itemCount: state.articles!.length,
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/article-details', arguments: article);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/saved-articles');
  }
}
