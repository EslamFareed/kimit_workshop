import 'package:flutter/material.dart';
import 'package:kimit_workshop/cubits/auth/auth_cubit.dart';
import 'package:kimit_workshop/screens/home_screen.dart';
import 'package:kimit_workshop/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _goTo(context);

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.article,
              size: 150,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  _goTo(context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AuthCubit.get(context).checkLogin()
                  ? HomeScreen()
                  : LoginScreen(),
            ));
      },
    );
  }
}
