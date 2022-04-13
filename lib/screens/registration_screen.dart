// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzapp/screens/home_screen.dart';
import 'package:quizzapp/screens/login_screen.dart';

import '../model/user_model.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController FirstNameController = new TextEditingController();
  final TextEditingController SecondNameController =
      new TextEditingController();
  final TextEditingController ConfirmpasswordController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final firstnameField = TextFormField(
      autofocus: false,
      controller: FirstNameController,
      onSaved: (value) {
        FirstNameController.text = value!;
      },
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter your first name");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a valid name (Min 3 char)");
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: "First Name",
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        errorStyle: TextStyle(color: Colors.black),
      ),
    );

    final SecondnameField = TextFormField(
      autofocus: false,
      controller: SecondNameController,
      onSaved: (value) {
        SecondNameController.text = value!;
      },
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter your second name");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a valid name (Min 3 char)");
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: "Second Name",
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        errorStyle: TextStyle(color: Colors.black),
      ),
    );
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }

        if (!RegExp("^[a-zA-Z0-9+_,-]+@[a-zA-Z0-9+_,-]+.[a-z]")
            .hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: "Email",
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        errorStyle: TextStyle(color: Colors.black),
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter your password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a valid password (Min 6 char)");
        }
      },
      controller: passwordController,
      obscureText: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: "Password",
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        errorStyle: TextStyle(color: Colors.black),
      ),
    );
    final confirmpasswordField = TextFormField(
      autofocus: false,
      validator: (value) {
        if (passwordController.text != passwordController.text) {
          return "Password don't match";
        }
        return null;
      },
      controller: ConfirmpasswordController,
      obscureText: true,
      onSaved: (value) {
        ConfirmpasswordController.text = value!;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: "Confirm Password",
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
    );
    final ConfirmButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: MaterialButton(
        onPressed: () {
          signUp(emailController.text, passwordController.text);
        },
        child: Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
      ),
    );
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 70, right: 300),
                          child: Icon(Icons.arrow_back))),
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Text(
                      'Create an Account:',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          firstnameField,
                          SizedBox(
                            height: 20,
                          ),
                          SecondnameField,
                          SizedBox(
                            height: 20,
                          ),
                          emailField,
                          SizedBox(
                            height: 20,
                          ),
                          passwordField,
                          SizedBox(
                            height: 20,
                          ),
                          confirmpasswordField,
                          SizedBox(
                            height: 30,
                          ),
                          ConfirmButton,
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling our firestore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    //writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.FirstName = FirstNameController.text;
    userModel.SecondName = SecondNameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => login()), (route) => false);
  }
}
