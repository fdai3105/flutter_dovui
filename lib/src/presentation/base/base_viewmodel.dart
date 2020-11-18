import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hues_dovui/src/presentation/widgets/widget_dialog_network.dart';
import 'package:hues_dovui/src/presentation/widgets/widget_dialog_play.dart';
import 'package:rxdart/subjects.dart';

class BaseViewModel extends ChangeNotifier {
  BuildContext context;

  setContext(BuildContext context) {
    this.context = context;
  }

  final loadSubject = BehaviorSubject<bool>();
  final errorSubject = BehaviorSubject<String>();

  setLoading(bool loading) {
    if (loading != isLoading) {
      loadSubject.add(loading);
      notifyListeners();
    }
  }

  bool get isLoading => loadSubject.value;

  setError(String error) {
    errorSubject.add(error);
  }

  String get error => errorSubject.value;

  @override
  void dispose() async {
    await loadSubject.drain();
    loadSubject.close();
    await errorSubject.drain();
    errorSubject.close();
    super.dispose();
  }
}
