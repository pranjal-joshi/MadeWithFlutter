
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:made_with_flutter/global_style.dart';
import 'package:made_with_flutter/helper.dart';
import 'package:made_with_flutter/login_screen/login_screen_style.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  static Color mainLightColor = Colors.pink[400];
  static Color mainDarkColor = Colors.white;

  Color usernameTextFieldBorderColor;
  Color passwordTextFieldBorderColor;

  bool hidePassword = true;
  bool darkMode = false;

  @override
  void initState() {
    super.initState();

    usernameFocusNode.addListener(usernameFocusListener);
    passwordFocusNode.addListener(passwordFocusListener);
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bool keyboardVisibility = MediaQuery.of(context).viewInsets.bottom > 0;

    // Helper class objects
    FlutterHelper flutterHelper = FlutterHelper(context);
    darkMode = flutterHelper.isDarkModeActive();
    ColorManager colorManager = ColorManager(accentColor, darkMode);

    // Change color variables according to theme
    darkMode ? usernameTextFieldBorderColor = mainDarkColor : usernameTextFieldBorderColor = mainLightColor;
    darkMode ? passwordTextFieldBorderColor = mainDarkColor : passwordTextFieldBorderColor = mainLightColor;

    // Edit following variables if necessary
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double cardHeight = screenHeight * 0.6;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    double _animatedOpacity = 1;
    Future.delayed(Duration(milliseconds: 1000),(){
      setState(() {
        _animatedOpacity = 0;
      });
    });

    final tween = MultiTrackTween([
      Track("color1").add(
        Duration(seconds: 3),
        ColorTween(begin: Colors.purple[900], end: Colors.pink[700])
      ),
      Track("color2").add(
        Duration(seconds: 3),
        ColorTween(begin: Colors.red[900], end: Colors.blue[900])
      )
    ]);

    return Scaffold(
      body: ControlledAnimation(
        playback: Playback.MIRROR,
        tween: tween,
        duration: tween.duration,
        builder: (context, animation) {
          return Container(
            width: screenWidth,
            decoration: BoxDecoration(
              /*gradient: colorManager.getLinearGradient(
                beginFrom: Alignment.topRight,
                endAt: Alignment.bottomLeft,
                fromColor: Colors.pink[600],
                toColor: Colors.blue[600]
              ),*/
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [animation["color1"],animation["color2"]]
              )
            ),
            child: SafeArea(
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: screenHeight * 0.05,
                    left: marginLarge,
                    right: keyboardVisibility ? null : marginLarge,//marginLarge,
                    child: Column(
                      children: <Widget>[
                        FlutterLogo(
                          size: keyboardVisibility ? screenHeight * 0.1 : screenHeight * 0.2,
                          colors: Colors.amber,
                        ),
                        Padding(padding: EdgeInsets.only(
                            top: marginLarge
                          ),
                          child: Text(
                            keyboardVisibility ? "" : "Made With Flutter",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: defaultFont,
                              fontWeight: FontWeight.w600,
                              fontSize: fontSizeLarge*1.25,
                              letterSpacing: screenWidth * 0.0035
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Place a card design
                  Positioned(
                    bottom: -4,
                    left: -4, // compensate shifted card
                    child: Card(
                      borderOnForeground: true,
                      color: flutterHelper.isDarkModeActive() ? Colors.black.withOpacity(0.45) : Colors.white,
                      clipBehavior: Clip.antiAlias,
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(screenHeight*0.5)
                        )
                      ),
                      child: Container(
                        width: screenWidth,
                        height: cardHeight,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: marginLarge*4,
                              right: marginLarge,
                              child: AnimatedOpacity(
                                opacity: _animatedOpacity,
                                duration: Duration(milliseconds: 1000),
                                child: Text(
                                  "Welcome!",
                                  style: TextStyle(
                                    color: darkMode ? mainDarkColor : mainLightColor,
                                    fontFamily: defaultFont,
                                    fontSize: fontSizeXL,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2.0
                                  ),
                                ),
                              )
                            ),
                            // Add login FAB
                            Positioned(
                              bottom: 32,
                              right: 32,
                              child: FloatingActionButton(
                                backgroundColor: Colors.pink[500],
                                elevation: 2.0,
                                tooltip: "Login",
                                onPressed: () => onFabPressed(),
                                foregroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_forward,
                                  semanticLabel: "Login Button",
                                  size: 32,
                                ),
                              )
                            ),
                            // Add username textfield
                            Positioned(
                              top: cardHeight * 0.3,
                              left: screenWidth*0.25,
                              child: Container(
                                width: screenWidth*0.7,
                                child: TextField(
                                  controller: usernameController,
                                  focusNode: usernameFocusNode,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: usernameTextFieldBorderColor,
                                      size: 28,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(marginLarge*2),
                                      borderSide: BorderSide(
                                        color: usernameTextFieldBorderColor,
                                        width: 2.0
                                      )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(marginLarge*2),
                                      borderSide: BorderSide(
                                        color: usernameTextFieldBorderColor,
                                        width: 2.0
                                      )
                                    ),
                                    labelText: "Email or Phone number",
                                    labelStyle: TextStyle(
                                      color: usernameTextFieldBorderColor,
                                      fontFamily: defaultFont,
                                      letterSpacing: 0
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: defaultFont,
                                    color: usernameTextFieldBorderColor,
                                    letterSpacing: 0.5,
                                  ),
                                  cursorColor: usernameTextFieldBorderColor,
                                  onChanged: (val) => null,
                                  onSubmitted: (val) => FocusScope.of(context).requestFocus(passwordFocusNode),
                                ),
                              ),
                            ),
                            // Add a password textfield
                            Positioned(
                              top: cardHeight * 0.47,
                              left: screenWidth*0.15,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: screenWidth*0.7,
                                    child: TextField(
                                      controller: passwordController,
                                      focusNode: passwordFocusNode,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: passwordTextFieldBorderColor,
                                          size: 28,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(marginLarge*2),
                                          borderSide: BorderSide(
                                            color: passwordTextFieldBorderColor,
                                            width: 2.0
                                          )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(marginLarge*2),
                                          borderSide: BorderSide(
                                            color: passwordTextFieldBorderColor,
                                            width: 2.0
                                          )
                                        ),
                                        labelText: "Password",
                                        labelStyle: TextStyle(
                                          color: passwordTextFieldBorderColor,
                                          fontFamily: defaultFont,
                                          letterSpacing: 0
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontFamily: defaultFont,
                                        color: passwordTextFieldBorderColor,
                                        letterSpacing: 0.5,
                                      ),
                                      cursorColor: passwordTextFieldBorderColor,
                                      onChanged: (val) => null,
                                      obscureText: hidePassword,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTapDown: (details) => onPasswordPress(),
                                    onLongPressEnd: (det) => onPasswordRelease(),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: passwordTextFieldBorderColor,
                                      ),
                                      onPressed: () => null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: cardHeight * 0.6,
                              left: 0,
                              right: 0,
                              child: FlatButton(
                                onPressed: () => onForgotPassword(),
                                color: Colors.transparent,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: darkMode ? mainDarkColor : mainLightColor,
                                    fontFamily: defaultFont,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: marginLarge,
                              left: 0,
                              right: 0,
                              child: FlatButton(
                                onPressed: () => onGotoSignup(),
                                color: Colors.transparent,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Text(
                                  "I don't have an account",
                                  style: TextStyle(
                                    color: darkMode ? mainDarkColor : mainLightColor,
                                    fontFamily: defaultFont,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          );
        },
      ),
      
    );
  }

  void onFabPressed() {
    print("FAB Pressed");
  }

  void usernameFocusListener() {
    if(darkMode) {
      setState(() {
        if(usernameFocusNode.hasFocus) {
          usernameTextFieldBorderColor = mainDarkColor;
        }
        else {
          if(usernameController.text.isEmpty) {
            usernameTextFieldBorderColor = mainDarkColor.withOpacity(0.3);
          }
        }
      });
    }
    else {
      setState(() {
        if(usernameFocusNode.hasFocus) {
          usernameTextFieldBorderColor = mainLightColor;
        }
        else {
          if(usernameController.text.isEmpty) {
            usernameTextFieldBorderColor = mainLightColor.withOpacity(0.3);
          }
        }
      });
    }
  }

  void passwordFocusListener() {
    if(darkMode) {
      setState(() {
        if(passwordFocusNode.hasFocus) {
          passwordTextFieldBorderColor = mainDarkColor;
        }
        else {
          if(passwordController.text.isEmpty) {
            passwordTextFieldBorderColor = mainDarkColor.withOpacity(0.3);
          }
        }
      });
    }
    else {
      setState(() {
        if(passwordFocusNode.hasFocus) {
          passwordTextFieldBorderColor = mainLightColor;
        }
        else {
          if(passwordController.text.isEmpty) {
            passwordTextFieldBorderColor = mainLightColor.withOpacity(0.3);
          }
        }
      });
    }
  }

  void onPasswordPress() {
    setState(() {
      hidePassword = false;
    });
  }

  void onPasswordRelease() {
    setState(() {
      hidePassword = true;
    });
  }

  void onForgotPassword() {
    print("Forgot Password");
  }

  void onGotoSignup() {
    print("Goto Signup Screen");
  }

}