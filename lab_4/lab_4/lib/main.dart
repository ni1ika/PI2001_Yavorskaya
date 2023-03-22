import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Общежития КУБГАУ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/images/obschaga.jpg",
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 30, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          'Общежитие №20                    ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          'Краснодар, ул. Калинина, 13',
                          style: TextStyle(
                            color: Colors.grey,
                            height: 1.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //LIKE BUTTON
                Container(
                  padding: const EdgeInsets.only(left: 90, top: 35),
                  child: LikeButton(
                    size: 25,
                    likeCount: 26,
                    circleColor:
                        const CircleColor(start: Colors.white, end: Colors.red),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Colors.white,
                      dotSecondaryColor: Colors.white,
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked
                            ? const Color.fromARGB(255, 214, 53, 42)
                            : Colors.grey,
                        size: 25,
                      );
                    },
                  ),
                ),
              ],
            ),
            // кнопки
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //звонок
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            Share.share('+79184428318');
                          },
                          icon: const Icon(
                            Icons.call,
                            color: Colors.green,
                            size: 30,
                          )),
                      const Text(
                        "ПОЗВОНИТЬ",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
                //маршрут
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  child: Column(
                    children: <Widget>[
                      Transform.rotate(
                        angle: 205,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: IconButton(
                            onPressed: () {
                              Share.share('г. Краснодар, ул. Калинина, 13');
                            },
                            icon: const Icon(
                              Icons.navigation,
                              color: Colors.green,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        "МАРШРУТ",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      )
                    ],
                  ),
                ),
                //поделиться
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Share.share('Общежитие КубГАУ №20');
                        },
                        icon: const Icon(
                          Icons.share,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      const Text(
                        "ПОДЕЛИТЬСЯ",
                        style: TextStyle(color: Colors.green, fontSize: 13),
                      )
                    ],
                  ),
                ),
              ],
            ),
            //текст
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: const Text(
                      '«Студенческий городок или так называемый кампус Кубанского ГАУ состоит'
                      'из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В соответствии с Положением о студенческих общежитиях'
                      'университета, при поселении между администрацией и студентами заключается'
                      'договор найма жилого помещения. Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия'
                      'асоциальных явлений в молодежной среде. Условия проживания в общежитиях'
                      'университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и'
                      'наглядной агитации. С целью улучшения условий быта студентов активно работает'
                      'система студенческого самоуправления - студенческие советы организуют всю работу по самообслуживанию.».',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 15, height: 1.3),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
