import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = ChangeNotifierProvider((ref) => Auth());

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  String email = '';

  String password = '';

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void login({required VoidCallback onDone}) async {
    loading = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: unnecessary_null_comparison
      onDone();
      _loading = false;
    } catch (e) {
      print(e);
      loading = false;
    }
  }

  void register({required VoidCallback onDone}) async {
    loading = true;

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // ignore: unnecessary_null_comparison
      onDone();
      _loading = false;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      loading = false;
    }
  }

  void signOut() {
    _auth.signOut();
  }
}
