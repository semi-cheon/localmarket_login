import 'package:flutter/material.dart';
import 'package:login_localmarket/main.dart';

import '../components/avatar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final _nicknameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _siController = TextEditingController();
  final _guController = TextEditingController();
  final _dongController = TextEditingController();
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _getInitialProfile();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _phoneNoController.dispose();
    _siController.dispose();
    super.dispose();
  }

  Future<void> _getInitialProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase.from('profiles').select().eq('id', userId).single();

    setState(() {
      _nicknameController.text = data['nickname'];
      _phoneNoController.text = data['phoneno'];
      _siController.text = data['address_si'] + ' ' + data['address_gu']+ ' ' + data['address_dong'];
      _imageUrl = data['avatar_url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account'),),
      body: ListView(
        children: [
          Avatar(imageUrl: _imageUrl, onUpload: (imageUrl) async {
            setState(() {
              _imageUrl = imageUrl;
            });

            final userId = supabase.auth.currentUser!.id;
            await supabase.from('profiles').update({'avatar_url': imageUrl}).eq('id', userId);
          }),
          TextFormField(
            controller: _nicknameController,
            decoration: InputDecoration(
              label: Text('닉네임')
            ),
          ),
          TextFormField(
            controller: _phoneNoController,
            decoration: InputDecoration(
                label: Text('전화번호')
            ),
          ),
          TextFormField(
            controller: _siController,
            decoration: InputDecoration(
                label: Text('주소')
            ),
          ),
          ElevatedButton(onPressed: () async {
            final nickname = _nicknameController.text.trim();
            final phoneNo = _phoneNoController.text.trim();
            final si = _siController.text.trim().split(' ')[0];
            final gu = _siController.text.trim().split(' ')[1];
            final dong = _siController.text.trim().split(' ')[2];
            final userId = supabase.auth.currentUser!.id;
            final email = supabase.auth.currentUser!.email;

            await supabase.from('profiles').update({
              'email': email,
              'nickname': nickname,
              'phoneno': phoneNo,
              'address_si': si,
              'address_gu': gu,
              'address_dong': dong,
            }).eq('id', userId);

            if(mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('저장완료!'))
              );
              Navigator.of(context).pushReplacementNamed('/home');
            }
          }, child: Text('저장')),
          ElevatedButton(onPressed: () async {
            await supabase.auth.signOut();
          }, child: Text('로그아웃'))
        ],
      ),
    );
  }
}
