import 'package:cargoshuttle/components/rounded_button_outline.dart';
import 'package:cargoshuttle/screens/registration_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cargoshuttle/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'owner_info_screen1.dart';

class OwnerRegistrationScreen extends StatefulWidget {
  static const String id = 'owner_registration_screen';

  @override
  _OwnerRegistrationScreenState createState() =>
      _OwnerRegistrationScreenState();
}

final userRef = Firestore.instance.collection('fleet owners');

class _OwnerRegistrationScreenState extends State<OwnerRegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  String password;
  String email;
  String name;
  String contactNumber;

  final email1 = new TextEditingController();

  void createRecord() async {
    await userRef
        .document(email)
        .collection('Basic Data')
        .document(email)
        .setData({
      'password': password,
      'name': name,
      'email': email,
      'contact_no': contactNumber
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationHomeScreen.id);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        child: SvgPicture.asset(
                          'assets/images/registration image.svg',
                          height: 300,
                          width: 300,
                        ),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          hintText: "fullname",
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: misc,
                            width: 5,
                          )),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: misc,
                              width: 5,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: email1,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          hintText: "email address",
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: misc,
                            width: 5,
                          )),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: misc,
                              width: 5,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        contactNumber = value;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          hintText: "contact number",
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: misc,
                            width: 5,
                          )),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: misc,
                              width: 5,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: "create password",
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: misc,
                            width: 5,
                          )),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: misc,
                              width: 5,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    RoundButton_outline(
                      text: 'REGISTER',
                      onPressed: () async {
                        var emailEntered = email1.text;
                        // createRecord();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => OwnerInfoScreen1(
                        //       email1: emailEntered,
                        //     ),
                        //   ),
                        // );
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            createRecord();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OwnerInfoScreen1(
                                  email1: emailEntered,
                                ),
                              ),
                            );
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}