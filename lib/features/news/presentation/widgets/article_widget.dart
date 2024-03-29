import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/shared/constants.dart';
import '../../../../l10n/provider/locale.dart';
import '../../domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;
  final bool? isRemovable;
  final void Function(ArticleEntity article)? onRemove;
  final void Function(ArticleEntity article)? onArticlePressed;

  const ArticleWidget({
    Key? key,
    this.article,
    this.onArticlePressed,
    this.isRemovable = false,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.only(
            start: 14, end: 14, bottom: 7, top: 7),
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          children: [
            _buildImage(context),
            _buildTitleAndDescription(),
            _buildRemovableArea(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article!.urlToImage!,
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: const BoxDecoration(),
            child: const CupertinoActivityIndicator(),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: const BoxDecoration(),
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Consumer<LocaleModel>(builder: (context, localeModel, child) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                article!.title ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),

              // Description
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    article!.description ?? '',
                    maxLines: 2,
                  ),
                ),
              ),

              // Datetime
              Row(
                children: [
                  const Icon(Icons.timeline_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat(kDefaultDateFormat,
                            localeModel.locale?.languageCode ?? "en_US")
                        .format(DateTime.parse(article!.publishedAt!)),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildRemovableArea(BuildContext context) {
    if (isRemovable!) {
      return GestureDetector(
        onTap: () => showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: const Text("Remove article"),
            content:
                const Text("Are you sure you want to delete this article?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _onRemove();
                },
                child: const Text("Yes"),
              ),
            ],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.delete_sweep, color: Colors.red),
        ),
      );
    }
    return Container();
  }

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed!(article!);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(article!);
    }
  }
}
