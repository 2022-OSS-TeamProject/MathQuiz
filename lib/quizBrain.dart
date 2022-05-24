import 'dart:math';

class QuizBrain {

  var _quizAnswer = '';
  var _quiz = '';

  void makeQuiz() {
    List<String> _listOfSigns = ['+', '-', 'x', '÷']; //사칙연산 리스트
    Random _random = Random(); //Random함수 생성
    var selectedSign = _listOfSigns[_random.nextInt(_listOfSigns.length)];
    var firstNumber = _random.nextInt(10) + 10; //firstNumber는 10 ~ 19까지의 정수이다.
    var secondNumber = _random.nextInt(9) + 1; //firstNumber는 1 ~ 9까지의 정수이다.
    var realResult;

    switch (selectedSign) {
      case '+': //'+'일 경우 firstNumber(10~19)와 secondNumber(1~9)를 더한 값을 realResult변수에 저장한 뒤 switch문을 빠져나온다.
        realResult = firstNumber + secondNumber;
        break;

      case '-': //'-'일 경우 firstNumber(10~19)와 secondNumber(1~9)를 뺀 값을 realResult변수에 저장한 뒤 switch문을 빠져나온다.
        realResult = firstNumber - secondNumber;
        break;

      case 'x': //'x'일 경우 firstNumber(10~19)와 secondNumber(1~9)를 곱한 값을 realResult변수에 저장한 뒤 switch문을 빠져나온다.
        realResult = firstNumber * secondNumber;
        break;

      case '÷': //'÷'일 경우 firstNumber(10~19)와 secondNumber(1~9)를 나눈 값을 realResult변수에 저장한 뒤 switch문을 빠져나온다.
        {
          if (firstNumber % secondNumber != 0) { //firstNumber를 secondNumber로 나눌 때 나머지가 있는 경우
            if (firstNumber % 2 != 0) firstNumber++; // firstNumber가 홀수이면 1을 더해주고 짝수로 만들어준다.
            for (int i = secondNumber; i > 0; i--) {
              if (firstNumber % i == 0) { //i를 secondNumber부터 1씩 빼주면서 firstNumber를 나누었을 때 나머지가 없으면 그때의 i값을 secondNumber에 저장한 뒤 for문을 벗어난다.
                secondNumber = i;
                break;
              }
            }
          }
          realResult = firstNumber ~/ secondNumber; //realResult변수에 firstNumber와 secondNumber의 나눈 값을 저장해준다.
        }
    }

    var falseMaker = [-3, -2, -1, 1, 2, 3]; //falseMaker는 0을 제외한 -3부터 3까지의 정수를 포함한다.
    var randomlyChosen = falseMaker[_random.nextInt(falseMaker.length)];

    //0은 false를 의미하고, 1은 true answer를 의미한다.
    var trueOrFalseDecision = _random.nextInt(2); //0 or 1

    _quizAnswer = 'TRUE';
    if(trueOrFalseDecision == 0) {// false일 경우
      _quizAnswer = 'FALSE';
      realResult = realResult + randomlyChosen; //realResult에다가 randomlyChosen을 추가로 더하고 저장한다.
      if (realResult < 0) realResult = realResult + _random.nextInt(2) + 4;
      //만약 realResult가 0보다 작을 경우 0~1 중 하나의 값과 4를 추가로 더하고 저장한다.
    }

    _quiz = '$firstNumber $selectedSign $secondNumber = $realResult';
  }

  get quizAnswer => _quizAnswer;
  get quiz => _quiz;
}