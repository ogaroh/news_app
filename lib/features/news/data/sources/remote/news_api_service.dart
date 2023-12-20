import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../../core/shared/constants.dart';
import '../../models/article.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: kBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getTopHeadlines({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}
