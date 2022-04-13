// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 46, 45, 45),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientText(
              "QuizzApp",
              gradient: LinearGradient(colors: [
                Color.fromARGB(248, 236, 222, 90),
                Colors.orange,
                Colors.pink,
                Colors.purple
              ]),
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(letterSpacing: .5),
                  fontWeight: FontWeight.w600,
                  fontSize: 30),
            ),
            Container(
                width: 50,
                height: 50,
                child: Image.asset("images/whitebrain.png"))
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Text(
            "Leaderbord:",
            style: GoogleFonts.montserrat(
                color: Colors.white,
                textStyle: TextStyle(letterSpacing: .5),
                fontWeight: FontWeight.w600,
                fontSize: 30),
          ),
          SizedBox(height: 50),
          Container(
            height: MediaQuery.of(context).size.height - 250,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 8,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 34, 32, 32),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(children: [
                          Container(
                            width: 75,
                            height: 75,
                            margin: EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                                backgroundColor: Colors.amber,
                                child: Text(
                                  'HA',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 23),
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'Hamza',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.white, letterSpacing: .5),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 150),
                            child: Text(
                              '2',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.white, letterSpacing: .5),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23),
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
