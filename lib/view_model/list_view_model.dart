
import 'package:flutter/cupertino.dart';
import 'package:multiply/service/sqflite_service.dart';

import '../model/list_model.dart';

class ListViewModel extends ChangeNotifier{
  SqfLiteService db = SqfLiteService();
  bool isLoading = false;
  bool isChecking = false;
  List<ListModel> listItems = [];
  List<int> deletingList = [];

  double _itemOffset = 0.0;

  double get itemOffset => _itemOffset;

  set itemOffset(double value) {
    _itemOffset = value;
    notifyListeners();
  }

  Future<void>addItem(ListModel listModel)async{
    isLoading = true;
    notifyListeners();
    await db.addItem(listModel);
    isLoading = false;
    notifyListeners();
  }

  Future<void>readItems()async{
    isLoading = true;
    notifyListeners();
    var result = await db.getItems();
    listItems = result.map((e) => ListModel.fromJson(e)).toList();
    isLoading = false;
    notifyListeners();
  }

  Future<void>updateItem(ListModel listModel)async{
    isLoading = true;
    notifyListeners();
    await db.updateItem(listModel);
    isLoading = false;
    notifyListeners();
  }

  Future<void>deleteItem(int id)async{
    isLoading = true;
    notifyListeners();
    await db.deleteMind(id);
    isLoading = false;
    notifyListeners();
  }

}