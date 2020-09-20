
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cargoshuttle/constants.dart';
import 'package:cargoshuttle/screens/owner_registration_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';


class StaticScreenFleet extends StatelessWidget {
  static const String id = 'Static_Fleet';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: 400,
              child: Text.rich(
                TextSpan(
                  text: 'Transform you business with us, serve to a ',
                  style: TextStyle(fontSize: 25 , color: Colors.blue[900]),// default text style
                  children: <TextSpan>[
                    TextSpan(text: 'greater audience', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ', with our platform you can '),
                    TextSpan(text: 'grow ', style: TextStyle(fontWeight: FontWeight.bold),),
                    TextSpan(text: 'your ', ),
                    TextSpan(text: 'business ', style: TextStyle(fontWeight: FontWeight.bold),),
                    TextSpan(text: 'using '),
                    TextSpan(text: 'latest technology ', style: TextStyle(fontWeight: FontWeight.bold),),
                    TextSpan(text: 'with no hassle. ',)
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),

            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 50),
              child: FloatingActionButton(
                backgroundColor: themeColor,
                child: Icon(
                  Icons.arrow_forward,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                      context, OwnerRegistrationScreen.id);
                },
              ),
            ),
            Container(child: Image.asset('assets/images/scootyboy.png'),
            height: 100,
            width: 100,),

          ],
        ),
      ),
    );
  }
}
