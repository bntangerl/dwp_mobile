import 'package:belajar_flutter/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        centerTitle: true,
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),  
          child: Form(
            child: Column(

              children: [

                Text("Daftar Akun", 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height: 20,),

                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Nama Lengkap',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    labelText: 'Nama Lengkap',
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Tanggal Lahir',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    labelText: 'Tanggal Lahir',
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Nomor HP',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    labelText: 'Nomor HP',
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Jenis Kelamin',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    labelText: 'Jenis Kelamin',
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Alamat',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    labelText: 'Alamat',
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 235, 235, 235)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }, 
                  child: Text('Register'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(200, 40)),
                  ),
              ],
            ),
          ),
        ),
    );
  }
}