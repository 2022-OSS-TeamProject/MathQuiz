import 'dart:async'; //비동기 작업을 위한 기능 불러오기
import 'package:flutter/material.dart'; //플러터 기본 기능 불러오기
import 'package:flutter/services.dart'; //기본 기능 외에 필요한 기능 불러오기
import 'package:math_quiz_app/quizBrain.dart'; //퀴즈 로직 불러오기
import 'package:math_quiz_app/constants.dart'; //상수 파일 불러오기
import 'package:outline_gradient_button/outline_gradient_button.dart'; //테두리에 그라데이션을 넣을 수 있는 버튼 불러오기
import 'package:percent_indicator/percent_indicator.dart'; //원형의 줄어드는 애니메이터 불러오기
import 'package:audioplayers/audioplayers.dart'; //소리 효과 불러오기
import 'package:shared_preferences/shared_preferences.dart'; //값을 저장하기 위한 플러그인 불러오기

QuizBrain _quizBrain = QuizBrain();
int _score = 0;
int _highScore = 0;
double _value = 0;
int _falseCounter = 0;
int _totalNumberOfQuizzes = 0; //변수 초기화

class GameScreen extends StatefulWidget { //게임화면 클래스를 변경 가능한 위젯(StatefulWidget)으로 생성.
  static final id = 'game_screen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Timer _timer; //타이머 생성
  int _totalTime = 0;

  @override
  void initState() { //게임 초기화 함수
    super.initState(); //초기화
    startGame(); //게임 시작
  }

  void startGame() async {
    _quizBrain.makeQuiz();
    startTimer();
    _value = 1;
    _score = 0;
    _falseCounter = 0;
    _totalNumberOfQuizzes = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _highScore = preferences.getInt('highscore') ??
        0; //게임을 완전하게 종료했다가 실행했을 때에도 HIGHSCORE가 저장되도록 함.
  }

  void startTimer() { //타이머 시작
    const speed = Duration(milliseconds: 100); //타이머 속도 지정
    _timer = Timer.periodic(speed, (timer) {
      if (_value > 0) { //만약 값이 0보다 크면 실행
        setState(() {
          _value > 0.005
              ? _value -= 0.005
              : _value = 0; //시간이 끝났을 때 앱이 꺼지는 현상 방지. 숫자를 작게 입력할수록 천천히 줄어든다.
          _totalTime = (_value * 20 + 1)
              .toInt(); //1:0.005 = 200 -> 1 Second is 10 * 100 Millisecond -> 200:10 = 20.
        });
      } else { //그렇지 않으면
        setState(() {
          _totalTime = 0;
          showMyDialog();
          _timer.cancel(); //타이머 취소
        });
      }
    });
  }

  Future<void> showMyDialog() { //게임 종료시 팝업 생성 위한 함수
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //유저가 팝업에 있는 버튼을 눌러야만 한다.
        builder: (BuildContext context) {
          return AlertDialog( //팝엽 종류중 하나인 AlertDialog 생성.
            shape: RoundedRectangleBorder( //모서리가 둥근 사각형 생성
                borderRadius: BorderRadius.circular(
              25, //모서리 둥근 정도 설정
            )
            ),
            backgroundColor: Color(0xFF3D9262), //배경색 설정(초록색)
            title: FittedBox( //Padding이 어긋나지 않도록 맞춤 사각형 안에 글자 생성되도록 함.
              child: const Text('GAME OVER', //GAME OVER 글씨 나오게 하기
                  textAlign: TextAlign.center, style: kTitleTS), //가운데 정렬. 스타일은 상수 파일에 저장되어있음.
            ),
            content: Text('Score: $_score / $_totalNumberOfQuizzes', //GAME OVER 아래에 나오는 맞춘 문제 수 / 출제된 문제 수
                textAlign: TextAlign.center, style: kContentTS), //가운데 정렬. 스타일은 상수 파일에 저장되어있음.
            actions: [ //액션 취할 수 있도록 함(버튼 클릭 등)
              TextButton( //텍스트 버튼 생성
                onPressed: () { //버튼이 눌리도록 함
                  SystemNavigator.pop(); //버튼을 누르면 원하는 화면이 나오도록 함.
                },
                child: const Text('EXIT', style: kDialogButtonTS), //EXIT 글씨 나오게 하기. 스타일은 상수 파일에 저장되어있음.
              ),
              TextButton( //텍스트 버튼 생성
                onPressed: () { //버튼이 눌리도록 함
                  startGame(); //게임 시작 (PLAY AGAIN 버튼을 누른다면)
                  Navigator.of(context).pop(); //다시하기 버튼 눌러서 게임 재시작
                },
                child: const Text('PLAY AGAIN', style: kDialogButtonTS), //PLAY AGAIN 글씨 나오게 하기. 스타일은 상수 파일에 저장되어있음.
              ),
            ],
          );
        });
  }

  CircularPercentIndicator buildCircularPercentIndicator() { //원형의 인디케이터(다이얼 게이지) 생성
    return CircularPercentIndicator(
      radius: 65.0, //크기 설정
      lineWidth: 12, //굵기 설정
      percent: _value, //값 저장
      circularStrokeCap: CircularStrokeCap.round, //끝 모양을 둥글게 처리함.
      center: Text( //중앙에 텍스트 생성
        '$_totalTime', //남은 시간 숫자로 표현되도록 한다.
        style: kTimerTextStyle,
      ),
      //원 안에 줄어드는 숫자 표시
      progressColor: _value > 0.6
          ? Colors.lightGreen //값이 0.6 이상일 때 게이지 초록색으로 표시
          : _value > 0.3 //게이지가 0.3 이상일 때
          ? Colors.yellowAccent //노란색으로 표시
          : Colors.redAccent, //시간이 지남에 따라 인디케이터의 색이 초록색->노란색->빨간색으로 변함.
    );
  }

  Column getPortraitMode() { //세로모드 함수
    return Column( //위젯들이 어긋나지 않도록 열을 맞추기 위한 Column 생성
      children: [
        ScoreIndicators(), //점수 인디케이터 불러오기
        QuizBody(), //퀴즈 몸체 불러오기(문제가 출제되는 부분)
        Expanded(flex: 3, child: buildCircularPercentIndicator()), //확장 & 여윳값 설정
        Expanded(
          flex: 3, //확장 & 여윳값 설정
          child: Row( //위젯들이 어긋나지 않도록 행을 맞추기 위한 Row 생성
            children: [
              ReUsableOutlineButton( //여러번 사용 가능한 버튼 생성
                  color: Colors.redAccent, userChoice: 'FALSE'), //빨간색 FALSE 텍스트를 버튼 안에 생성
              ReUsableOutlineButton( //여러번 사용 가능한 버튼 생성
                  color: Colors.lightGreenAccent, userChoice: 'TRUE'),//초록색 TRUE 텍스트를 버튼 안에 생성
            ],
          ),
        ),
      ],
    );
  }

  Row getLandscapeMode() { //가로모드 함수
    return Row( //위젯들이 어긋나지 않도록 행으 맞추기 위한 Row 생성
      children: [
        ReUsableOutlineButton( //여러번 사용 가능한 버튼  생성
            userChoice: 'FALSE', color: Colors.redAccent), //빨간색 FALSE 텍스트를 버튼 안에 생성
        Expanded(
          flex:3, //확장 & 여윳값 설정
            child: Column( //위젯들이 어긋나지 않도록 열을 맞추기 위한 Column 생성
              children: [
              ScoreIndicators(), //점수 인디케이터 불러오기
              QuizBody(), //퀴즈 몸체 불러오기(문제가 출제되는 부분)
                Expanded(flex: 3, child: buildCircularPercentIndicator()), //확장 & 여윳값 설정
          ],
        ),
        ),
        ReUsableOutlineButton( //여러번 사용 가능한 버튼  생성
            userChoice: 'TRUE', color: Colors.lightGreenAccent), //초록색 TRUE 텍스트를 버튼 안에 생성
      ],
    );
  }

  @override
  Widget build(BuildContext context) { //위젯 생성
    var data = MediaQuery.of(context);
    return Scaffold( //스캐폴드(임시 뼈대같은 것) 리턴값으로 설정
      body: Container( //컨테이너 생성
        decoration: BoxDecoration( //생성한 컨테이너 디자인
          color: Color(0xEFE6FFC7) //색 설정(옅은 초록색)
        ),
        child: getTrueMode(data),
      ),
    );
  }

  Widget getTrueMode(MediaQueryData data) {
    if (data.size.width < data.size.height) //데이터의 크기(화면에 보이는 크기. 글자, 버튼 등)가 가로 < 세로이면
      return getPortraitMode(); //세로모드 반환(호출)
    else //그렇지 않으면
      return getLandscapeMode(); //가로모드 반환(호출)
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  } //game screen에서 welcome screen으로 돌아올 시 timer가 background에서 작동되는 현상 방지
}

class ReUsableOutlineButton extends StatelessWidget {
  ReUsableOutlineButton({this.userChoice, this.color}); //userChoice, color을 변수로 설정

  final userChoice;
  final color; //두 값을 final 변수로 설정.

  Future<void> playSound(String soundName) async { //버튼 눌렀을 때 소리 나오도록 하는 함수 생성
    final _player = AudioCache();
    _player.play(soundName);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('highscore', _highScore);
  }

  void checkAnswer() { //답 확인하는 함수 생성
    if (userChoice == _quizBrain.quizAnswer) { //만약 유저가 고른 답이 정답이라면
      playSound('correct-choice.wav'); //정답을 맞추면 나오는 소리가 나오도록 함
      _score++; //점수 1점 증가
      _value >= 0.89 ? _value = 1 : _value += 0.1;
      if (_highScore < _score) { //만약 highScore가 score보다 작다면
        _highScore = _score; //score가 highScore로 되도록 한다. (highScore 갱신)
      }
    } else { //그렇지 않으면(틀린다면)
      playSound('wrong-choice.wav'); //오답을 고르면 나오는 소리가 나오도록 함
      _falseCounter++; //시스템 상에서 틀린 갯수 1씩 증가
      _value < 0.02 * _falseCounter
          ? _value = 0
          : _value -= 0.02 * _falseCounter;
    }
  }

  @override
  Widget build(BuildContext context) { //위젯 생성
    return Expanded(
      child: Padding( //각 요소들이 어긋나지 않도록 Padding 생성
        padding: const EdgeInsets.all(10.0), //모든 엣지(상하좌우) 간격 일정하게 조정
        child: OutlineGradientButton( //테두리를 그라데이션으로 디자인할 수 있는 버튼 생성
          padding: EdgeInsets.symmetric(horizontal: 20), //엣지 대칭으로 수평 간격 조정
          gradient: LinearGradient( //그라데이션 설정
            colors: kFTGradientColors, //상수 파일에 저장
          ),
          strokeWidth: 12, //테두리 굵기 설정
          child: Center(
              child: FittedBox(
            child: Text(
              userChoice, //유저가 선택한 것이 화면에 나오도록 함
              style: kButtonTextStyle.copyWith(color: color), //버튼 스타일 상수 파일에 저장
            ),
          )
          ),
          elevation: 1, //위로 올라와보이는 효과 약간 설정
          radius: Radius.circular(36), //모서리 둥근 정도 설정
          onTap: () { //버튼 눌리도록 함
            _totalNumberOfQuizzes++;
            checkAnswer(); //답변 체크
            _quizBrain.makeQuiz(); //퀴즈 만드는 함수 불러오기
          },
        ),
      ),
    );
  }
}

class QuizBody extends StatelessWidget { //퀴즈 몸체 클래스를 변경 불가능한 위젯(StatelessWidget)으로 생성.
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2, //여유 공간 만들기
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24), //엣지 대칭으로 수평 간격 조정
          child: Text( //텍스트 생성
            _quizBrain.quiz, //퀴즈 나오도록 함
            style: kQuizTextStyle, //스타일 상수 파일에 저장
          ),
        ),
      ),
    );
  }
}

class ScoreIndicators extends StatelessWidget { //점수 인디케이터 클래스를 변경 불가능한 위젯(StatelessWidget)으로 생성.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24), //위, 좌, 우 간격 일정하게 설정
      child: FittedBox(
          child: Row( //위젯들이 어긋나지 않도록 행을 맞추기 위한 Row 생성
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, //간격 일정하게 설정
        children: [
          ScoreIndicator(label: 'HIGHSCORE', score: '$_highScore'), //HIGHSCORE 텍스트 생성. 시스템에 저장된 값을 불러온다.
          SizedBox(width: 40), //박스 폭 설정
          ScoreIndicator(label: 'SCORE', score: '$_score') //SCORE 텍스트 생성. 시스템에 저장된 값을 불러온다.
        ],
      )),
    );
  }
}

class ScoreIndicator extends StatelessWidget { //점수 인디케이터 클래스를 변경 불가능한 위젯(StatelessWidget)으로 생성.
  ScoreIndicator({this.label, this.score}); //label, score 변수 생성

  final label;
  final score; //label, score 변수를 final로 설정

  @override
  Widget build(BuildContext context) {
    return Column( //위젯들이 어긋나지 않도록 열을 맞추기 위한 Column 생성
      children: [
        Text(label, style: kScoreLabelTextStyle),  //label 값 불러옴. 스타일은 상수 파일에 저장.
        SizedBox(height: 10), //박스 높이 설정
        Text(score, style: kScoreIndicatorTextStyle), //score 값 불러옴. 스타일은 상수 파일에 저장.
      ],
    );
  }
}