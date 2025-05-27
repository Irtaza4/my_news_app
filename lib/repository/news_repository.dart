
import 'dart:convert';

import 'package:my_new_app/model/category_model.dart';
import 'package:my_new_app/model/headline_api_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository{

Future<HeadlinesApiModel>fetchHeadlinesApi(String channel)async{
  
  try{
    final response = await http.get(
        Uri.parse('https://newsapi.org/v2/top-headlines?sources=${channel}&apiKey=44c879080fdc4403a696e45a89affee2'));
      print('responseeeeeeee ${response.body}');
    final data = jsonDecode(response.body);

    if(response.statusCode ==200){
      return HeadlinesApiModel.fromJson(data);
    }

  }
  catch(e){
    print('Errrorrr $e');
  }
  throw Exception('Unable to fetch data');
}

Future<CategoriesModel>fetchCategoriesApi(String category)async{
   final url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=44c879080fdc4403a696e45a89affee2';
  final response = await http.get(Uri.parse(url));
  if(response.statusCode==200){
    final data = jsonDecode(response.body);
    return CategoriesModel.fromJson(data);
  }
  throw Exception('Something weent wrong');

}

}