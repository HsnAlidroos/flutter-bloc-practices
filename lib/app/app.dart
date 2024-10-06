import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pactices/app/bloc/post/post_bloc.dart';
import 'package:flutter_pactices/app/bloc/timer/timer_bloc.dart';
import 'package:flutter_pactices/app/cubit/counter/counter_cubit.dart';
import 'package:flutter_pactices/app/cubit/navbar/navbar_cubit.dart';
import 'package:flutter_pactices/app/ticker.dart';
import 'package:flutter_pactices/app/views/screens/auth/login_screen.dart';
import 'package:flutter_pactices/app/views/screens/home/home_screen.dart';
import 'package:flutter_pactices/app/views/screens/splash/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:user_repository/user_repository.dart';

import 'bloc/authentication/bloc/authentication_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavbarCubit()),
        BlocProvider(create: (context) => CounterCubit()),
        BlocProvider(create: (context) => TimerBloc(ticker: const Ticker())),
        BlocProvider(
          create: (context) =>
              PostBloc(httpClient: http.Client())..add(PostFetched()),
        ),
        // BlocProvider(
        //   lazy: false,
        //   create: (_) => AuthenticationBloc(
        //     authenticationRepository: _authenticationRepository,
        //     userRepository: _userRepository,
        //   )..add(AuthenticationSubscriptionRequested()),
        // ),
      ],
      child: RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider(
          lazy: false,
          create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        )..add(AuthenticationSubscriptionRequested()),
          child: const AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomeScreen.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginScreen.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unknown:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('AuthenticationStatus.unknown')),
                );
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
