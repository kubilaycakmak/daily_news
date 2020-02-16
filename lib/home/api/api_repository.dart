import 'dart:async';
import 'package:daily_news/home/model/topheadlinesnews/response_top_headlines_news.dart';

import 'api_calls.dart';

class ApiRepository{
  final _apiCalls = ApiCalls();

  Future<ResponseTopHeadlinesNews> fetchTopHeadlinesNews() => 
      _apiCalls.getTopHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopBusinessHeadlinesNews() =>
      _apiCalls.getTopBusinessHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopEntertainmentHeadlinesNews() =>
      _apiCalls.getTopEntertainmentHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopHealthHeadlinesNews() =>
      _apiCalls.getTopHealthHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopScienceHeadlinesNews() =>
      _apiCalls.getTopScienceHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopSportHeadlinesNews() =>
      _apiCalls.getTopSportHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopTechnologyHeadlinesNews() =>
      _apiCalls.getTopTechnologyHeadlinesNews();

  Future<ResponseTopHeadlinesNews> fetchTopSearchHeadlinesNews(String query) => _apiCalls.getTopSearchlinesNews(query);
}