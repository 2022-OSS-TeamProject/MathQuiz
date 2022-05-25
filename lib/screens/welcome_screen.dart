import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:math_quiz_app/constants.dart';
import 'package:math_quiz_app/screens/game_screen.dart';

class  WelcomeScreen extends StatelessWidget {

  static final id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/JJanggu.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: AbsorbPointer(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text(
                        '짱구야\n숙제하자', //짱구야 숙제하자 (앱 이름)
                        textAlign: TextAlign.center, //가운데 정렬
                        style: kTitleTextStyle,
                       ),
             Container(
               child: AnimatedTextKit(
                 animatedTexts: [
                   ColorizeAnimatedText(
                       '\n\n\n\nTap to Start',
                       textStyle: KTapToStartTextStyle,
                       textAlign: TextAlign.center,
                       colors: kColorizeAnimationColors)
                 ],
                 repeatForever: true,
               ),
                )
            ],
        ),
          ),
          onTap: () {
            Navigator.pushNamed(context, GameScreen.id);
          },
         ),
        ),
    );
  }
}
