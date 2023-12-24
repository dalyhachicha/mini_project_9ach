import 'package:flutter/material.dart';
import 'package:mini_project_9ach/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Image.asset('assets/images/logo.png'),
                  height: 200,
                  margin: const EdgeInsets.symmetric(vertical: 24),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: firstNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Prénom',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre prénom.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Nom',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre nom.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Adresse',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre adresse.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Numéro de téléphone',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre numéro de téléphone.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre adresse email.';
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Veuillez entrer une adresse email valide.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                  ),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Le mot de passe doit contenir au moins 8 caractères.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Confirmer le mot de passe',
                  ),
                  validator: (value) {
                    if (value == null || value != passwordController.text) {
                      return 'Les mots de passe ne correspondent pas.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                          Navigator.pushReplacementNamed(context, '/home');
                        } on FirebaseAuthException catch (e) {
                          String errorMessage =
                              e.message ?? "An error occurred";
                          if (e.code == 'invalid-credential') {
                            errorMessage =
                                "Identifiants incorrects. Veuillez réessayer.";
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    child: const Text('Créer un compte',
                        style: TextStyle(
                          color: Colors.white,
                        ))),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'Déjà un compte ? ',
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
      ),
    );
  }
}
