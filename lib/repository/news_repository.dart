
import 'dart:convert';

import 'package:my_new_app/model/headline_api_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository{

Future<HeadlinesApiModel>fetchHeadlinesApi()async{
  
  try{
    final response = await http.get(
        Uri.parse('https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=44c879080fdc4403a696e45a89affee2'));
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


}