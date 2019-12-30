
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import '../global_style.dart';
import '../global_style.dart';
import '../global_style.dart';
import '../global_style.dart';
import '../global_style.dart';
import '../global_style.dart';

class OnboardingScreen extends StatelessWidget {

  final onboardingPages = [
    PageViewModel(
      pageColor: Colors.blue[600],
      mainImage: Padding(
        padding: EdgeInsets.all(marginLarge),
        child: SvgPicture.asset(
          "lib/assets/images/ob1.svg",
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
        ),
      ),
      title: Text("Ideas!"),
      body: Text("Always think something new when it comes to the UI/UX."),
      titleTextStyle: TextStyle(
        fontFamily: defaultFont,
        fontSize: fontSizeLarge*2,
        letterSpacing: 1.0,
        color: Colors.white
      ),
      bodyTextStyle: TextStyle(
        fontFamily: defaultFont,
        fontSize: fontSizeLarge,
        letterSpacing: 1.0,
        color: Colors.white
      )
    ),
    PageViewModel(
      pageColor: Colors.teal[600],
      mainImage: Padding(
        padding: EdgeInsets.all(marginLarge),
        child: SvgPicture.asset(
          "lib/assets/images/ob2.svg",
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
        ),
      ),
      title: Text("Imagine!"),
      body: Text("Draw a picture in your mind\n\nHow your screen should look like?"),
      titleTextStyle: TextStyle(
        fontFamily: defaultFont,
        fontSize: fontSizeLarge*2,
        letterSpacing: 1.0,
        color: Colors.white
      ),
      bodyTextStyle: TextStyle(
        fontFamily: defaultFont,
        fontSize: fontSizeLarge,
        letterSpacing: 1.0,
        color: Colors.white
      )
    ),
    PageViewModel(
      pageColor: Colors.indigo[600],
      mainImage: Padding(
        padding: EdgeInsets.all(marginLarge),
        child: SvgPicture.asset(
          "lib/assets/images/ob3.svg",
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
        ),
      ),
      title: Text("Innovate!"),
      body: Text("Tinker with the building blocks to achieve smooth and unique user experience!"),
      titleTextStyle: TextStyle(
        fontFamily: defaultFont,
        fontSize: fontSizeLarge*2,
        letterSpacing: 1.0,
        color: Colors.white
      ),
      bodyTextStyle: TextStyle(
        fontFamily: defaultFont,
        fontSize: fontSizeLarge,
        letterSpacing: 1.0,
        color: Colors.white
      )
    ),
    PageViewModel(
      pageColor: Colors.purple[600],
      mainImage: Padding(
        padding: EdgeInsets.all(marginLarge),
        child: SvgPicture.asset(
          "lib/assets/images/ob4.svg",
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
        ),
      ),
      title: Text("Implement!"),
      body: Text("Start Working!\n\nCode-Check-Modify-Repeate"),
      titleTextStyle: TextStyle(
        fontFamily: defaultFont,
        fontSize: fontSizeLarge*2,
        letterSpacing: 1.0,
        color: Colors.white
      ),
      bodyTextStyle: TextStyle(
        fontFamily: defaultFont,
        fontSize: fontSizeLarge,
        letterSpacing: 1.0,
        color: Colors.white
      )
    ),
    PageViewModel(
      pageColor: Colors.orange[400],
      mainImage: Padding(
        padding: EdgeInsets.all(marginLarge),
        child: SvgPicture.asset(
          "lib/assets/images/ob5.svg",
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
        ),
      ),
      title: Text("Improvise!"),
      body: Text("Review and Share your layout with people.\nLearn from their feedback!"),
      titleTextStyle: TextStyle(
        fontFamily: defaultFont,
        fontSize: fontSizeLarge*2,
        letterSpacing: 1.0,
        color: Colors.white
      ),
      bodyTextStyle: TextStyle(
        fontFamily: defaultFont,
        fontSize: fontSizeLarge,
        letterSpacing: 1.0,
        color: Colors.white
      ),
      
    ),
  ];

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: IntroViewsFlutter(
        onboardingPages,
        doneButtonPersist: false,
        showSkipButton: true,
        onTapDoneButton: () {
          Navigator.pushReplacementNamed(context, "\login_screen");
        },
        onTapSkipButton: () {
          Navigator.pushReplacementNamed(context, "\login_screen");
        },
      ),
    );
  }

}