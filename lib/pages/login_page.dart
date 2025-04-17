import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'register_page.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
 @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
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
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => DashboardPage())
                  );
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200,40),
                ),
              ),
              SizedBox(height: 20.0),

              RichText(
                text: TextSpan(
                  text: 'Belum punya akun? ',
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "Register",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = (){
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => RegisterPage()));
                        },
                    ),
                  ],
              ),
              ),
            ],
          ), 
        ),
      )
    );
  } 
}