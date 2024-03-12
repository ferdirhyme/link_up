import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:link_up/auth/supabaseAuth.dart';

import '../checkLogin.dart';
import '../constants/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text('Sign Up For An Account'),
                  const Gap(10),
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
                    preFixIcon: const Icon(Icons.lock),
                  ),
                  const Gap(10),
                  myTextField(
                    obscure: true,
                    ontap: () {},
                    context: context,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.text,
                    textController: _confirmPasswordController,
                    preFixIcon: const Icon(Icons.lock),
                  ),
                  const Gap(20),
                  myButton(
                    formKey: _formKey,
                    label: 'Sign Up',
                    function: () {
                      EasyLoading.show(
                        dismissOnTap: false,
                        status: 'Creating Account...Please Wait.',
                      );
                      setState(() {
                        try {
                          if (_passwordController.text == _confirmPasswordController.text) {
                            var res = AuthService().signupUser(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );

                            res.then((value) {
                              if (value != '') {
                                EasyLoading.showError(value!);
                              } else {
                                // EasyLoading.dismiss();
                                EasyLoading.showInfo('Successful');
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const CheckLogin()),
                                );
                              }
                            });

                            // EasyLoading.dismiss();
                          } else {
                            EasyLoading.showToast(
                              'Passwords do not match!',
                              dismissOnTap: true,
                              duration: const Duration(seconds: 1),
                            );
                          }
                        } catch (e) {
                          EasyLoading.showError(e.toString());
                        }
                      });
                    },
                    icon: const Icon(Icons.join_full),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
