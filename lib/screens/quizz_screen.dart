// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:quizzapp/model/question_model.dart';
import 'package:quizzapp/screens/score_screen.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({Key? key}) : super(key: key);

  @override
  State<QuizzScreen> createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  final _auth = FirebaseAuth.instance;
  List images = [
    "images/db.png",
    "images/ios_android.jpg",
    "images/ios_android.jpg"
  ];
  @override
  static int qid = 0;
  static int score = 0;
  String? img;
  QuestionModel? quest;
  void initState() {
    super.initState();
    if (qid == 2) qid = 0;
    if (qid != 2) {
      FirebaseFirestore.instance
          .collection("questions")
          .doc((qid + 1).toString())
          .get()
          .then((value) {
        this.quest = QuestionModel.fromMap(value.data());
        img = quest?.img;
        setState(() {});
      });
    }
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
          SizedBox(height: 100),
          Text(
            "Question ${quest?.qid} :",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(letterSpacing: .5),
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.white),
          ),
          SizedBox(height: 30),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: Image.asset("${images[qid]}"),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "${quest?.Question}",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(letterSpacing: .5),
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: Colors.white),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
              onTap: () {
                CheckAnswer('${quest?.FirstAnswer}', '${quest?.GoodAnswer}');
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 10,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    '${quest?.FirstAnswer}',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(color: Colors.white, letterSpacing: .5),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              )),
          SizedBox(height: 30),
          GestureDetector(
              onTap: () {
                CheckAnswer('${quest?.SecondAnswer}', '${quest?.GoodAnswer}');
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 10,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    '${quest?.SecondAnswer}',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(color: Colors.white, letterSpacing: .5),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void CheckAnswer(String Answer, String GoodAnswer) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    var docRef;
    if (Answer == GoodAnswer) score++;
    if (qid < 2) {
      qid++;
    }
    if (qid >= 2) {
      docRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
      docRef.update({'Score': score});
      score = 0;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ScoreScreen()));
    }
    if (qid < 2)
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }
}
