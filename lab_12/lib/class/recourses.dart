class Resources {
  int _coffeBeans;
  int _milk;
  int _water;
  int _cash;

  Resources(this._coffeBeans, this._milk, this._water, this._cash);

  int get coffeBeans => _coffeBeans;
  set setcoffeBeans(int val) {
    if (val >= 0) {
      _coffeBeans = val;
      _coffeBeans = _coffeBeans;
    }
  }

  int get milk => _milk;
  set setmilk(int val) {
    if (val >= 0) {
      _milk = val;
      _milk = _milk;
    }
  }

  int get water => _water;
  set setwater(int val) {
    if (val >= 0) {
      _water = val;
      _water = _water;
    }
  }

  int get cash => _cash;
  set setcash(int val) {
    if (val >= 0) {
      _cash = val;
      _cash = _cash;
    }
  }

  void addMilk(int val) {
    _milk = _milk + val;
  }

  void addCoffeeBeans(int val) {
    _coffeBeans = _coffeBeans + val;
  }

  void addWater(int val) {
    _water = _water + val;
  }

  void addCash(int val) {
    _cash = _cash + val;
  }

  void subMilk(int val) {
    _milk = _milk - val;
  }

  void subCoffeBeans(int val) {
    _coffeBeans = _coffeBeans - val;
  }

  void subWater(int val) {
    _water = _water - val;
  }

  void subCash(int val) {
    _cash = _cash - val;
  }

  @override
  String toString() {
    return 'Кофейных зерен: $_coffeBeans Молока: $_milk Воды: $_water Денег: $_cash';
  }
}
