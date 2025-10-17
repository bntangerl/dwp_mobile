import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'daftar_penerima.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:email_validator/email_validator.dart';


class LoginPage extends StatefulWidget {
 @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController emailController = TextEditingController(); 
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); 
  bool isLoading = false;  
  bool _obscurePassword = true;


  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

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
          content: Text(data['message']),
          backgroundColor: Colors.green,
        ),
      );

      await Future.delayed(Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DaftarPenerimaPage()),
      );
    } else if (response.statusCode == 401) {
      // Login gagal karena email/password salah
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message']),
          backgroundColor: Colors.red,
        ),
      );
    } else if (response.statusCode == 403) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message']),
          backgroundColor: Colors.orange,
        ),
      );
    } 
    else {
      // Error lainnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,
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
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'
                ),
              ),
              SizedBox(height: 40.0),

              TextFormField(
                controller: emailController, 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  } else if (!EmailValidator.validate(value)) {
                    return 'Format email tidak valid';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: const Color.fromARGB(255, 160, 160, 160)),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 160, 160, 160), fontFamily: 'Poppins'),
                  hintText: 'Masukkan Email',
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 160, 160, 160), fontFamily: 'Poppins'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),),
                ),
              ),
              SizedBox(height: 20.0),

              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password wajib diisi';
                  }
                  return null;
                },
                obscureText: _obscurePassword,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 160, 160, 160), fontFamily: 'Poppins'),
                  hintText: 'Masukkan Password',
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 160, 160, 160), fontFamily: 'Poppins'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: const Color.fromARGB(255, 96, 96, 96))
                    ),
                  suffixIcon: IconButton(
                  icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                ),
              SizedBox(height: 20.0),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login(); // hanya dipanggil jika validasi sukses
                  }
                },
                child: Text('Login', style: TextStyle(fontFamily: 'Poppins'),),
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