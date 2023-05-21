class Resources {
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

  Resources(this._coffeBeans, this._milk, this._water, this._cash);

  void setResource(int res, int val) {
    switch (res) {
      case 1:
        _coffeBeans = coffeBeans + val;
        break;
      case 2:
        _milk = milk + val;
        break;
      case 3:
        _water = water + val;
        break;
      case 4:
        _cash = cash + val;
        break;
      default:
    }
  }

  @override
  String toString() {
    return 'Кофейных зерен: $_coffeBeans Молока: $_milk Воды: $_water Денег: $_cash';
  }
}
