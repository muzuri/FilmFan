import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:filmfan/api/movie_api_request.dart';
import 'package:filmfan/models/now_watching_model.dart';
import 'package:filmfan/pages/favorites/favorite_provider.dart';
import 'package:filmfan/pages/movie_details.dart';
import 'package:filmfan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.9;
  double _height = 220;
  bool _isCurrent = false;


  var now_watching = <Results>[];
  var recommendations = <Results>[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
        print("Current page value :" + _currentPageValue.toString());
      });
    });

    _initData();
  }

  _initData() async {
    await HttpRequest()
        .getPublicData("now_playing/" + "?api_key=9ea54d07626136e27875ff900d04b8c8&language=en-US&page=1")
        .then((response) {
      setState(() {

        Iterable list = json.decode(response.body)['results'];
        now_watching = list.map((model) => Results.fromJson(model)).toList();


        print(now_watching.length);
      });
    });

    await HttpRequest()
        .getPublicData("338953/recommendations" + "?api_key=9ea54d07626136e27875ff900d04b8c8&language=en-US&page=1")
        .then((response) {
      setState(() {

        Iterable list = json.decode(response.body)['results'];
        recommendations = list.map((model) => Results.fromJson(model)).toList();


        print(recommendations.length);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 50),
        child: Stack(
          children: <Widget>[
            Container(
              height: height + 50,
              width: MediaQuery.of(context).size.width, // Background
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Welcome",
                                    style: GoogleFonts.raleway(
                                        fontWeight: FontWeight.w900,
                                        color: whiteColor,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Which movie are going to see today?",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  color: whiteColor,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: primaryOverlayColor),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 10,
                              left: 9,
                              child: Icon(
                                Icons.favorite,
                                color: whiteColor,
                                size: 25,
                              ),
                            ),
                            Positioned(
                              top: 2,
                              right: 4,
                              child: Badge(
                                badgeColor: orangeColor,
                                badgeContent: Consumer<MyFavoriteProvider>(
                                  builder: (context, value, child) {
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        value.getCounter().toString(),
                                        style: TextStyle(
                                            color: whiteColor, fontSize: 11),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(), // Required some widget in between to float AppBar
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyFavoriteProvider(),
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: _appBar(AppBar().preferredSize.height),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 20, bottom: 10, top: 10, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Now watching movies ",
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline2,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: textColor),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 470,
                    // decoration: BoxDecoration(color: Colors.grey),
                    margin: EdgeInsets.only(top: 15),
                    child: PageView.builder(
                        itemCount: now_watching.length,
                        controller: _pageController,
                        itemBuilder: (context, position) {
                          return _buildSamplePageItem(position);
                        })),
                new DotsIndicator(
                  dotsCount: now_watching.length,
                  position: _currentPageValue,
                  decorator: DotsDecorator(
                      activeSize: Size(10, 5),
                      size: Size.square(5),
                      activeColor: orangeColor,
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, bottom: 10, top: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Recommendation movies ",
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline2,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: textColor),
                      ),
                    ],
                  ),
                ),
                Container(
                    // //height: 1000,
                    child:
                        //   recommendations.isEmpty
                        //       ? Container(
                        //     height: 200,
                        //     child: Center(
                        //       child: SpinKitDoubleBounce(
                        //         color: appColor,
                        //         size: 40,
                        //       ),
                        //     ),
                        //   )
                        //       :
                        AnimationLimiter(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      recommendations.length,
                      (int index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 2,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           ProductDetail(
                                    //             products[index].id,
                                    //             products[index].product_name,
                                    //             products[index].image_url,
                                    //             products[index].product_price,
                                    //             products[index].category,
                                    //             products[index].product_description,
                                    //             products[index].quantity_kg,
                                    //             products[index].shop_id,
                                    //             products[index].shop_name,
                                    //           )),
                                    // );
                                  },
                                  child: _buildRecommendationItem(index)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSamplePageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 1;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MovieDetails(
                      now_watching[index].id.toString(),
                      now_watching[index].title.toString(),
                      now_watching[index].releaseDate.toString(),
                      now_watching[index].overview.toString(),
                      now_watching[index].genreIds.toString(),
                      now_watching[index].voteAverage.toString(),
                      now_watching[index].posterPath.toString(),

                    )),
          );
        },
        child: Stack(
          children: [
            Container(
              height: 360,
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // border: Border.all(color: index.isEven ? orangeOverlayColor : orangeOverlayColor, width: 3),
                  boxShadow: [
                    BoxShadow(
                        color: greyColor,
                        // offset: Offset(3, 8),
                        blurRadius: 10)
                  ],
                  color: index.isEven ? textColor : textColor,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://image.tmdb.org/t/p/original/" +now_watching[index].posterPath.toString()))),
                      // image: AssetImage("assets/images/posters.png"))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,

                margin: EdgeInsets.only(left: 25, right: 25, bottom: 0),
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            child: Text(now_watching[index].title.toString(),
                                softWrap: true,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.headline2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: textColor)),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Release date : ",
                                  style: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: textColor,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                width: 10,
                              ),
                              Text(now_watching[index].releaseDate.toString(),
                                  style: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: textColor,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          SizedBox(
                            height: 8,
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
                              Text(now_watching[index].voteAverage.toString(),
                                  style: GoogleFonts.lato(
                                      fontSize: 15,
                                      color: orangeColor,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(int index) {
    return Stack(
      children: [
        Container(
          height: 360,
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: index.isEven ? orangeOverlayColor : orangeOverlayColor, width: 3),

              color: index.isEven ? textColor : textColor,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/original/" +recommendations[index].posterPath.toString()))),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: darkerColor,
            ),
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 0),
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        width: 100,
                        child: Text(recommendations[index].title.toString(),
                            softWrap: true,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(

                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: textColor)),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              children: List.generate(
                                  1,
                                  (index) => Icon(
                                        Icons.star,
                                        color: orangeColor,
                                        size: 12,
                                      )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(recommendations[index].voteAverage.toString(),
                                style: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: orangeColor,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
