import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_project_9ach/firebase_options.dart';
import 'package:mini_project_9ach/pages/auth/login.page.dart';
import 'package:mini_project_9ach/pages/auth/signup.page.dart';
import 'package:mini_project_9ach/pages/home.page.dart';
import 'package:mini_project_9ach/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        fontFamily: 'TenorSans',
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
