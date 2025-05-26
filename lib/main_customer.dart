import 'package:flutter/material.dart';
import 'package:peru_dash_app/customer_app/screens/register_business_screen.dart';
import 'package:peru_dash_app/customer_app/screens/become_courier_screen.dart';

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
      home: const CustomerHomePage(title: 'Bienvenido a Andafast!'), // Updated title
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
              // Placeholder for Logo
              // Container(
              //   height: 100,
              //   margin: const EdgeInsets.symmetric(vertical: 30),
              //   alignment: Alignment.center,
              //   child: Image.network( // Placeholder for logo, replace with your asset
              //     'https://via.placeholder.com/150/FF9800/FFFFFF?Text=Andafast+Logo',
              //     // For a local asset, use: Image.asset('assets/logo.png'),
              //     height: 80,
              //   ),
              // ),
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
              if (_isLogin) _buildLoginForm(context) else _buildRegistrationForm(context),
              const SizedBox(height: 20),
              Text(
                'o continúa con',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Google Sign In
                      print('Google Sign In Tapped');
                    },
                    icon: const Icon(Icons.g_mobiledata, color: Colors.white), // Placeholder, use a proper Google icon
                    label: const Text('Google'),
                     style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Apple Sign In
                      print('Apple Sign In Tapped');
                    },
                    icon: const Icon(Icons.apple, color: Colors.white),
                    label: const Text('Apple'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildBottomLink(context, 'Registrar mi negocio', 'Empieza a vender en Andafast', Icons.store),
              const SizedBox(height: 15),
              _buildBottomLink(context, 'Ser courier Andafast', 'Genera ingresos repartiendo', Icons.delivery_dining),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Número de teléfono', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: 'g60096044', // Example from screenshot
            prefixIcon: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('+51', style: TextStyle(color: Colors.white70)),
            )
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // TODO: Send SMS Code
            print('Send SMS Code Tapped');
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enviar código SMS'),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
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
            hintText: '999 888 777', // Example from screenshot
             prefixIcon: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('+51', style: TextStyle(color: Colors.white70)),
            )
          ),
        ),
        const SizedBox(height: 15),
        const Text('Tipo de cuenta', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAccountTypeButton(context, 'Cliente', Icons.person, true), // Example: Cliente selected
            _buildAccountTypeButton(context, 'Comercio', Icons.storefront, false),
            _buildAccountTypeButton(context, 'Repartidor', Icons.delivery_dining, false),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            // TODO: Create Account
            print('Create Account Tapped');
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
    );
  }

  Widget _buildAccountTypeButton(BuildContext context, String label, IconData icon, bool isSelected) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton.icon(
          onPressed: () {
            // TODO: Handle account type selection
            print('Account type selected: $label');
          },
          icon: Icon(icon, size: 20),
          label: Text(label, style: const TextStyle(fontSize: 12)),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.orange : Colors.grey[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
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
        } else if (title == 'Ser courier Andafast') {
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
