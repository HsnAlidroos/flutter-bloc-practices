import 'package:flutter/material.dart';
import 'package:flutter_pactices/app/views/screens/counter/counter_text.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         CounterView(),
      ],
      // floatingActionButton: const CounterFloatingActionButton(),
    );
  }
}

