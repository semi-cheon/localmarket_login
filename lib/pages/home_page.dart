import 'package:flutter/material.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(onPressed: () async {
          await supabase.auth.signOut();
        }, child: Text('로그아웃')),
      ),
    );
  }
}
