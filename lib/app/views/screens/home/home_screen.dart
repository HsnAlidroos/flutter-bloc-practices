import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pactices/app/bloc/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pactices/app/cubit/navbar/navbar_cubit.dart';
import 'package:flutter_pactices/app/views/screens/counter/counter_floating_action_button.dart';
import 'package:flutter_pactices/app/views/screens/counter/counter_screen.dart';
import 'package:flutter_pactices/app/views/screens/posts/view.dart';
import 'package:flutter_pactices/app/views/screens/timer/timer_screen.dart';
import 'package:flutter_pactices/app/views/widgets/custome_button_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    var cubit = NavbarCubit.get(context);
    List<Widget> screens = [
      const CounterScreen(),
      const TimerScreen(),
      Container(
        color: Colors.amber,
        child: Column(
          children: [
            AppBar(
              actions: const [_LogoutButton()],
            ),
            const _UserId()
          ],
        ),
      ),
      const PostsScreen(),
    ];

    return BlocBuilder<NavbarCubit, NavbarState>(
      builder: (context, state) {
        return Scaffold(
          body: screens[cubit.currentIndex],
          bottomNavigationBar: CustomButtonNavBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeBottomNavBar(index),
          ),
          floatingActionButton: cubit.currentIndex == 0
              ? const CounterFloatingActionButton()
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.small(
                      backgroundColor: Colors.greenAccent,
                      onPressed: null,
                      child: Icon(Icons.edit),
                    ),
                    FloatingActionButton(
                        onPressed: null,
                        child: Icon(Icons.access_alarm_outlined)),
                  ],
                ),
        );
      },
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Logout'),
      onPressed: () {
        context.read<AuthenticationBloc>().add(AuthenticationLogoutPressed());
      },
    );
  }
}

class _UserId extends StatelessWidget {
  const _UserId();

  @override
  Widget build(BuildContext context) {
    final userId = context.select(
      (AuthenticationBloc bloc) => bloc.state.user.id,
    );

    return Text('UserID: $userId');
  }
}
