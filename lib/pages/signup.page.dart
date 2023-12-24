import 'package:flutter/material.dart';
import 'package:mini_project_9ach/utils/constants.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Image.asset('assets/images/logo.png'),
                height: 200,
                margin: EdgeInsets.symmetric(vertical: 24),
              ),
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'First name',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Last name',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Adress',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Conirm',
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement login functionality
                },
                child: const Text('Créer un compte'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text.rich(
                  TextSpan(
                    text: 'A déjà un compte ?',
                    style: TextStyle(color: primaryColor),
                    children: [
                      TextSpan(
                        text: 'Se connecter',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
