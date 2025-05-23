import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'daftar_penerima.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class LoginPage extends StatefulWidget {
 @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController emailController = TextEditingController(); 
  final TextEditingController passwordController = TextEditingController(); 
  bool isLoading = false; 

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email dan Password wajib diisi')),
      );
      return;
    }

    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login'), // Ganti IP jika pakai device
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    setState(() => isLoading = false);

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(data['message'] ?? 'Login berhasil'),
        duration: Duration(seconds: 2),
       )
      );

        await Future.delayed(Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DaftarPenerimaPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Login gagal')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),

        child: Form(

          child: Column(

            children: [
              SizedBox(height: 150.0),
              Image.asset(
                'assets/dwp_polije.png',
                height: 70,
              ),
              SizedBox(height: 10.0),

              Text("Masuk ke Akun Anda",
                style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 40.0),

              TextFormField(
                controller: emailController, 
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: const Color.fromARGB(255, 160, 160, 160)),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 160, 160, 160)),
                  hintText: 'Masukkan Email',
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 160, 160, 160)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),),
                ),
              ),
              SizedBox(height: 20.0),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 160, 160, 160)),
                  hintText: 'Masukkan Password',
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 160, 160, 160)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: const Color.fromARGB(255, 96, 96, 96))
                    ),
                ),
              ),
              SizedBox(height: 20.0),

              ElevatedButton(
                onPressed: login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200,40),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ), 
        ),
      )
    );
  } 
}