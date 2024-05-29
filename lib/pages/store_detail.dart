import 'package:flutter/material.dart';

class StoreDetail extends StatelessWidget {
  final int id;
  final item;
  const StoreDetail({required this.id, required this.item,super.key});

  // void getStoreDetail() async {
  //   final resp =
  //   print(resp);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('hh'),
          Text('hh'),
          Text('hh'), Text(id.toString())
          ,Text(item.toString())
        ],
      ),
    );
  }
}
