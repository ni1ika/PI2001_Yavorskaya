import '../class/Enums.dart' show CoffeeType;

abstract class ICoffee {
  int coffeBeans();
  int milk();
  int water();
  int cash();

  static ICoffee getAmericano() {
    return CoffeAmericano();
  }

  static ICoffee getEspresso() {
    return CoffeEspresso();
  }

  static ICoffee getCappucino() {
    return CoffeCappucino();
  }
}

class CoffeAmericano implements ICoffee {
  final type = CoffeeType.americano;
  @override
  int coffeBeans() => 50;
  @override
  int milk() => 0;
  @override
  int water() => 180;
  @override
  int cash() => 110;
}

class CoffeEspresso implements ICoffee {
  final type = CoffeeType.espresso;
  @override
  int coffeBeans() => 25;
  @override
  int milk() => 0;
  @override
  int water() => 30;
  @override
  int cash() => 90;
}

class CoffeCappucino implements ICoffee {
  final type = CoffeeType.cappucino;
  @override
  int coffeBeans() => 25;
  @override
  int milk() => 200;
  @override
  int water() => 40;
  @override
  int cash() => 130;
}
