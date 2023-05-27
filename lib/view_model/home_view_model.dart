
import 'package:flutter/material.dart';
import 'package:multiply/service/shared_preferences_service.dart';

class HomeViewModel extends ChangeNotifier{
  bool isLoading = false;
  SharedPreferencesService prefs = SharedPreferencesService();

  int amount = 0;
  int increment = 0;
  int decrement = 0;

  Future<void>setAll(int newAmount, int newIncrement, int newDecrement)async{
    await prefs.setAmount(newAmount);
    await prefs.setIncrement(newIncrement);
    await prefs.setDecrement(newDecrement);
    notifyListeners();
  }

  Future<void>  setAmount(int newAmount,)async{
    await prefs.setAmount(newAmount);
    notifyListeners();
  }

  Future<void>setIncrement(int newIncrement,)async{
    await prefs.setIncrement(newIncrement);
    notifyListeners();
  }

  Future<void>setDecrement(int newDecrement,)async{
    await prefs.setDecrement(newDecrement);
    notifyListeners();
  }

  Future<void>readAll()async{
    amount = await prefs.readAmount();
    increment = await prefs.readIncrement();
    decrement = await prefs.readDecrement();
    notifyListeners();
  }

  Future<void>readAmount()async{
    amount = await prefs.readAmount();
    notifyListeners();
  }


}