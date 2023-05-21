import "dart:async";

import "package:flutter/foundation.dart";

Future<void> water() async {
  if (kDebugMode) {
    print('Нагреваем воду');
  }
  var wait = Future<Object?>.delayed(const Duration(seconds: 3));
  await wait.then((_) => print('Вода нагрета'));
}

Future<void> makeCofee() async {
  if (kDebugMode) {
    print('Завариваем кофе');
  }
  var wait = Future<Object?>.delayed(const Duration(seconds: 5));
  await wait.then((_) => print('Кофе заварен'));
}

Future<void> makeMilk() async {
  if (kDebugMode) {
    print('Начинаем взбивать молоко');
  }
  await makeCofee();
  var wait = Future<Object?>.delayed(const Duration(seconds: 5));
  await wait.then((_) => print('Молоко взбито'));
}

Future<void> cofeemilk() async {
  if (kDebugMode) {
    print('Начинаем смешивать кофе и молоко');
  }
  var wait = Future<Object?>.delayed(const Duration(seconds: 3));
  await wait.then((_) => print('Кофе и молоко смешаны'));
}
