import 'package:dio/dio.dart';
import 'package:daily_news/home/model/topheadlinesnews/response_top_headlines_news.dart';

class ApiCalls{
  final Dio _dio = Dio();
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines?country=tr&apiKey=9ff9625e03ed440d861aff93a467e5fe';

  void printOutError(error, StackTrace stackTrace){
    print('Exception occured: $error with stacktrace: $stackTrace');
  }

  Future<ResponseTopHeadlinesNews> getTopHeadlinesNews() async{
    try{
      final response = await _dio.get(_baseUrl);
      print(response);
      return ResponseTopHeadlinesNews.fromJson(response.data);
    }catch (error, stractrace){
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
  Future<ResponseTopHeadlinesNews> getTopSearchlinesNews(String query) async{
    try{
      final response = await _dio.get('$_baseUrl?q=$query');
      print(response);
      return ResponseTopHeadlinesNews.fromJson(response.data);
    }catch (error, stractrace){
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
  Future<ResponseTopHeadlinesNews> getTopBusinessHeadlinesNews() async{
    try{
      final response = await _dio.get('$_baseUrl&category=business');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    }catch (error, stractrace){
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
  Future<ResponseTopHeadlinesNews> getTopEntertainmentHeadlinesNews() async{
    try{
      final response = await _dio.get('$_baseUrl&category=entertainment');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    }catch (error, stractrace){
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
  Future<ResponseTopHeadlinesNews> getTopHealthHeadlinesNews() async{
    try{
      final response = await _dio.get('$_baseUrl&category=health');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    }catch (error, stractrace){
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
  Future<ResponseTopHeadlinesNews> getTopScienceHeadlinesNews() async{
    try{
      final response = await _dio.get('$_baseUrl&category=science');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    }catch (error, stractrace){
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
  Future<ResponseTopHeadlinesNews> getTopSportHeadlinesNews() async{
    try{
      final response = await _dio.get('$_baseUrl&category=sport');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    }catch (error, stractrace){
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
  Future<ResponseTopHeadlinesNews> getTopTechnologyHeadlinesNews() async{
    try{
      final response = await _dio.get('$_baseUrl&category=technology');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    }catch (error, stractrace){
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
}