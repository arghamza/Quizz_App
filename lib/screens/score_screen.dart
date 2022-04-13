// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:quizzapp/screens/leaderboard.dart';
import 'package:quizzapp/screens/quizz_screen.dart';

import '../model/leaderbord_model.dart';
import '../model/user_model.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  int i = 0;
  double width = 60;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      i = loggedInUser.Score!;
      if (loggedInUser.Score == 0) width = 70;
      setState(() {});
    });
  }

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
          SizedBox(
            height: 50,
          ),
          Text(
            "Your score is: " + i.toString(),
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(letterSpacing: .5),
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.white),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80, left: width, right: 5),
                  child: Text(
                    "${i * 50}" + "%",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(letterSpacing: .5),
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: i / 2,
                    backgroundColor: Colors.white,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 223, 23, 90)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 180),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => QuizzScreen()));
            },
            child: Container(
              width: 200,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 6),
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(248, 236, 222, 90),
                    Colors.orange,
                    Colors.pink,
                    Colors.purple
                  ],
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.restart_alt_outlined,
                    size: 35,
                  ),
                  Center(
                    child: Text(
                      "Try Again",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          textStyle: TextStyle(letterSpacing: .5),
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LeaderboardScreen()));
            },
            child: Container(
              width: 260,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 6),
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(248, 236, 222, 90),
                    Colors.orange,
                    Colors.pink,
                    Colors.purple
                  ],
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.leaderboard,
                    size: 35,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Center(
                    child: Text(
                      "Leaderboard",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          textStyle: TextStyle(letterSpacing: .5),
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
