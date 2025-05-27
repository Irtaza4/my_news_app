
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_new_app/model/category_model.dart';

import '../view_model/news_headline_view_model.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  NewsHeadlineViewModel model = NewsHeadlineViewModel();

  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'General';
  List<String> categoryList = [
    'General',
    'Entertainment',
    'Health',
    'Sport',
    'Business',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.width*1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 50,
             child: ListView.builder(
               scrollDirection: Axis.horizontal,
                 itemCount: categoryList.length,
                 itemBuilder: (context,index){
               return InkWell(
                 onTap: (){
                   categoryName = categoryList[index];
                   setState(() {

                   });
                 },
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: Container(
                     decoration: BoxDecoration(
                       color: categoryName == categoryList[index]?Colors.blueAccent:
                         Colors.grey,
                       borderRadius: BorderRadius.circular(15)
                     ),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 12),
                       child: Center(child: Text(categoryList[index].toString(),style: GoogleFonts.poppins(
                         color: Colors.white,
                         fontWeight: categoryName == categoryList[index]?FontWeight.bold: FontWeight.normal,
                         fontSize: 13
                       ),)),
                     ),
                   ),
                 ),
               );
             }),
            ),
            Expanded(child:
            FutureBuilder<CategoriesModel>(
                future: model.fetchCategoriesApi(categoryName),
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: SpinKitFadingCircle(
                        size: 50,
                        color: Colors.blueAccent,
                      ),
                    );
                  }else{
                    return ListView.builder(
                        itemCount:  snapshot.data!.articles!.length,
                        itemBuilder: (context,index){
                          final data = snapshot.data!.articles![index];
                          DateTime dateTime = DateTime.parse(data.publishedAt.toString());
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(imageUrl:data.urlToImage.toString(),
                            fit:BoxFit.cover ,
                            height: height*0.18,
                            width: width*.3,
                            placeholder: (context,url)=> Center(
                              child: SpinKitFadingCircle(
                                size: 50,
                                color: Colors.blueAccent,
                              ),
                            ),
                            errorWidget: (context,url ,error)=>Icon(Icons.error,color: Colors.red,),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: height*0.18,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(children: [
                                Text(data.title.toString(),style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.source!.name.toString(),style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600
                                    ),),
                                    Text(format.format(dateTime),style: GoogleFonts.poppins(
                                        fontSize: 14,

                                        fontWeight: FontWeight.w500
                                    ),),
                                  ],
                                )
                              ],),
                            ),
                          ),
                        )
                      ],),
                    );

                    });
                  }
                }))
          ],
        ),
      ),
    );
  }
}
