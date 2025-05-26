import 'package:flutter/material.dart';

void main() {
  runApp(const DriverApp());
}

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFF1A202C), // Dark background
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[800],
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.orange),
          ),
        ),
        useMaterial3: true,
      ),
      home: const DriverHomePage(title: 'Bienvenido a Andafast!'), // Updated title, assuming similar for driver
    );
  }
}

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key, required this.title});

  final String title;

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  bool _isLogin = true; // To toggle between Login and Sign Up, same as customer for now

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 100,
                margin: const EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.center,
                child: Image.asset( // Placeholder for logo, replace with your asset
                  'assets/images/logo.png',
                  height: 80,
                ),
                // child: const Icon(Icons.drive_eta, size: 80, color: Colors.orange), // Placeholder Icon
              ),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'La super app de delivery para Huacho', // Subtitle from screenshot
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => setState(() => _isLogin = true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isLogin ? Colors.orange : Colors.grey[700],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          )
                        )
                      ),
                      child: const Text('Ingresar'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => setState(() => _isLogin = false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_isLogin ? Colors.orange : Colors.grey[700],
                         shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          )
                        )
                      ),
                      child: const Text('Registrarse'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // For the driver app, we might have a different form or less options
              // than the customer app. This is a simplified version.
              if (_isLogin) _buildDriverLoginForm(context) else _buildDriverRegistrationForm(context),
              const SizedBox(height: 20),
              // Social logins might be less common for driver apps, or different
              // Text(
              //   'o continúa con',
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
              // const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ElevatedButton.icon(
              //       onPressed: () { /* TODO: Google Sign In */ },
              //       icon: const Icon(Icons.g_mobiledata, color: Colors.white), 
              //       label: const Text('Google'),
              //        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              //     ),
              //     ElevatedButton.icon(
              //       onPressed: () { /* TODO: Apple Sign In */ },
              //       icon: const Icon(Icons.apple, color: Colors.white),
              //       label: const Text('Apple'),
              //       style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              //     ),
              //   ],
              // ),
              // The bottom links for business/courier registration are likely not needed in the driver app itself.
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton( // Removed FAB
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.drive_eta), // Icon was already drive_eta
      // ),
    );
  }

  Widget _buildDriverLoginForm(BuildContext context) {
    // Simplified login for driver, can be expanded
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Número de teléfono o ID de Conductor', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Ingresa tu número o ID',
            prefixIcon: Icon(Icons.person_pin_circle_outlined, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 15),
        const Text('Contraseña', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Ingresa tu contraseña',
            prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // TODO: Driver Login
            print('Driver Login Tapped');
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Ingresar como Conductor'),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDriverRegistrationForm(BuildContext context) {
    // Simplified registration for driver, can be expanded
    // This might redirect to a web page or a different flow
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Nombre completo', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Ingresa tu nombre',
            prefixIcon: Icon(Icons.person_outline, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 15),
        const Text('Correo electrónico', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Ingresa tu correo',
            prefixIcon: Icon(Icons.email_outlined, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 15),
        const Text('Número de teléfono', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: '999 888 777',
             prefixIcon: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('+51', style: TextStyle(color: Colors.white70)),
            )
          ),
        ),
        const SizedBox(height: 15),
        // Add other driver-specific fields like vehicle type, license, etc.
        const Text('Crear Contraseña', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Crea una contraseña segura',
            prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            // TODO: Driver Create Account
            print('Driver Create Account Tapped');
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Registrarme como Conductor'),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
         const SizedBox(height: 20),
         Center(
           child: TextButton(
            onPressed: () {
              // TODO: Navigate to a web page or different flow for becoming a courier
              print('Become a Courier Tapped');
            },
            child: const Text(
              '¿Interesado en ser Courier? Toca aquí',
              style: TextStyle(color: Colors.orange, decoration: TextDecoration.underline),
            ),
                 ),
         )
      ],
    );
  }
}
