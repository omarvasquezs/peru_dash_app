import 'package:flutter/material.dart';
import 'package:peru_dash_app/customer_app/screens/register_business_screen.dart';
import 'package:peru_dash_app/customer_app/screens/become_courier_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Add this import
import 'package:google_sign_in/google_sign_in.dart'; // Added for Google Sign-In

void main() {
  runApp(const CustomerApp());
}

class CustomerApp extends StatelessWidget {
  const CustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer App',
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
      home: const CustomerHomePage(title: 'Bienvenido a Perú Dash!'), // Updated title
      // home: Scaffold(appBar: AppBar(title: const Text('Test Customer App')), body: const Center(child: Text('Loading Test...'))), // Temporary simple home
    );
  }
}

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key, required this.title});

  final String title;

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  bool _isLogin = true; // To toggle between Login and Sign Up
  final _formKey = GlobalKey<FormState>(); // Add form key for validation

  // Controllers for registration form
  final _nameController = TextEditingController();
  final _dniController = TextEditingController(); // Added DNI controller
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController(); // Added Password controller
  final _confirmPasswordController = TextEditingController(); // Added Confirm Password controller

  // Controllers for login form
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  // Google Sign In
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in
        return;
      }
      // TODO: Authenticate with your backend using googleUser.authentication
      print('Google Sign In successful: ${googleUser.displayName}');
      // Navigate to home screen or show success message
    } catch (error) {
      print('Google Sign In error: $error');
      // Show error message
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dniController.dispose(); // Dispose DNI controller
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose(); // Dispose Password controller
    _confirmPasswordController.dispose(); // Dispose Confirm Password controller
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }

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
                // child: const Icon(Icons.business, size: 80, color: Colors.orange), // Placeholder Icon
              ),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'La super app de delivery ya esta aquí!', // Subtitle from screenshot
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
              if (_isLogin) _buildLoginForm(context) else _buildRegistrationForm(context),
              const SizedBox(height: 20),
              Text(
                'o continúa con',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the button
                children: [
                  Expanded( // Make button span horizontally
                    child: ElevatedButton.icon(
                      onPressed: _handleGoogleSignIn, // Updated onPressed
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white), // Changed Icon
                      label: const Text('Google'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDB4437), // Google Red
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12), // Adjust padding as needed
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Ensure text style matches other buttons
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildBottomLink(context, 'Registrar mi negocio', 'Empieza a vender en Andafast', Icons.store),
              const SizedBox(height: 15),
              _buildBottomLink(context, 'Ser repartidor en Perú Dash', 'Genera ingresos repartiendo', Icons.delivery_dining),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form( // Wrap with Form widget for validation
      key: _formKey, // Assign the form key
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Correo electrónico', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _loginEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Ingresa tu correo',
              prefixIcon: Icon(Icons.email_outlined, color: Colors.white70),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu correo electrónico';
              }
              if (!RegExp(r'^[^@]+@[^@]+\\.[^@]+').hasMatch(value)) {
                return 'Por favor ingresa un correo válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          const Text('Contraseña', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _loginPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Ingresa tu contraseña',
              prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar.
                // Or, actually process the data.
                print('Login Tapped - Form is valid');
                print('Email: ${_loginEmailController.text}');
                print('Password: ${_loginPasswordController.text}');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Iniciando sesión...')),
                );
                // TODO: Implement actual login logic here
              } else {
                print('Login Tapped - Form is invalid');
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ingresar'),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
    return Form( // Wrap with Form widget
      key: _formKey, // Assign the form key
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Nombre completo', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Ingresa tu nombre',
              prefixIcon: Icon(Icons.person_outline, color: Colors.white70),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          const Text('DNI', style: TextStyle(color: Colors.white70)), // DNI field
          const SizedBox(height: 8),
          TextFormField(
            controller: _dniController,
            keyboardType: TextInputType.number,
            maxLength: 8, // Add maxLength for DNI
            decoration: const InputDecoration(
              hintText: 'Ingresa tu DNI',
              prefixIcon: Icon(Icons.assignment_ind, color: Colors.white70),
              counterText: "", // Hide the counter text
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu DNI';
              }
              if (value.length != 8) { // Add length validation
                return 'El DNI debe tener 8 dígitos';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          const Text('Correo electrónico', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Ingresa tu correo',
              prefixIcon: Icon(Icons.email_outlined, color: Colors.white70),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu correo electrónico';
              }
              if (!RegExp(r'^[^@]+@[^@]+\\.[^@]+').hasMatch(value)) {
                return 'Por favor ingresa un correo válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          const Text('Número de teléfono', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: '999 888 777', // Example from screenshot
              prefixIcon: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('+51', style: TextStyle(color: Colors.white70)),
              )
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu número de teléfono';
              }
              // Basic numeric check, can be enhanced
              if (int.tryParse(value.replaceAll(' ', '')) == null) {
                return 'Por favor ingresa un número válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          const Text('Contraseña', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Ingresa tu contraseña',
              prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          const Text('Confirmar contraseña', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Confirma tu contraseña',
              prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor confirma tu contraseña';
              }
              if (value != _passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar.
                // Or, actually process the data.
                print('Create Account Tapped - Form is valid');
                print('Name: ${_nameController.text}');
                print('DNI: ${_dniController.text}');
                print('Email: ${_emailController.text}');
                print('Phone: ${_phoneController.text}');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Procesando datos...')),
                );
              } else {
                print('Create Account Tapped - Form is invalid');
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Crear cuenta'),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomLink(BuildContext context, String title, String subtitle, IconData icon) {
    return InkWell(
      onTap: () {
        if (title == 'Registrar mi negocio') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterBusinessScreen()),
          );
        } else if (title == 'Ser repartidor en Perú Dash') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BecomeCourierScreen()),
          );
        } else {
          print('Bottom link tapped: $title');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange, size: 30),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
          ],
        ),
      ),
    );
  }
}
