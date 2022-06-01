import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1;

  int get selectedMenuOpts {
    return _selectedMenuOpt;
  }

  set selectedMenuOpt(int value) {
    _selectedMenuOpt = value;
    notifyListeners();
  }
}
