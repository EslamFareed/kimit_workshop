import 'package:flutter/material.dart';
import 'package:kimit_workshop/cubits/auth/auth_cubit.dart';
import 'package:kimit_workshop/cubits/main/main_cubit.dart';
import 'package:kimit_workshop/cubits/news/news_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kimit_workshop/screens/splash_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => NewsCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData.dark(useMaterial3: true),
      ),
    );
  }
}
