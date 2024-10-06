
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pactices/app/cubit/counter/counter_cubit.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        return Center(
          child: Text(
            '$state',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        );
      },
    );
  }
}