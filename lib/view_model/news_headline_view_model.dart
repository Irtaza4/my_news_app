
import 'package:my_new_app/model/category_model.dart';
import 'package:my_new_app/model/headline_api_model.dart';
import 'package:my_new_app/repository/news_repository.dart';

class NewsHeadlineViewModel{

  final _repo = NewsRepository();
  Future<HeadlinesApiModel> fetchHeadlinesApi(String channel)async{
    final response = await _repo.fetchHeadlinesApi(channel);
  return response;
  }

  Future<CategoriesModel> fetchCategoriesApi(String category)async{
    final response = await _repo.fetchCategoriesApi(category);
  return response;
  }


}