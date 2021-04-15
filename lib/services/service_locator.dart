import 'package:flutter_get_it/business_logic/view_models/counter_view_model.dart';
import 'package:get_it/get_it.dart';

var serviceLocator = GetIt.instance;

void serviceLocatorSetUp() {
  serviceLocator.registerFactory<CounterViewModel>(() => CounterViewModel());
}
