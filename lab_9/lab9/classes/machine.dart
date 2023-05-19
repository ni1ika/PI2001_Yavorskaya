import 'dart:io';

import 'package:flutter/foundation.dart';

class Machine {
  int _coffeBeans;
  int _milk;
  int _water;
  int _cash;

  int get coffeBeans => _coffeBeans;
  set coffeBeans(int val) {
    if (val >= 0) {
      _coffeBeans = val;
    }
  }

  int get milk => _milk;
  set milk(int val) {
    if (val >= 0) {
      _milk = val;
    }
  }

  int get water => _water;
  set water(int val) {
    if (val >= 0) {
      _water = val;
    }
  }

  int get cash => _cash;
  set cash(int val) {
    if (val >= 0) {
      _cash = val;
    }
  }

  Machine(this._coffeBeans, this._milk, this._water, this._cash);

  bool isAvailable() {
    if (_coffeBeans >= 50 && _water >= 100) {
      return true;
    }
    return false;
  }

  void subatractResouces() {
    _coffeBeans = _coffeBeans - 50;
    _water = _water - 100;
  }

  void makingCoffee() {
    if (isAvailable()) {
      subatractResouces();
      if (kDebugMode) {
        print("Кофе готов.");
      }
    } else {
      if (kDebugMode) {
        print(
            "Для приготовления кофе нужно 50 гр кофейный зёрен и 100 мл воды.\n");
        print("Кофейных зёрен: $_coffeBeans гр\n");
        print("Воды: $_water мл\n");
      }
    }
  }

  void setResource(int res, int val) {
    switch (res) {
      case 1:
        _coffeBeans = _coffeBeans + val;
        break;
      case 2:
        _milk = _milk + val;
        break;
      case 3:
        _water = _water + val;
        break;
      case 4:
        _cash = _cash + val;
        break;
      default:
        if (kDebugMode) {
          print("Выберите нужный ресурс.\n");
        }
    }
  }
}

void main() {
  var machine = Machine(1, 1, 1, 1);
  while (true) {
    if (kDebugMode) {
      print("Выберите действие: ");
      print("1. Добавить ресурсов");
      print("2. Сделать кофе");
      print("3. Выход");
    }

    var choice = int.parse(stdin.readLineSync()!);

    if (choice == 1) {
      if (kDebugMode) {
        print("Выберите нужный ресурс: ");
        print("1. Кофейные зерна");
        print("2. Молоко");
        print("3. Вода");
        print("4. Наличные");
      }

      var res = int.parse(stdin.readLineSync()!);

      if (kDebugMode) {
        print("Введите количество ресурса: ");
      }
      var val = int.parse(stdin.readLineSync()!);

      machine.setResource(res, val);
    } else if (choice == 2) {
      machine.makingCoffee();
    } else if (choice == 3) {
      break;
    } else {
      if (kDebugMode) {
        print("Выберите действие.");
      }
    }
  }
}
