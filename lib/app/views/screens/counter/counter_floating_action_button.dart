
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pactices/app/cubit/counter/counter_cubit.dart';

class CounterFloatingActionButton extends StatelessWidget {
  const CounterFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().increment(),
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().decrement(),
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }
}
