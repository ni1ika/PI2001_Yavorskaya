import 'dart:io';
import 'package:flutter/foundation.dart';
import '../class/asin.dart';
import '../class/Coffee.dart';
import '../class/recourses.dart';
import '../class/Enums.dart';
import '../pages/CoffeeMaker.dart';

class Machine {
  final Resources res;
  Machine(this.res);
  ICoffee? ctype;
  ICoffee cof(ICoffee val) {
    return ctype = val;
  }

  bool isAvailableResource() {
    if (res.coffeBeans >= ctype!.coffeBeans() &&
        res.water >= ctype!.water() &&
        res.milk >= ctype!.milk() &&
        res.cash >= ctype!.cash()) {
      return true;
    }
    return false;
  }

  Future<void> subatractResouces() async {
    int coffeBeans = ctype!.coffeBeans();
    res.subCoffeBeans(coffeBeans);
    int water = ctype!.water();
    res.subWater(water);
    int milk = ctype!.milk();
    res.subMilk(milk);
    int cash = ctype!.cash();
    res.subCash(cash);
    return;
  }

  // void makingCoffee(ICoffee coffee) {
  //   if (isAvailableResource(coffee)) {
  //     subatractResouces(coffee);
  //     if (kDebugMode) {
  //       print("Кофе готов.");
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print("Для приготовления кофе нужно:\n");
  //       print("Кофейных зёрен: ${coffee.coffeBeans()} гр\n");
  //       print("Воды: ${coffee.water()} мл\n");
  //       print("Молока: ${coffee.milk()} мл\n");
  //       print("Денег: ${coffee.cash()} руб\n");
  //     }
  //   }
  // }

  bool makeCoffeeType(String? type) {
    type = type!.toLowerCase();
    switch (type) {
      case 'americano':
        cof(CoffeAmericano());
        if (!isAvailableResource()) {
          return false;
        }
        subatractResouces();
        break;
      case 'espresso':
        cof(CoffeEspresso());
        if (!isAvailableResource()) {
          return false;
        }
        subatractResouces();
        break;
      case 'cappucino':
        cof(CoffeCappucino());
        if (!isAvailableResource()) {
          return false;
        }
        subatractResouces();
        break;
    }
    res.addMilk(0);
    return true;
  }
}

// void main() async {
//   var machine = Machine();
//   while (true) {
//     if (kDebugMode) {
//       print("Выберите действие: ");
//       print("1. Добавить ресурсов");
//       print("2. Сделать кофе");
//       print("3. Выход");
//     }

//     var choice = int.parse(stdin.readLineSync()!);

//     if (choice == 1) {
//       if (kDebugMode) {
//         print("Выберите нужный ресурс: ");
//         print("1. Кофейные зерна");
//         print("2. Молоко");
//         print("3. Вода");
//         print("4. Наличные");
//       }

//       var res = int.parse(stdin.readLineSync()!);

//       if (kDebugMode) {
//         print("Введите количество ресурса: ");
//       }
//       var val = int.parse(stdin.readLineSync()!);

//       machine.res.setResource(res, val);
//     } else if (choice == 2) {
//       if (kDebugMode) {
//         print("Выберите кофе:");
//         print("1. Американо");
//         print("2. Эспрессо");
//         print("3. Капучино");
//       }

//       var typeOfCoffee = int.parse(stdin.readLineSync()!);
//       machine.makeCoffeeType(typeOfCoffee);

//       if (typeOfCoffee == 1) {
//         if (kDebugMode) {
//           print('Начинаем готовить кофе');
//         }
//         await water();
//         await makeCofee();
//         if (kDebugMode) {
//           print('Кофе готов');
//         }
//       } else if (typeOfCoffee == 2) {
//         if (kDebugMode) {
//           print('Начинаем готовить кофе');
//         }
//         await water();
//         await makeCofee();
//         if (kDebugMode) {
//           print('Кофе готов');
//         }
//       } else if (typeOfCoffee == 3) {
//         if (kDebugMode) {
//           print('Начинаем готовить кофе');
//         }
//         await water();
//         await makeMilk();
//         await cofeemilk();
//         if (kDebugMode) {
//           print('Кофе готов');
//         }
//       }
//     } else if (choice == 3) {
//       break;
//     } else {
//       if (kDebugMode) {
//         print("Выберите действие.");
//       }
//     }
//   }
// }
