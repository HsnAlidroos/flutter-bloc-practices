import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pactices/app/app.dart';
import 'package:flutter_pactices/app/simple_bloc_observer.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const MyApp());
}
