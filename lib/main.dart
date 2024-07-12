import 'package:firebase_core/firebase_core.dart';
import 'package:minimalstore/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:minimalstore/pages/login_page.dart';
import 'package:minimalstore/services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:runner/firebase_options.dart';
import 'package:runner/pages/login_page.dart';
import 'models/shop.dart';
import 'pages/cart_page.dart';
import 'pages/intro_page.dart';
import 'pages/shop_page.dart';
import 'themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Shop()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  LoginPage(),
        theme: Provider.of<ThemeProvider>(context).themeData,
        routes: {
          '/intro_page': (context) => const IntroPage(),
          '/shop_page': (context) => const ShopPage(),
          '/cart_page': (context) => const CartPage()
        });
  }
}
