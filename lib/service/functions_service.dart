import 'package:flutter/cupertino.dart';
import 'package:multiply/service/shared_preferences_service.dart';

import '../ui/others/ui_components.dart';

class FunctionsService{

  String numberFormatter(int number){
    String numStr = number.toString();
    String formattedNumber  = "";
    int counter = 0;
    for(int i = numStr.length - 1 ; i > -1 ; i--){
      formattedNumber = counter % 3 == 0 ? "${numStr[i]} $formattedNumber" : "${numStr[i]}$formattedNumber";
      counter ++;
    }
    return formattedNumber;
  }
}