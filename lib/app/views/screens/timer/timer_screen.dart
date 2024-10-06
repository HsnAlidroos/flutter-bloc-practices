import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pactices/app/bloc/timer/timer_bloc.dart';
import 'package:flutter_pactices/app/views/screens/timer/action_timer.dart';
import 'package:flutter_pactices/app/views/screens/timer/background_timer.dart';
import 'package:flutter_pactices/app/views/screens/timer/custome_cupertino_time_picker.dart';
import 'package:flutter_pactices/app/views/screens/timer/timer_text.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            bool showTimerText =
                state is! TimerInitial && state is! TimerRunComplete;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (showTimerText) const TimerText(),
                if (state is TimerInitial || state is TimerRunComplete)
                  const CustomeCupertinoTimerPicker(),
                const ActionsTimer(),
              ],
            );
          },
        ),
      ],
    );
  }
}
