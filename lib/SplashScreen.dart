import 'package:flutter/material.dart';
import 'package:flutter_product_response_model/Login.dart';
import 'package:flutter_product_response_model/ProductListPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  SharedPreferences? prefs;

  void initialObject(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    if (prefs!.getString("username") != "") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ProductListPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      initialObject(context);
    });
    return const Scaffold(
      body: Center(
        child: Text('Product response model'),
      ),
    );
  }
}