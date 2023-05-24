enum CoffeeType { americano, espresso, cappucino }

extension ParseToString on CoffeeType {
  String toNewString() {
    return toString().split('.').last;
  }
}
