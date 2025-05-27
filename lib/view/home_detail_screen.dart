

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeDetailScreen extends StatefulWidget {
  final String newsImage,newsTitle,newsData,author,description,content,source;
  const HomeDetailScreen({super.key,required this.newsImage,required this.newsTitle,required this.newsData,
  required this.author,required this.description,required this.content,required this.source});

  @override
  State<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.width*1;
    DateTime dateTime = DateTime.parse(widget.newsData);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Hero(
        tag: 'detail',
        child: Stack(
          children: [
            Container(
              child: Container(
                height: height*0.45,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(40),

                  ),
                  child: CachedNetworkImage(imageUrl: widget.newsImage,
                  fit: BoxFit.cover,
                    placeholder: (context,url)=>Center(
                      child: SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: height*.6,
              margin: EdgeInsets.only(top: height*.4),
              padding: EdgeInsets.only(top: 20,left: 20,right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(40),)
              ),
              child: ListView(
                children: [
                  Text(widget.newsTitle,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.black87,
                  ),),
                  SizedBox(height: height*0.02,),
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.source,style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black87,
                        ),),
                      ),
                      Text(format.format(dateTime),style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black87,
                      ),),

                    ],
                  ),
                  SizedBox(height: height*0.03,),
                  Text(widget.description,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.black87,
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
