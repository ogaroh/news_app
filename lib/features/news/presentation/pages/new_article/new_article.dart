import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/features/news/presentation/pages/home/news.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/article.dart';
import '../../bloc/article/local/local_article_bloc.dart';
import '../../bloc/article/local/local_article_event.dart';

// global form key
final _formKey = GlobalKey<FormState>();

// form field decoration
final formFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
);
// text editing controllers
final TextEditingController _titleController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final TextEditingController _authorController = TextEditingController();
final TextEditingController _contentController = TextEditingController();
final TextEditingController _urlController = TextEditingController();
final TextEditingController _urlToImageController = TextEditingController();

class NewArticle extends HookWidget {
  const NewArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(AppLocalizations.of(context)?.newArticle ?? 'New Article'),
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onBackButtonTapped(context),
            child: const Icon(Ionicons.chevron_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 24.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      controller: _titleController,
                      decoration: formFieldDecoration.copyWith(
                        labelText:
                            AppLocalizations.of(context)?.title ?? 'Title',
                        hintText:
                            AppLocalizations.of(context)?.title ?? 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${AppLocalizations.of(context)?.title ?? 'Title'} ${AppLocalizations.of(context)?.isRequired ?? 'is required'}';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: formFieldDecoration.copyWith(
                        labelText: AppLocalizations.of(context)?.description ??
                            'Description',
                        hintText: AppLocalizations.of(context)?.description ??
                            'Description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${AppLocalizations.of(context)?.description ?? 'description'} ${AppLocalizations.of(context)?.isRequired ?? 'is required'}';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      controller: _authorController,
                      decoration: formFieldDecoration.copyWith(
                        labelText:
                            AppLocalizations.of(context)?.author ?? 'author',
                        hintText:
                            AppLocalizations.of(context)?.author ?? 'author',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      controller: _contentController,
                      decoration: formFieldDecoration.copyWith(
                        labelText:
                            AppLocalizations.of(context)?.content ?? 'content',
                        hintText:
                            AppLocalizations.of(context)?.content ?? 'content',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${AppLocalizations.of(context)?.content ?? 'content'} ${AppLocalizations.of(context)?.isRequired ?? 'is required'}';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      controller: _urlController,
                      decoration: formFieldDecoration.copyWith(
                        labelText: AppLocalizations.of(context)?.url ?? 'url',
                        hintText: AppLocalizations.of(context)?.url ?? 'url',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      controller: _urlToImageController,
                      decoration: formFieldDecoration.copyWith(
                        labelText: AppLocalizations.of(context)?.urlToImage ??
                            'urlToImage',
                        hintText: AppLocalizations.of(context)?.urlToImage ??
                            'urlToImage',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // generate article entity from text editing controllers
              final article = ArticleEntity(
                title: _titleController.text,
                description: _descriptionController.text,
                author: _authorController.text,
                content: _contentController.text,
                url: _urlController.text,
                urlToImage: _urlToImageController.text,
                publishedAt: DateTime.now().toIso8601String(),
              );
              // save entity to local database
              _onFloatingActionButtonPressed(context, article);
            }
          },
          icon: const Icon(Ionicons.save_outline),
          label: Text(
            AppLocalizations.of(context)?.saveArticle ?? 'Save Article',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // back button pressed
  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonPressed(
      BuildContext context, ArticleEntity article) {
    // save article to device storage
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)?.successMessage ??
              'Article saved successfully',
        ),
      ),
    );
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const NewsHome()), (route) => false);
  }
}
