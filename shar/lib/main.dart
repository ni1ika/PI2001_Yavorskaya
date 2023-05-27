import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shar/colors.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() => runApp(const MagicBallApp());

class MagicBallApp extends StatelessWidget {
  const MagicBallApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Шар предсказаний',
      theme: ThemeData(
        primarySwatch: primary,
      ),
      home: const MagicBallPage(),
    );
  }
}

class MagicBallPage extends StatefulWidget {
  const MagicBallPage({Key? key}) : super(key: key);

  @override
  MagicBallPageState createState() => MagicBallPageState();
}

class MagicBallPageState extends State<MagicBallPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  stt.SpeechToText speechToText = stt.SpeechToText();
  String _currentQuestion = 'Задайте свой вопрос:';
  String _spokenQuestion = '';
  bool _isListening = false;

  List<String> predictions = [
    'Бесспорно',
    'Предрешено',
    'Никаких\nсомнений',
    'Определённо да',
    'Можешь быть\nуверен в этом',
    'Мне кажется\n«да»',
    'Вероятнее\nвсего',
    'Хорошие\nперспективы',
    'Знаки говорят\n«да»',
    'Да',
    'Пока не ясно,\nпопробуй снова',
    'Спроси позже',
    'Лучше не\nрассказывать',
    'Сейчас нельзя\nпредсказать',
    'Сконцентрируйся\nи спроси опять',
    'Даже не думай',
    'Мой ответ\n«нет»',
    'По моим данным\n«нет»',
    'Перспективы\nне очень хорошие',
    'Весьма\nсомнительно',
  ];

  String currentPrediction = '';
  bool showPrediction = false;
  bool canShakeBall = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );
    _animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          currentPrediction = getRandomPrediction();
          showPrediction = true;
          canShakeBall = false; // Отключаем возможность нажимать на шар
        });
      }
    });
  }

  String getRandomPrediction() {
    Random random = Random();
    int randomIndex = random.nextInt(predictions.length);
    return predictions[randomIndex];
  }

  void shakeBall() {
    if (!canShakeBall) {
      return;
    }
    setState(() {
      showPrediction = false;
      canShakeBall = false;
    });
    _controller!.reset();
    _controller!.forward();
  }

  void resetBall() {
    setState(() {
      showPrediction = false;
      currentPrediction = '';
      canShakeBall = true; // Включаем возможность нажимать на шар
      _currentQuestion =
          'Задайте свой вопрос:'; // Обновляем текст текущего вопроса
    });
    _controller!.reset();
  }

  void startListening() async {
    if (_isListening) {
      return;
    }

    bool available = await speechToText.initialize(
      onStatus: (status) {
        if (status == 'notListening') {
          stopListening();
        }
      },
      onError: (error) {
        if (kDebugMode) {
          print('Ошибка распознавания голоса: $error');
        }
        stopListening();
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
        _currentQuestion = 'Слушаю...';
      });
      speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            setState(() {
              _spokenQuestion = result.recognizedWords;
              _currentQuestion = _spokenQuestion.isNotEmpty
                  ? _spokenQuestion
                  : 'Задайте свой вопрос:';
              stopListening();
              shakeBall();
            });
          }
        },
      );
    } else {
      if (kDebugMode) {
        print('Распознавание голоса недоступно');
      }
    }
  }

  void stopListening() {
    if (!_isListening) {
      return;
    }

    speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шар предсказаний'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/phon.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _currentQuestion,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: canShakeBall
                    ? startListening
                    : null, // Изменено для отключения нажатия на шар
                child: RotationTransition(
                  turns: _animation!,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        showPrediction
                            ? 'assets/second_magic_ball.png'
                            : 'assets/first_magic_ball.png',
                        width: 450,
                      ),
                      if (showPrediction)
                        Text(
                          currentPrediction,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (showPrediction)
                ElevatedButton(
                  onPressed: resetBall,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
