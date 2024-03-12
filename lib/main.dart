import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'checkLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fawbzkrvgksozunbnzdd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZhd2J6a3J2Z2tzb3p1bmJuemRkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDkzODI1ODMsImV4cCI6MjAyNDk1ODU4M30.RRYPplsMXk28b8wj2h8zOvhMGLYVOkMBnDKErx8YpQ0',
    authFlowType: AuthFlowType.pkce,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkUP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CheckLogin(),
      builder: EasyLoading.init(),
    );
  }
}
