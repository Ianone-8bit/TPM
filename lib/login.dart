import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool isloggedin = false;

void _login(){
  String email = _emailController.text;
  String password = _passwordController.text;

  if (email == "hiemo@gmail.com" && password == "123456"){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: 
      Text("Login Berhasil"),
      backgroundColor: Colors.green,
      ),

    );
    setState(() {
      isloggedin = true;
    }
   );
  }else{
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: 
      Text("Login gagal"),
      backgroundColor: Colors.deepOrangeAccent,
      ),

    );
  }


  print("Email = $email");
  print("Password = $password");
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login CUYYY',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(padding:  EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login cuyy',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              label: Text("Email"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          ),
            TextField(
              controller: _passwordController,
            decoration: InputDecoration(
              label: Text("Password"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
            obscureText: true,
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: _login,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            minimumSize: Size(250,60)
          ), 
          child: Text("Login")
          ),
        ],
      ),
      ),
      );
  }
}
