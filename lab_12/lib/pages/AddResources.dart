import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../class/machine.dart';
import '../class/recourses.dart';
import '../pages/CoffeeMaker.dart';

class AddResource extends StatefulWidget {
  final Resources res;
  const AddResource({Key? key, required this.res}) : super(key: key);

  @override
  State<AddResource> createState() => _AddResource();
}

class _AddResource extends State<AddResource> {
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

  final textControllerMilk = TextEditingController();
  final textControllerWater = TextEditingController();
  final textControllerBeans = TextEditingController();
  final textControllerCash = TextEditingController();
  String? errorText;

  void _onChanged(String text) {
    setState(() {
      if (text == '') {
        errorText = 'Введите значение';
      } else {
        errorText = null;
      }
    });
  }

  void _onSubmitted(String text) {
    setState(() {
      if (text == '') {
        errorText = 'Введите значение';
      } else {
        errorText = null;
      }
    });
  }

  void _onPressed() {
    setState(() {
      if (textControllerMilk.text == '') {
        errorText = 'Введите значение';
      } else {
        errorText = null;
      }
    });
  }

  void addResources() {
    setState(() {
      int cash;
      int milk;
      int water;
      int beans;
      cash = int.tryParse(textControllerCash.text) ?? 0;
      milk = int.tryParse(textControllerMilk.text) ?? 0;
      water = int.tryParse(textControllerWater.text) ?? 0;
      beans = int.tryParse(textControllerBeans.text) ?? 0;
      widget.res.addCash(cash);
      widget.res.addCoffeeBeans(beans);
      widget.res.addWater(water);
      widget.res.addMilk(milk);
      textControllerMilk.text = '';
      textControllerWater.text = '';
      textControllerBeans.text = '';
      textControllerCash.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          child: Container(
            width: double.infinity,
            height: 300,
            color: Colors.lime,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  children: [
                    windowWidget(250),
                  ],
                )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        textFieldWidget('Молоко', textControllerMilk),
        textFieldWidget('Вода', textControllerWater),
        textFieldWidget('Кофейные зерна', textControllerBeans),
        textFieldWidget('Деньги', textControllerCash),
        CircleAvatar(
            radius: 24,
            child: IconButton(
              onPressed: addResources,
              icon: const Icon(Icons.add),
              iconSize: 30,
              splashRadius: 30,
              padding: const EdgeInsets.all(0),
            ))
      ],
    );
  }

  Row textFieldWidget(String text, TextEditingController textController) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: textController,
              onChanged: _onChanged,
              onSubmitted: _onSubmitted,
              onEditingComplete: _onPressed,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: errorText,
                hintText: 'Введите $text',
              ),
            ),
          ),
        ),
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
                'Ресурсы',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            resourceWidget('Молоко: ${widget.res.milk}'),
            resourceWidget('Вода: ${widget.res.water}'),
            resourceWidget('Кофейные зерна: ${widget.res.coffeBeans}'),
            resourceWidget('Деньги: ${widget.res.cash}'),
          ],
        ),
      ),
    );
  }

  Padding resourceWidget(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
