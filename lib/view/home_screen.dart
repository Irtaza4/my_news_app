
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_new_app/model/headline_api_model.dart';
import 'package:my_new_app/view/category_view.dart';
import 'package:my_new_app/view_model/news_headline_view_model.dart';

import '../model/category_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum filterList{bbcNews,aryNews,cnn,alJazeera,independent,abc }
class _HomeScreenState extends State<HomeScreen> {
  NewsHeadlineViewModel newsHeadlineViewModel = NewsHeadlineViewModel();
  filterList? selectedMenuItem;
  final format = DateFormat('MMMM dd, yyyy');
   String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.width*1;
    return  Scaffold(
      appBar: AppBar(
        title: Text('NEWS',style: GoogleFonts.poppins(fontSize:24,fontWeight: FontWeight.bold),),
        centerTitle:  true,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryView()));
        }, icon: Image.asset('images/category_icon.png',
        height: 30,
        width: 30,)),
        actions: [
          PopupMenuButton<filterList>(
              initialValue: selectedMenuItem,
              onSelected: (filterList item){
                if(filterList.bbcNews.name==item.name){
                  name = 'bbc-news';
                }
                if(filterList.aryNews.name==item.name){
                  name = 'ary-news';
                }
                if(filterList.abc.name==item.name){
                  name = 'abc-news';
                }
                setState(() {
                  selectedMenuItem=item;
                });
              },

              itemBuilder: (context)=><PopupMenuEntry<filterList>>[
            
            PopupMenuItem(
                value: filterList.bbcNews,
                child: Text('BBC News')),
                PopupMenuItem(
                    value: filterList.aryNews,
                    child: Text('Ary News')) ,
                PopupMenuItem(
                    value: filterList.abc,
                    child: Text('ABC News'))
          ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height*0.555,
            width: width,
            child: FutureBuilder<HeadlinesApiModel>(
                future: newsHeadlineViewModel.fetchHeadlinesApi(name),
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                   return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blueAccent,
                      ),
                    );
                  }
                  else{
                   return ListView.builder(
                     scrollDirection: Axis.horizontal,
                       itemCount: snapshot.data!.articles!.length,
                       itemBuilder: (context,index){
                        final data = snapshot.data!.articles![index];
                        DateTime dateTime = DateTime.parse(data.publishedAt.toString());
                        return  SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height*0.6,
                                width: width*0.9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: height*0.02
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(imageUrl:data.urlToImage.toString(),
                                    fit:BoxFit.cover ,
                                  placeholder: (context,url)=>spinKit2,
                                  errorWidget: (context,url ,error)=>Icon(Icons.error,color: Colors.red,),
                                  ),
                                ),
                              ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  alignment: Alignment.center,
                                  height: height*.22,
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width*0.7,
                                      child: Text(data.title.toString(),style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,

                                      ),
                                      maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: width*0.7,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data.source!.name.toString(),
                                                maxLines:2,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                            GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,

                                              fontSize: 13,

                                            )),
                                            Text(format.format(dateTime),
                                                maxLines:2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,

                                            )),

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ),
                            )
                          ],
                        ),
                      );
                   });
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(child:
            FutureBuilder<CategoriesModel>(
                future: newsHeadlineViewModel.fetchCategoriesApi('general'),
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
                        shrinkWrap: true,
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
                })),
          )
        ],
      ),
    );
  }
}
const spinKit2 = SpinKitFadingCircle(
color: Colors.amber,
  size: 50,
);