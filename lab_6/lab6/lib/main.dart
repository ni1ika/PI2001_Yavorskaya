import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
        appBar: AppBar(title: const Text('Калькулятор площади')),
        body: const MyCalulateArea())));

class MyCalulateArea extends StatefulWidget {
  const MyCalulateArea({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyCalulateAreaState();
}

class MyCalulateAreaState extends State<MyCalulateArea> {
  final _formKey = GlobalKey<FormState>();
  dynamic _width;
  dynamic _height;
  dynamic _area;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          Row(children: <Widget>[
            Container(
                padding: const EdgeInsets.all(10.0),
                child: const Text('Ширина (мм):')),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) return 'Задайте Ширину';

                    try {
                      _width = int.parse(value);
                    } catch (e) {
                      _width = null;
                      return e.toString();
                    }
                    return null;
                  },
                ),
              ),
            ),
          ]),
          const SizedBox(height: 10.0),
          Row(children: <Widget>[
            Container(
                padding: const EdgeInsets.all(10.0),
                child: const Text('Высота (мм):')),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(validator: (value) {
                      if (value!.isEmpty) return 'Задайте Высоту';
                      try {
                        _height = int.parse(value);
                      } catch (e) {
                        _height = null;
                        return e.toString();
                      }
                      return null;
                    }))),
          ]),
          const SizedBox(height: 10.0),
          ElevatedButton(
              style: const ButtonStyle(),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    if (_width is int && _height is int) {
                      _area = _width * _height;
                    }
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Успешное вычисление'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text(
                'Вычислить',
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(height: 50.0),
          Text(
            _area == null
                ? 'задайте параметры'
                : 'S = $_width * $_height = $_area (мм2)',
            style: const TextStyle(fontSize: 30.0),
          )
        ]));
  }
}
