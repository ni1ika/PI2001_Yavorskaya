import 'package:flutter/material.dart';
import '../class/machine.dart';
import '../class/recourses.dart';
import '../pages/AddResources.dart';
import '../pages/CoffeeMaker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Machine? machine;
  Resources res = Resources(0, 0, 0, 0); // Создаем экземпляр Resources

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Кофемашина'),
          backgroundColor: Colors.brown,
          bottom: const TabBar(
            tabs: [
              Icon(Icons.coffee_maker),
              Icon(Icons.add),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CoffeeMaker(res: res),
            AddResource(res: res),
          ],
        ),
      ),
    );
  }
}
