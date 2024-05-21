import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_localmarket/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailContoller = TextEditingController();
  final _passwdContoller = TextEditingController();
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();

    _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;

      if(session != null) {
        Navigator.of(context).pushReplacementNamed('/account');
      }
    });
  }
  @override
  void dispose() {
    _emailContoller.dispose();
    _passwdContoller.dispose();
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ListView(
        children: [
          TextFormField(
            controller: _emailContoller,
            decoration: InputDecoration(label: Text('Email')),
          ),
          ElevatedButton(
              onPressed: () async {
                final email = _emailContoller.text.trim();
                final data = await supabase.from('profiles').select('email').eq('email', email);
                if(mounted) {
                  if(data.length <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('사용 가능 email'),
                      ),
                    );
                  } else {
                    _emailContoller.text = '';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('사용 불가'),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                }
              },
              child: Text('email 중복확인')),
          TextFormField(
            controller: _passwdContoller,
            decoration: InputDecoration(label: Text('passwd')),
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  final email = _emailContoller.text.trim();
                  final password = _passwdContoller.text.trim();

                  final response = await supabase.auth.signUp(email: email, password: password);

                  // if(mounted) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(''),
                  //     ),
                  //   );
                  // }
                  print(response.toString());
                } on AuthException catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.message),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('에러 발생'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              child: Text('회원가입')),
          ElevatedButton(onPressed: () async {
            try {
              final email = _emailContoller.text.trim();
              final password = _passwdContoller.text.trim();

              final response = await supabase.auth.signInWithPassword(email: email, password: password);
              print(response.toString());
            } on AuthException catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('에러 발생'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          }, child: Text('로그인'))
        ],
      ),
    );
  }
}
