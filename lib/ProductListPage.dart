import 'package:flutter/material.dart';
import 'package:flutter_product_response_model/ControllerListProduct.dart';
import 'package:flutter_product_response_model/Login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListPage extends StatelessWidget {
  final productController = Get.put(ControllerListProduct());
  ProductListPage({Key? key}) : super(key: key);
  late SharedPreferences prefs;

  void initialObject() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    initialObject();
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await prefs.setString('username', "");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Center(
        child: Obx(
          () => productController.isLoading.value
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Text(productController.sessionUsername.value.toString()),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            productController.productResponModelCtr.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product =
                              productController.productResponModelCtr[index];
                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Card(
                              child: Text(product.name),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
