
import 'package:my_new_app/model/headline_api_model.dart';
import 'package:my_new_app/repository/news_repository.dart';

class NewsHeadlineViewModel{

  final _repo = NewsRepository();
  Future<HeadlinesApiModel> fetchHeadlinesApi()async{
    final response = await _repo.fetchHeadlinesApi();
  return response;
  }


}