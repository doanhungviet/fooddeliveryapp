import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fooddeliveryapp/firebase_options.dart';
import 'package:fooddeliveryapp/pages/admin/add_food.dart';
import 'package:fooddeliveryapp/pages/admin/admin_login.dart';
import 'package:fooddeliveryapp/pages/bottomnav.dart';
import 'package:fooddeliveryapp/pages/home.dart';
import 'package:fooddeliveryapp/pages/login.dart';
import 'package:fooddeliveryapp/pages/onboard.dart';
import 'package:fooddeliveryapp/widgets/app_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Sử dụng tùy chọn Firebase từ firebase_options.dart
    );
    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Onboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
