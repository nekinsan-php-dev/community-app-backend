import 'package:community_app/screens/auth_screen.dart';
import 'package:community_app/screens/main_screen.dart';
import 'package:community_app/screens/new_chat.dart';
import 'package:community_app/screens/new_post.dart';
import 'package:community_app/screens/otp_verification.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
        '/otp_verification': (context) => const OtpVerification(),
        '/home': (context) => const MainScreen(),
        '/new_post': (context) =>
            const NewPost(), // Placeholder for New Post screen
        '/new_chat': (context) => const NewChat(), // New chat screen
      },
    );
  }
}
