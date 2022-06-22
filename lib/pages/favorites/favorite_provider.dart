import 'package:filmfan/models/favorite_model.dart';
import 'package:filmfan/pages/favorites/db_favorite_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyFavoriteProvider with ChangeNotifier {
  DbHelper db = DbHelper();
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<MyFavorite>> _favorite;
  Future<List<MyFavorite>> get favorite => _favorite;

  Future<List<MyFavorite>> getData() async {
    _favorite = db.getMyFavoriteList();

    return _favorite;
  }

  void _setPrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('favorite_items', _counter);
    // pref.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _counter = pref.getInt('favorite_items') ?? 0;
    // _totalPrice = pref.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  void removeAllCounter() {
    _counter  = 0;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  void addTotalPrice(double totalPrice) {
    _totalPrice = _totalPrice + totalPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double totalPrice) {
    _totalPrice = _totalPrice - totalPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }
}
