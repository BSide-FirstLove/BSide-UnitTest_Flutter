import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:login_crud/model/user.dart';

class UserState extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<User> _users = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<User> get user => UnmodifiableListView(_users);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(User user) {
    _users.add(user);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _users.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  bool isLogin() {
    return _users.isEmpty? false : true;
  }
}