import 'package:flutter/material.dart'; //플러터 기능 불러오기

const kColorizeAnimationColors = [ //welcome_screen에 나오는 게임 이름 색 모음
  Colors.redAccent,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.cyanAccent
];



const kFTGradientColors = [Color(0xEF4BA73C), Color(0xEF4BA73C)]; //false true button gradient colors

const kAnimationTextStyle = TextStyle( //애니메이션 텍스트 스타일
  fontSize: 70, //글자 크기
  fontWeight: FontWeight.bold, //글자 굵기
  fontFamily: 'Lobster', //폰트
);

const kTimerTextStyle = TextStyle( //타이머 텍스트 스타일
  fontWeight: FontWeight.bold, //글자 굵기
  fontSize: 36, //글자 크기
  fontFamily: 'Lobster', //폰트
);

const KTapToStartTextStyle = TextStyle( //"Tap To Start" 텍스트 스타일
    fontWeight: FontWeight.bold, //글자 굵기
    fontSize: 25, //글자 크기
    backgroundColor: Colors.white, //글자 배경 색
    color: Colors.black87, //글자 색
   );

const kScoreLabelTextStyle = TextStyle( //점수 텍스트 스타일
    fontSize: 28, //글자 크기
    color: Colors.orangeAccent, //글자 색 
    fontFamily: 'Press_Start_2P' //폰트
);

const kScoreIndicatorTextStyle = TextStyle( //스코어 인디케이터 텍스트 스타일
  fontSize: 38, //글자 크기
  color: Colors.black, //글자 색
  fontFamily: 'Press_Start_2P', //폰트
);

const kQuizTextStyle = TextStyle( //퀴즈 텍스트 스타일
  fontSize: 30, //글자 크기
  color: Colors.green, //글자 색
  fontFamily: 'Architects_Daughter', //폰트
);

const kButtonTextStyle = TextStyle( //버튼 텍스트 스타일
  fontSize: 40, //글자 크기
  fontFamily: 'Press_Start_2P', //폰트
);

const kTitleTS = TextStyle( //타이틀 텍스트 스타일
  fontSize: 32, //글자 크기
  color: Colors.orangeAccent, //글자 색
  fontFamily: 'Press_Start_2P', //폰트
);

const kContentTS = TextStyle( //컨텐츠 텍스트 스타일
    fontSize: 24, //글자 크기
    color: Colors.black87, //글자 색
    fontWeight: FontWeight.w500, //글자 굵기
    fontFamily: 'Lobster' //폰트
);

const kDialogButtonTS = TextStyle( //다이얼로그 버튼 텍스트 스타일
  fontSize: 15, //글자 크기
  fontFamily: 'Press_Start_2P', //폰트
  fontWeight: FontWeight.w700, //글자 굵기
  color: Colors.deepOrangeAccent, //글자 색
);