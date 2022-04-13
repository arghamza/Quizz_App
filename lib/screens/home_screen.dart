// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzapp/screens/login_screen.dart';
import 'package:quizzapp/screens/quizz_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';

import '../model/user_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  var locationMessage = '';
  double? latitude;
  double? longitude;
  String Adresse = 'search';

  // function for getting the current location
  // but before that you need to add this permission!
  void getcity() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude!, longitude!);
    print(placemarks);
    Placemark placemark = placemarks[0];
    setState(() {
      Adresse = '${placemark.country},${placemark.locality} ';
    });
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    // passing this to latitude and longitude strings
    latitude = lat;
    longitude = long;

    setState(() {
      locationMessage = "Latitude: $lat and Longitude: $long";
    });
  }

  // function for opening it in google maps

  void googleMap() async {
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=" +
        latitude.toString() +
        "," +
        longitude.toString();
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else
      throw ("Couldn't open google maps");
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getcity();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 35, 35),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.orange, Colors.pink, Colors.purple],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 200,
                      child: Column(
                        children: [
                          Image.asset("images/brain.png"),
                          Text(
                            'Quizz App',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black, letterSpacing: .5),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        logout(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 380, left: 30),
                        child: Icon(
                          Icons.logout,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Welcome",
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(color: Colors.black, letterSpacing: .5),
                      fontWeight: FontWeight.w600,
                      fontSize: 40),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${loggedInUser.FirstName} ${loggedInUser.SecondName}",
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(color: Colors.black, letterSpacing: .5),
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                Text(
                  Adresse,
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(color: Colors.black, letterSpacing: .5),
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    googleMap();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 6),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Open in Google Maps",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black, letterSpacing: .5),
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        Icon(Icons.map_outlined),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                GestureDetector(
                    onTap: () {
                      FirebaseFirestore firebaseFirestore =
                          FirebaseFirestore.instance;
                      var docRef;
                      docRef = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user?.uid);
                      docRef.update({'Adresse': Adresse});
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => QuizzScreen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Start the quizz',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.white, letterSpacing: .5),
                              fontWeight: FontWeight.w600,
                              fontSize: 30),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => login()));
  }
}
