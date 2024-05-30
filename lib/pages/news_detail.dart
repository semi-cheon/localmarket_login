import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final int id;
  final item;
  const NewsDetail({required this.id, required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(id.toString()),
          Text(item.toString())
        ],
      ),
    );
  }
}
