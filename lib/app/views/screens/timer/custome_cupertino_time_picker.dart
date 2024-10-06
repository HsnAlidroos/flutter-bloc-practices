import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pactices/app/bloc/timer/timer_bloc.dart';

class CustomeCupertinoTimerPicker extends StatelessWidget {
  const CustomeCupertinoTimerPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return CupertinoTimerPicker(
          initialTimerDuration: Duration(seconds: state.initialDuration),
          mode: CupertinoTimerPickerMode.ms,
          onTimerDurationChanged: (value) {
            int totalSeconds = value.inSeconds;
            context
                .read<TimerBloc>()
                .add(TimerDurationChanged(duration: totalSeconds));
          },
        );
      },
    );
  }
}
