import 'package:flutter/material.dart';
import 'package:ncu_emi/package/appbar.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _register() {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    // 在这里处理注册逻辑
    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        // 示例：打印用户输入的信息
        print('Email: $email');
        print('Password: $password');
        // 执行注册逻辑
        Navigator.pushReplacementNamed(context, '/navigation');
      } else {
        // 提示密码不一致
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('密碼不一致')),
        );
      }
    } else {
      // 提示用户输入信息
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('請輸入所有欄位')),
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
              const Text('會員註冊',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 60,),
              SizedBox(
                width: 800,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: '姓名',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20,),
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
              const SizedBox(height: 20.0),
              SizedBox(
                width: 800,
                child: TextField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: '確認密碼',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _register, // 注册后端
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                ),
                child: const Text('注册'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text('已经有账户？登录'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
