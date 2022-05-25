name: math_quiz_app #
description: A new Flutter project.

publish_to: 'none' # 

version: 1.0.0+1

environment:
  sdk: ">=2.16.2 <3.0.0"


dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.2
  animated_text_kit: ^4.2.1
  outline_gradient_button: ^2.0.0+1
  percent_indicator: ^4.0.1
  audioplayers: ^0.20.1
  shared_preferences: ^2.0.13

dev_dependencies:
  flutter_launcher_icons: ^0.9.2
  flutter_test:
    sdk: flutter

flutter_lints: ^1.0.0

flutter_icons:
  android: true
  ios: true
  image_path: "images/appIcon.JPG"

flutter:

  assets:
    - images/
    - assets/

  fonts:
    - family: Lobster
      fonts:
        - asset: fonts/Lobster-Regular.ttf

    - family: Architects_Daughter
      fonts:
        - asset: fonts/ArchitectsDaughter-Regular.ttf

    - family: Chakra_Petch
      fonts:
        - asset: fonts/ChakraPetch-Regular.ttf

    - family: Press_Start_2P
      fonts:
        - asset: fonts/PressStart2P-Regular.ttf

  uses-material-design: true