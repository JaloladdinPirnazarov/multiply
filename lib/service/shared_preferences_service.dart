import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPreferencesService{
  SharedPreferences? _prefs;
  String amountKey = "amount_key";
  String incrementKey = "increment_key";
  String decrementKey = "decrement_key";


  Future<SharedPreferences>getPrefs()async{
    if(_prefs == null){
      _prefs = await SharedPreferences.getInstance();
      return _prefs!;
    }else{
      return _prefs!;
    }
  }

  Future<void>setAmount(int amount)async{
    var pref = await getPrefs();
    await pref.setInt(amountKey, amount);
  }

  Future<void>setIncrement(int increment)async{
    var pref = await getPrefs();
    await pref.setInt(incrementKey, increment);
  }

  Future<void>setDecrement(int decrement)async{
    var pref = await getPrefs();
    await pref.setInt(decrementKey, decrement);
  }

  Future<int>readAmount()async{
    var pref = await getPrefs();
    return pref.getInt(amountKey) ?? 0;
  }

  Future<int>readIncrement()async{
    var pref = await getPrefs();
    return pref.getInt(incrementKey) ?? 0;
  }

  Future<int>readDecrement()async{
    var pref = await getPrefs();
    return pref.getInt(decrementKey) ?? 0;
  }

}