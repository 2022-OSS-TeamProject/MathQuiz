import 'package:flutter/material.dart';  //대부분 앱에서 반드시 가져와야 하는 필수 패키지
import 'screens/welcome_screen.dart';  //시작 스크린 파일
import 'package:math_quiz_app/screens/game_screen.dart';  //게임 스크린 파일
import 'package:flutter/services.dart';  //상단바(상태표시줄), 하단바(내비게이션 바) 관련 패키지

void main() {
  runApp(MathQuizApp());  //앱 실행
}

// 아래 네 줄 앱 메인페이지 만드는 법
class MathQuizApp extends StatelessWidget {  //MathQuizApp 클래스는 위젯 클래스 계승
  const MathQuizApp([Key? key]) : super(key: key);  //클래스에 어떤 패러미터를 넣을 수 있는지 정의
  @override  //MathQuizApp 클래스에서 오버라이딩
  Widget build(BuildContext context) {  //MathQuizApp 클래스에 위젯 생성

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);  //하단바 보이기 (상단바 없애기)
    return MaterialApp(  //디자인과 이동을 담당하는 MaterialApp
      debugShowCheckedModeBanner: false,  //디버그 표시 지우기
      initialRoute: WelcomeScreen.id,  //WelcomeScreen 에서 시작
      routes: {  //화면 이동을 위한 경로
        WelcomeScreen.id: (context) => WelcomeScreen(), //WelcomeScreen 경로
        GameScreen.id: (context) => GameScreen()  //GameScreen 경로
      },
    );
  }
}