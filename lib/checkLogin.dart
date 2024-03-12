import 'package:flutter/material.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/signin.dart';
import 'constants/supabaseClient.dart';
import 'pages/home.dart';

class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});

  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  List status = [];

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<List> getUserStatus(id) async {
    final userStatus = await client.from('user_status').select('status').match({'id': id});
    return userStatus;
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);

    if (!mounted) {
      return;
    }

    final session = client.auth.currentSession;

    if (session != null) {
      Navigator.pushReplacement(
        context,
        PageRouteAnimator(
          child: const Home(),
          routeAnimation: RouteAnimation.bottomLeftToTopRight,
          settings: const RouteSettings(arguments: ''),
          curve: Curves.easeOut,
        ),
      );
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const Home(),
      //   ),
      // );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteAnimator(
          child: const SignIn(),
          routeAnimation: RouteAnimation.leftToRight,
          settings: const RouteSettings(arguments: ''),
          curve: Curves.easeOut,
        ),
      );
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const SignIn(),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
