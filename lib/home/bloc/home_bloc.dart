import 'package:bloc/bloc.dart';
import 'package:daily_news/home/api/api_repository.dart';
import 'package:daily_news/home/model/topheadlinesnews/response_top_headlines_news.dart';

abstract class DataState{}
class DataInitial extends DataState{}
class DataLoading extends DataState {}
class DataSuccess extends DataState {
  final ResponseTopHeadlinesNews data;

  DataSuccess(this.data);
}
class DataFailed extends DataState {
  final String errorMessage;

  DataFailed(this.errorMessage);
}
class DataEvent {
  final String category;
  

  DataEvent(this.category);
}

class HomeBloc extends Bloc<DataEvent, DataState>{

  @override
  DataState get initialState => DataInitial();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async*{
    String query;
    yield DataLoading();
    final apiRepository = ApiRepository();
    final categoryLowerCase = event.category.toLowerCase();
    switch (categoryLowerCase){
      case 'all':
      final data = await apiRepository.fetchTopHeadlinesNews();
      if(data.error == null){
        yield DataSuccess(data);
      }else{
        yield DataFailed('Failed to fecth data');
      }
      break;
      case 'business':
      final data = await apiRepository.fetchTopBusinessHeadlinesNews();
      if(data.error == null){
        yield DataSuccess(data);
      }else{
        yield DataFailed('Failed to fecth data');
      }
      break;
      case 'entertainment':
      final data = await apiRepository.fetchTopEntertainmentHeadlinesNews();
      if(data.error == null){
        yield DataSuccess(data);
      }else{
        yield DataFailed('Failed to fecth data');
      }
      break;
      case 'health':
      final data = await apiRepository.fetchTopHealthHeadlinesNews();
      if(data.error == null){
        yield DataSuccess(data);
      }else{
        yield DataFailed('Failed to fecth data');
      }
      break;
      case 'science':
      final data = await apiRepository.fetchTopScienceHeadlinesNews();
      if(data.error == null){
        yield DataSuccess(data);
      }else{
        yield DataFailed('Failed to fecth data');
      }
      break;
      case 'sport':
      final data = await apiRepository.fetchTopSportHeadlinesNews();
      if(data.error == null){
        yield DataSuccess(data);
      }else{
        yield DataFailed('Failed to fecth data');
      }
      break;
      case 'technology':
      final data = await apiRepository.fetchTopTechnologyHeadlinesNews();
      if(data.error == null){
        yield DataSuccess(data);
      }else{
        yield DataFailed('Failed to fecth data');
      }
      break;
      case 'search':
      final data = await apiRepository.fetchTopSearchHeadlinesNews(query);
      if(data.error == null){
        yield DataSuccess(data);
      }else{
        yield DataFailed('Failed to fecth data');
      }
      break;
    }
  }

}