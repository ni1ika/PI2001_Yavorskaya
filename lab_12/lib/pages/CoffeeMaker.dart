import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../class/machine.dart';
import '../class/recourses.dart';
import '../class/Enums.dart';
import '../class/asin.dart';
import '../class/Coffee.dart';

class CoffeeMaker extends StatefulWidget {
  final Resources res;
  const CoffeeMaker({Key? key, required this.res}) : super(key: key);

  @override
  State<CoffeeMaker> createState() => _CoffeeMaker();
}

class _CoffeeMaker extends State<CoffeeMaker> {
  late Machine machine;

  @override
  void initState() {
    super.initState();
    machine = Machine(widget.res);
  }

  int get milk => widget.res.milk;
  int get water => widget.res.water;
  int get coffeBeans => widget.res.coffeBeans;
  int get cash => widget.res.cash;

  void popUp(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> message(
      String text, int duration) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: duration),
      ),
    );
  }

  CoffeeType? coffeeType = CoffeeType.americano;
  final textController = TextEditingController();
  String? errorText;

  void _onChanged(String text) {
    setState(() {
      if (text.isEmpty || text == '0') {
        errorText = 'Пожалуйста, не забудьте положить деньги';
      } else {
        errorText = null;
      }
    });
  }

  void _onSubmitted(String text) {
    setState(() {
      if (text == '' || text == '0') {
        errorText = 'Пожалуйста, не забудьте положить деньги';
      } else {
        errorText = null;
      }
    });
  }

  void _onPressed() async {
    if (textController.text.isEmpty || textController.text == '0') {
      setState(() {
        errorText = 'Пожалуйста, не забудьте положить деньги';
      });
    } else {
      setState(() {
        errorText = null;
        widget.res.addCash(int.tryParse(textController.text)!);
        textController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
            child: Container(
          height: 300,
          color: Colors.lime,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                rowWidget('Кофейные зерна: ${widget.res.coffeBeans}'),
                rowWidget('Молоко: ${widget.res.milk}'),
                rowWidget('Вода: ${widget.res.water}'),
                const SizedBox(
                  height: 10,
                ),
                windowWidget(220),
              ],
            ),
          ),
        )),
        radioPickerWidget(),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
        textFieldWidget(),
      ],
    );
  }

  SizedBox windowWidget(double height) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Container(
        color: Colors.white60,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
              child: Text(
                'Coffe Maker',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'Ваши деньги: ${widget.res.cash}',
              style: const TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }

  Stack radioPickerWidget() {
    return Stack(children: [
      SizedBox(
        height: 160,
        child: ListView(
          children: [
            listTileWidget('Американо', CoffeeType.americano),
            listTileWidget('Капучино', CoffeeType.cappucino),
            listTileWidget('Эспрессо', CoffeeType.espresso),
          ],
        ),
      ),
      Positioned(
        right: 10,
        bottom: 0,
        child: CircleAvatar(
          radius: 25,
          child: IconButton(
              iconSize: 35,
              splashRadius: 30,
              padding: const EdgeInsets.all(0),
              onPressed: () async {
                var check = machine.makeCoffeeType(coffeeType!.toNewString());
                if (!check) {
                  popUp('Недостаточно ресурсов');
                } else {
                  message('Нагреваем воду', 3);
                  await makeWater();
                  message('Вода нагрета', 1);

                  message('Завариваем кофе', 5);
                  message('Начинаем взбивать молоко', 5);
                  await makeMilk();
                  message('Кофе заварен', 1);
                  message('Молоко взбито', 1);

                  message('Начинаем смешивать кофе и молоко', 3);
                  await cofeemilk();
                  message('Кофе готов', 3);
                }
              },
              icon: const Icon(Icons.play_arrow_rounded)),
        ),
      ),
    ]);
  }

  Row textFieldWidget() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: _onChanged,
              onSubmitted: _onSubmitted,
              onEditingComplete: _onPressed,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: textController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: errorText,
                hintText: 'Положите деньги',
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              widget.res.addCash(int.tryParse(textController.text)!);
              textController.text = '';
            });
          },
          icon: const Icon(Icons.money_rounded),
          iconSize: 30,
        ),
      ],
    );
  }

  ListTile listTileWidget(String title, CoffeeType value) {
    return ListTile(
      title: Text(title),
      leading: Radio<CoffeeType>(
        groupValue: coffeeType,
        value: value,
        onChanged: (CoffeeType? value) {
          setState(() {
            coffeeType = value;
          });
        },
      ),
    );
  }

  Row rowWidget(String text) {
    return Row(
      children: [
        Text(text),
      ],
    );
  }
}
