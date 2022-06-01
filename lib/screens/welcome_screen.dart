import 'package:animated_text_kit/animated_text_kit.dart';  //애니메이션 글자 패키지
import 'package:flutter/material.dart';  //대부분 앱에서 반드시 가져와야 하는 필수 패키지
import 'package:math_quiz_app/constants.dart';  //글자 스타일 저장한 파일
import 'package:math_quiz_app/screens/game_screen.dart';  //게임 스크린 파일

class  WelcomeScreen extends StatelessWidget {  //WelcomeScreen 클래스는 위젯 클래스 계승

  static final id = 'welcome_screen';  //welcome_screen 으로 이동하기 위한 변수

  @override  //WelcomeScreen 클래스에서 오버라이딩
  Widget build(BuildContext context) {  //WelcomeScreen 클래스에 위젯 생성
    return Scaffold(  //상중하로 나누어주는 Scaffold 위젯
      body: Container (  //중단에 박스 위젯
        
        //배경화면
        width: double.infinity,  //박스 최대로
        decoration: BoxDecoration(  //박스 디자인
          image: DecorationImage(  //박스 이미지
            image: AssetImage('images/JJanggu.jpg'),  //짱구 사진
            fit: BoxFit.cover,  //박스에 짱구사진 꽉 채우기
          ),
        ),
        
        //배경화면에 추가할 것
        child: GestureDetector(  //사용자 동작을 감지하는 위젯
          behavior: HitTestBehavior.translucent,  //터치 범위
          //배경화면 글자
          child: AbsorbPointer(  //터치 범위
            child: Column(  //열 정렬
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,  //세로축 기준 일정 간격으로 정렬
               crossAxisAlignment: CrossAxisAlignment.center,  //가로축 기준 가운데 정렬
               children: [  //여러 위젯 사용할 때
                 Text(  //글자 위젯
                        '짱구야\n숙제하자', //짱구야 숙제하자 (앱 이름)
                        textAlign: TextAlign.center, //가운데 정렬
                        style: kTitleTextStyle,  //글자 스타일
                       ),
             Container(  //박스 위젯
               child: AnimatedTextKit(  //글자 애니메이션 위젯
                 animatedTexts: [  //글자에 애니메이션 효과 적용
                   ColorizeAnimatedText(  //글자 색에 애니메이션 효과 적용
                       '\n\n\n\nTap to Start',  //내용
                       textStyle: KTapToStartTextStyle,  //글자 스타일
                       textAlign: TextAlign.center,  //가운데 정렬
                       colors: kColorizeAnimationColors)  //글자 색
                 ],
                 repeatForever: true,  //글자 애니메이션 반복
               ),
                )
            ],
        ),
          ),
          //클릭하면 게임 스크린으로 이동
          onTap: () {
            Navigator.pushNamed(context, GameScreen.id);
          },
         ),
        ),
    );
  }
}
