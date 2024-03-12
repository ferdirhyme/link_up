import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:link_up/auth/signup.dart';

import '../checkLogin.dart';
import '../constants/supabaseClient.dart';
import '../constants/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.jpeg', // Replace with your app logo
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    myTextField(
                      obscure: false,
                      ontap: () {},
                      context: context,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      textController: _emailController,
                      preFixIcon: const Icon(Icons.email),
                    ),
                    const Gap(10),
                    myTextField(
                        obscure: true,
                        ontap: () {},
                        context: context,
                        hintText: 'Password',
                        keyboardType: TextInputType.text,
                        textController: _passwordController,
                        preFixIcon: const Icon(Icons.lock)),
                    const Gap(20),
                    myButton(
                      formKey: _formKey,
                      label: 'Login',
                      function: () async {
                        EasyLoading.show(
                          dismissOnTap: false,
                          status: 'Please Wait...',
                        );
                        try {
                          var res = await client.auth.signInWithPassword(
                            password: _passwordController.text,
                            email: _emailController.text,
                          );
                          EasyLoading.showInfo('Successful');
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const CheckLogin()),
                          );
                        } catch (e) {
                          EasyLoading.showError(e.toString());
                        }
                      },
                      icon: const Icon(Icons.login),
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () async {},
                          child: const Text('Forgot Password?'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ),
                            );
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
