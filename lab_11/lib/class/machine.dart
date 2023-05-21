import 'dart:io';
import 'package:flutter/foundation.dart';
import '../class/asin.dart';
import '../class/Coffee.dart';
import '../class/recourses.dart';

class Machine {
  final res = Resources(50, 200, 250, 350);

  @override
  String toString() {
    return 'Кофейных зерен: ${res.coffeBeans} Молока: ${res.milk} Воды: ${res.water} Денег: ${res.cash}';
  }

  bool isAvailableResource(ICoffee coffee) {
    if (res.coffeBeans >= coffee.coffeBeans() &&
        res.water >= coffee.water() &&
        res.milk >= coffee.milk() &&
        res.cash >= coffee.cash()) {
      return true;
    }
    return false;
  }

  void subatractResouces(ICoffee coffee) {
    res.coffeBeans = res.coffeBeans - coffee.coffeBeans();
    res.water = res.water - coffee.water();
    res.milk = res.milk - coffee.milk();
    res.cash = res.cash - coffee.cash();
  }

  void makingCoffee(ICoffee coffee) {
    if (isAvailableResource(coffee)) {
      subatractResouces(coffee);
      if (kDebugMode) {
        print("Кофе готов.");
      }
    } else {
      if (kDebugMode) {
        print("Для приготовления кофе нужно:\n");
        print("Кофейных зёрен: ${coffee.coffeBeans()} гр\n");
        print("Воды: ${coffee.water()} мл\n");
        print("Молока: ${coffee.milk()} мл\n");
        print("Денег: ${coffee.cash()} руб\n");
      }
    }
  }

  void makeCoffeeType(int type) {
    switch (type) {
      case 1:
        makingCoffee(ICoffee.getAmericano());
        break;
      case 2:
        makingCoffee(ICoffee.getEspresso());
        break;
      case 3:
        makingCoffee(ICoffee.getCappucino());
        break;
      default:
        if (kDebugMode) {
          print("Неправильно выбран кофе!");
        }
    }
  }
}

void main() async {
  var machine = Machine();
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

      machine.res.setResource(res, val);
    } else if (choice == 2) {
      if (kDebugMode) {
        print("Выберите кофе:");
        print("1. Американо");
        print("2. Эспрессо");
        print("3. Капучино");
      }

      var typeOfCoffee = int.parse(stdin.readLineSync()!);
      machine.makeCoffeeType(typeOfCoffee);

      if (typeOfCoffee == 1) {
        if (kDebugMode) {
          print('Начинаем готовить кофе');
        }
        await water();
        await makeCofee();
        if (kDebugMode) {
          print('Кофе готов');
        }
      } else if (typeOfCoffee == 2) {
        if (kDebugMode) {
          print('Начинаем готовить кофе');
        }
        await water();
        await makeCofee();
        if (kDebugMode) {
          print('Кофе готов');
        }
      } else if (typeOfCoffee == 3) {
        if (kDebugMode) {
          print('Начинаем готовить кофе');
        }
        await water();
        await makeMilk();
        await cofeemilk();
        if (kDebugMode) {
          print('Кофе готов');
        }
      }
    } else if (choice == 3) {
      break;
    } else {
      if (kDebugMode) {
        print("Выберите действие.");
      }
    }
  }
}
