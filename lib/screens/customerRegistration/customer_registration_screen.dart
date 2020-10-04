import 'package:cargoshuttle/components/rounded_button_outline.dart';
import 'package:cargoshuttle/screens/registration_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cargoshuttle/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_screen.dart';
import 'customer_info_screen.dart';

class CustomerRegistrationScreen extends StatefulWidget {
  static const String id = 'customer_registration_screen';

  @override
  _CustomerRegistrationScreenState createState() =>
      _CustomerRegistrationScreenState();
}

final userRef = Firestore.instance.collection('customer');

class _CustomerRegistrationScreenState
    extends State<CustomerRegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  String password;
  String email;
  String name;
  String phone;

  final email1 = new TextEditingController();

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void createRecord() async {
    await userRef
        .document(email)
        .collection('Basic Data')
        .document(email)
        .setData({
      'password': password,
      'name': name,
      'email': email,
      'phone': phone
    }).then((value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('email', email);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => RegistrationHomeScreen()));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          else if(isNumeric(value.toString()) == true)
                            {
                              return "Please enter name in characters";
                            }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: email1,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                          assert(EmailValidator.validate(email));
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
                            ))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Correct email';
                          }
                          if (!RegExp(
                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value)) {
                            return 'Please enter a valid email Address';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.call,
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
                            ))),
                        validator: (value)
                          {
                            if(isNumeric(value.toString()) == false)
                            {
                              return "Please enter phone number in digits";
                            }
                            else if(isNumeric(value.toString()) == true)
                            {
                              if(value.length != 10)
                              {
                                return "please enter correct phone number";
                              }
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
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
                            ))),
                        validator: (value) => value.length < 6
                            ? "Enter Minimum 6 character password"
                            : null,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      RoundButton_outline(
                        text: 'REGISTER',
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              if (newUser != null) {
                                var emailEntered = email1.text;
                                createRecord();
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => CustomerInfoScreen(email1: emailEntered)));
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
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
      ),
    );
  }
}
