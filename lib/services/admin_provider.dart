import 'package:flutter/cupertino.dart';

class AdminProvider extends ChangeNotifier {
  int _initalPage;
  int get initialPage => _initalPage;

  List<dynamic> _categories;
  List<dynamic> get categories => _categories;

  AdminProvider(this._initalPage, this._categories);

  void changeInitialPage(int newPage) {
    _initalPage = newPage;
    notifyListeners();
  }

  void addCategory(dynamic item) {
    _categories.add(item);
    notifyListeners();
  }

  void changeList(List<dynamic> newList) {
    _categories = newList;
    //notifyListeners();
  }
}
