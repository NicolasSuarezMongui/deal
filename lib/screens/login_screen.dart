import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _loginWithGoogle() {
    print('Iniciar sesión con Google');
  }

  void _openBe() {
    print('Iniciar sesión con Be');
  }

  void _openInstragram() {
    print('Iniciar sesión con Instagram');
  }

  void _openTiktok() {
    print('Iniciar sesión con TikTok');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Deâl',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF34495E),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(128, 234, 238, 239),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      Text(
                        'Inicio de Sesión',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF34495E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Usuario',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            print('¿Olvidó contraseña?');
                          },
                          child: Text(
                            '¿Olvidó contraseña?',
                            style: TextStyle(color: Color(0xFF597CA6)),
                          ),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        print('go to Register');
                      },
                      child: Text(
                        'Registrar',
                        style: TextStyle(
                          color: Color(0xFF34495E),
                          fontSize: 20,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFF2F4F6), // Ajuste de color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        side: BorderSide(color: Color(0xFFCED3DC)), // Ajuste de color del borde
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _login,
                      child: Text(
                        'Continuar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3A506B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton( // Usamos OutlinedButton para consistencia
                  onPressed: () {
                    print('ContinueAsGuest');
                  },
                  child: Text(
                    'Continuar como invitado',
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFFF2F4F6), // Ajuste de color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    side: BorderSide(color: Color(0xFFCED3DC)), // Ajuste de color del borde
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    print('Continuar con Google');
                  },
                  icon: Icon(Icons.mail_outline, color: Colors.redAccent),
                  label: Text(
                    'Continuar con Google',
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF2F4F6), // Ajuste de color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    side: BorderSide(color: Color(0xFFCED3DC)), // Ajuste de color del borde
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    print("Continuar con LinkedIn");
                  },
                  icon: Icon(Icons.link, color: Colors.blueAccent),
                  label: Text(
                    'Continuar con LinkedIn',
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF2F4F6), // Ajuste de color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    side: BorderSide(color: Color(0xFFCED3DC)), // Ajuste de color del borde
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _openBe,
                    child: Text(
                      'Bē',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF2F4F6), // Ajuste de color
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      side: BorderSide(color: Color(0xFFCED3DC)!), // Ajuste de color del borde
                      minimumSize: Size(60, 50),
                    ),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: _openInstragram,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey[600],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF2F4F6), // Ajuste de color
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      side: BorderSide(color: Color(0xFFCED3DC)!), // Ajuste de color del borde
                      minimumSize: Size(60, 50),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _openTiktok,
                    child: Icon(
                      Icons.music_note_outlined,
                      color: Colors.grey[600],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF2F4F6), // Ajuste de color
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      side: BorderSide(color: Color(0xFFCED3DC)!), // Ajuste de color del borde
                      minimumSize: Size(60, 50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
