
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
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
        controller.reverse();
        /*Navigator.pushReplacement(context, PageTransition(
          child: OnboardingScreen(),
          type: PageTransitionType.rightToLeftWithFade,
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 800)
        ));*/
      }
      else if(status == AnimationStatus.dismissed) {
        //controller.forward();
        Navigator.pushReplacement(context, PageTransition(
          child: OnboardingScreen(),
          type: PageTransitionType.rightToLeftWithFade,
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 800)
        ));
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
            color: darkMode ? Colors.black : Colors.white60,
          ),
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: animation,
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlutterLogo(
                      size: screenWidth/2.5,
                      colors: Colors.red,
                    ),
                    Container(
                      height: screenWidth / 10,
                    ),
                    GradientText(
                      "Made With Flutter",
                      style: TextStyle(
                        fontFamily: defaultFont,
                        fontSize: fontSizeXL*1.2,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0
                      ),
                      textAlign: TextAlign.center,
                      gradient: colorManager.getLinearGradient(
                        beginFrom: Alignment.topRight,
                        endAt: Alignment.bottomLeft,
                        fromColor: Colors.orange[500],
                        toColor: Colors.lightGreen[500],
                      ),
                    ),
                  ],
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