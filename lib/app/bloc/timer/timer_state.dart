part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  const TimerState(this.duration, {this.initialDuration =60});
  final int duration;
  final int initialDuration;
  @override
  List<Object> get props => [duration,initialDuration];
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.duration,{super.initialDuration});

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}



final class TimerRunPause extends TimerState{
  const TimerRunPause(super.duration);

    @override
  String toString() => 'TimerRunPause { duration: $duration }';

}

final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
