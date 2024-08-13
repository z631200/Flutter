import 'package:flutter/material.dart';
import 'package:ncu_emi/package/appbar.dart';



class LogInPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // 在这里处理登录逻辑
    if (email.isNotEmpty && password.isNotEmpty) {
      // 示例：打印用户输入的信息
      print('Email: $email');
      print('Password: $password');
      Navigator.pushReplacementNamed(context, '/navigation');
    } else {
      // 提示用户输入信息
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入邮箱和密码')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('歡迎使用， EMI課程助教',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 60,),
              SizedBox(
                width: 800,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '電子郵件',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 800,
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '密碼',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,//登入後端
                child: const Text('登入'),
              ),
              const Text ('或'),
              ElevatedButton(
                onPressed: () {},//google log in
                child: const Text('以google 帳號登入'),
              ),
              const SizedBox(height: 20,),
              const Text('沒有帳號嗎?點此',
              ),
              TextButton(
                  onPressed:() {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('註冊')),
            ],
          ),
        ),
      ),
    );
  }
}