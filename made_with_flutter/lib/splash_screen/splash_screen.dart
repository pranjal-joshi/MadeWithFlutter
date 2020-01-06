
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:made_with_flutter/global_style.dart';
import 'package:made_with_flutter/helper.dart';
import 'package:made_with_flutter/login_screen/login_screen.dart';
import 'package:made_with_flutter/login_screen/login_screen_style.dart';
import 'package:made_with_flutter/onboarding_screen/onboarding_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  bool darkMode = false;

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: controller
    );

    animation.addStatusListener( (status) {
      if(status == AnimationStatus.completed) {
        //controller.reverse();
        Navigator.pushReplacement(context, PageTransition(
          child: OnboardingScreen(),
          type: PageTransitionType.rightToLeftWithFade,
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 800)
        ));
      }
      else if(status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    FlutterHelper flutterHelper = FlutterHelper(context);
    darkMode = flutterHelper.isDarkModeActive();

    ColorManager colorManager = ColorManager(accentColor, darkMode);

    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: colorManager.getLinearGradient(
              beginFrom: Alignment.topRight,
              endAt: Alignment.bottomLeft,
              fromColor: Colors.pink[500],
              toColor: Colors.blue[800],
            ),
            color: Colors.black,
          ),
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: animation,
            child: Center(
              child: Container(
                child: FlutterLogo(
                  size: screenWidth/2,
                  colors: Colors.amber,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}