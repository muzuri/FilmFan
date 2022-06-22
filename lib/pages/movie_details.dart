import 'package:badges/badges.dart';
import 'package:filmfan/pages/favorites/db_favorite_helper.dart';
import 'package:filmfan/pages/favorites/favorite_provider.dart';
import 'package:filmfan/utils/colors.dart';
import 'package:filmfan/widgets/app_icon.dart';
import 'package:filmfan/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class MovieDetails extends StatefulWidget {

  final String id;
  final String title;
  final String release;
  final String overview;
  final String genre;
  final String rate;
  final String poster;


  MovieDetails(this.id, this.title, this.release, this.overview, this.genre,
      this.rate, this.poster);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  DbHelper? _dbHelper = DbHelper();
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => MyFavoriteProvider(),
      child: Builder(builder: (BuildContext context) {
        final myFavorite = Provider.of<MyFavoriteProvider>(context);
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 270,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/original/" +widget.poster),
                            fit: BoxFit.cover)),
                  )),
              Positioned(
                  left: 20,
                  right: 20,
                  top: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (() => Navigator.pop(context)),
                        child: AppIcon(icon :Icons.arrow_back),
                      ),
                      InkWell(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => ShoppingCart("1","1","1000")),
                          // );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: appDarkOverlayColor),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 7,
                                left: 9,
                                child: Icon(
                                  Icons.favorite,
                                  color: textColor,
                                  size: 25,
                                ),
                              ),
                              Positioned(
                                top: 1,
                                right: 7,
                                child: Badge(
                                  badgeColor: orangeColor,
                                  badgeContent: Consumer<MyFavoriteProvider>(
                                    builder: (context, value, child) {
                                      return Text(value.getCounter().toString());
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 230,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: backgroundColor,
                            offset: Offset(5, 5),
                            blurRadius: 18)
                      ],
                       ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 270,
                                child: Text(widget.title,
                                    // overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: GoogleFonts.lato(
                                        textStyle:
                                        Theme.of(context).textTheme.headline2,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: textColor)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    children: List.generate(
                                        1,
                                            (index) => Icon(
                                          Icons.star,
                                          color: orangeColor,
                                          size: 17,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(widget.rate,
                                      style: GoogleFonts.lato(
                                          fontSize: 15,
                                          color: orangeColor,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("Genre : ",
                                style: GoogleFonts.lato(
                                    fontSize: 14, color: textColor,)),
                            Text("Action, Adventure, Comedy, Thriller",
                                style: GoogleFonts.lato(
                                    fontSize: 14, color: orangeColor)),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("Release date : ",
                                style: GoogleFonts.lato(
                                  fontSize: 14, color: textColor,)),
                            Text(widget.release,
                                style: GoogleFonts.lato(
                                    fontSize: 14, color: orangeColor)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(" Overview" ,
                              style: GoogleFonts.lato(
                                  fontSize: 15, color: Colors.white)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExpandableText(text: widget.overview),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(" Characters" ,
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15, color: Colors.white)),
                                  ),
                                  Container(
                                    height: 150,
                                    margin: EdgeInsets.only(bottom: 10, right: 10),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 10,
                                        itemBuilder: (context, position) {
                                          return GestureDetector(
                                              onTap: () {

                                              },
                                              child: _buildCharacterItem(position));
                                        }),
                                  ),
                                ],
                              ),
                            )),

                      ],
                    ),
                  )),

            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: orangeColor),
                    child: Row(
                      children: [

                        Icon(Icons.how_to_vote_sharp, color: whiteColor, size: 18),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          " Vote Movie",
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCharacterItem(int index) {
    return Column(
      children: [
        Container(
          height: 100,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            // color: orangeColor,
          ),
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: index.isEven ? textColor : textColor,
                  // shape: BoxShape.circle
                ),
                  child: Image.asset("assets/images/users.png"),
                ),
                  Container(
                    width: 90,
                    child: Text(
                      "Dally Jones wwewer",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 12,
                          color: index.isEven ? whiteColor : whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: 90,
                    child: Text(
                      " Spider-verse",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 10,
                          color: index.isEven ? whiteColor : whiteColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

}
