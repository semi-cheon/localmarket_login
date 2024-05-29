import 'package:flutter/material.dart';

class CouponDetail extends StatelessWidget {
  final int id;

  const CouponDetail({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('hh'), Text('hh'), Text('hh'), Text(id.toString())],
      ),
    );
  }
}
