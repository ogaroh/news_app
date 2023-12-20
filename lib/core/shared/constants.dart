import 'package:flutter_dotenv/flutter_dotenv.dart';

final String kAPIKey = dotenv.env['API_KEY'] ?? "";
const String kBaseURL = 'https://newsapi.org/v2';
const String kCountryQuery = 'us';
const String kCategoryQuery = 'technology';

// default image
const String kDefaultImage =
    "https://www.burnstoves.com/_next/image/?url=%2F_next%2Fstatic%2Fmedia%2FLogoWhite.2cff8c9d.svg&w=384&q=75";

// default font family
const String kDefaultFontFamily = 'Newsreader';

// default date format
const String kDefaultDateFormat = 'd MMMM yyyy';
