import 'package:flutter/material.dart';
import 'package:flutter_get_it/business_logic/models/counter_model.dart';

class CounterViewModel extends ChangeNotifier {
  CounterModel _modelCounter = CounterModel(0);
  CounterModel get m_counter => this._modelCounter;

  int _counter = 0;
  int get counter => this._counter;

  incrementCounter() {
    _counter = _counter + 1;
    _modelCounter.count = _modelCounter.count + 2;

    notifyListeners();
  }

  void decrementCounter() {
    this._counter--;
    notifyListeners();
  }
}
