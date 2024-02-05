import 'package:flutter_dotenv/flutter_dotenv.dart';

final String kAPIKey = dotenv.env['API_KEY'] ?? "";
const String kBaseURL = 'https://newsapi.org/v2';
const String kCountryQuery = 'us';
const String kCategoryQuery = 'technology';

// default font family
const String kDefaultFontFamily = 'Newsreader';

// default date format
const String kDefaultDateFormat = 'd MMMM yyyy';
