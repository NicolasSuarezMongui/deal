import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _loginWithGoogle() {
    print('Iniciar sesión con Google');
  }

  void _loginWithEmail() {
    print('Iniciar sesión con correo');
  }

  void _openBe() {
    print('Iniciar sesión con Behance');
  }

  void _openInstagram() {
    print('Iniciar sesión con Instagram');
  }

  void _openTiktok() {
    print('Iniciar sesión con TikTok');
  }

  @override
  Widget build(BuildContext context) {
    // Colores basados en el mockup:
    const Color azulOscuro = Color(0xFF3A506B);
    const Color azulClaro = Color(0xFFEBF3F8);
    const Color grisTexto = Color(0xFF34495E);
    const Color textoBotonClaro = Color(0xFF34495E);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 1. Logo (“Deâl”)
              Text(
                'Deâl',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: grisTexto,
                ),
              ),
              SizedBox(height: 30),

              // 2. Contenedor blanco con sombra para el formulario
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // Título “Inicio de Sesión”
                      Text(
                        'Inicio de Sesión',
                        style: TextStyle(
                          fontSize: 20,
                          color: grisTexto,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 25),

                      // Campo “Usuario”
                      TextFormField(
                        controller: _usuarioController,
                        decoration: InputDecoration(
                          hintText: 'Usuario',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          filled: true,
                          fillColor: azulClaro,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                        style: TextStyle(color: Colors.black87),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu usuario';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Campo “Contraseña”
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          filled: true,
                          fillColor: azulClaro,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                        style: TextStyle(color: Colors.black87),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),

                      // “¿Olvidaste la contraseña?”
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            print('¿Olvidaste contraseña?');
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(50, 30),
                          ),
                          child: Text(
                            '¿Olvidaste la contraseña?',
                            style: TextStyle(
                              color: Color(0xFF597CA6),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 25),

              // 3. Fila: “Registrar” (outline) + “Continuar” (relleno)
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        print('Página de Registro');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Color(0xFFCED3DC)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Registrar',
                        style: TextStyle(
                          color: textoBotonClaro,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: azulOscuro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Continuar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              // 4. Botón ancho “Continuar como invitado”
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('Continuar como invitado');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azulOscuro,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'Continuar como invitado',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // 5. Botones anchos “Continuar con Google” y “Continuar con correo”
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _loginWithGoogle,
                  icon: Icon(
                    Icons.g_mobiledata,
                    color: Colors.black,
                    size: 24,
                  ),
                  label: Text(
                    'Continuar con Google',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: azulClaro,
                    side: BorderSide(color: Color(0xFFCED3DC)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _loginWithEmail,
                  icon: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                  label: Text(
                    'Continuar con correo',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: azulClaro,
                    side: BorderSide(color: Color(0xFFCED3DC)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // 6. Iconos circulares (Behance, Instagram, TikTok)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Behance
                  GestureDetector(
                    onTap: _openBe,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Bē',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),

                  // Instagram
                  GestureDetector(
                    onTap: _openInstagram,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 24,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),

                  // TikTok
                  GestureDetector(
                    onTap: _openTiktok,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.music_note_outlined,
                        size: 24,
                        color: Colors.black87,
                      ),
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
