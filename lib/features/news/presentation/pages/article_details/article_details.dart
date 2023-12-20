import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../../../../../injection_container.dart';
import '../../../../../l10n/provider/locale.dart';
import '../../../domain/entities/article.dart';
import '../../bloc/article/local/local_article_bloc.dart';
import '../../bloc/article/local/local_article_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArticleDetailsView extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetailsView({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Ionicons.chevron_back),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Consumer<LocaleModel>(builder: (context, localeModel, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              article!.title!,
              style: const TextStyle(
                  fontFamily: 'Butler',
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),

            const SizedBox(height: 14),
            // DateTime
            Row(
              children: [
                const Icon(Ionicons.time_outline, size: 16),
                const SizedBox(width: 4),
                Text(
                  DateFormat('d MMMM yyyy',
                          localeModel.locale?.languageCode ?? "en_US")
                      .format(DateTime.parse(article!.publishedAt!)),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(article!.urlToImage!, fit: BoxFit.cover),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${article!.description ?? ''}\n\n${article!.content ?? ''}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton.extended(
          onPressed: () => _onFloatingActionButtonPressed(context),
          icon: const Icon(Ionicons.bookmark, color: Colors.white),
          label: Text(
            AppLocalizations.of(context)?.saveArticle ?? 'Save Article',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)?.successMessage ??
              'Article saved successfully',
        ),
      ),
    );
  }
}
