import 'dart:async';

import 'package:filmfan/pages/home.dart';
import 'package:filmfan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer(const Duration(seconds: 4), () => {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (_) => Home()))
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appDarkColor,
      body: Stack(children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset("assets/images/posters.png", fit: BoxFit.fitHeight, scale: 4,)
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(

                  gradient: RadialGradient(
                      colors: [primaryOverlayColor, appOverlayColor]
                  )

            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "",
                    style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w400,
                        color: whiteColor,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "",
                    style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w400,
                        color: whiteColor,
                        fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                    ],
                  ),
                ],
              ),
            ),
          ),
        ),


        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 30,),
              Container(
                height: 130,
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                      width: 10,
                          color: orangeColor,
                  ))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Watch",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w400, color: whiteColor, fontSize: 19),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Your Movies",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w900, color: whiteColor, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "in Kigali",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w400, color: whiteColor, fontSize: 19),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),


        Positioned(
          top: 100,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.live_tv, size: 40, color: whiteColor,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Film Fan",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w900, color: whiteColor, fontSize: 28),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 60,
          left: 80,
          right: 80,
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (_) => Home()));
            },
            child: Container(
              width: 220,
              height: 50,
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: orangeColor,

              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Let's Get Started",style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500, color: whiteColor, fontSize: 17),),
                      Icon(Icons.arrow_forward, color: whiteColor,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
