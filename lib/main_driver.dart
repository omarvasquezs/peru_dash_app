import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Add this import
import 'package:peru_dash_app/shared_widgets/dialog_picker_form_field.dart'; // For dialog pickers

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
      home: const DriverHomePage(title: 'Bienvenido a Perú Dash!'), // Updated title, assuming similar for driver
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
  bool _isLogin = true;

  // Controllers & variables for registration form (copied from become_courier_screen)
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _dniController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _departamentoController = TextEditingController();
  final _provinciaController = TextEditingController();
  final _distritoController = TextEditingController();
  String? _selectedVehicleType;
  final _licensePlateController = TextEditingController();
  bool _hasHelmet = false;
  bool _hasThermalBag = false;
  String? _selectedWorkSchedule;
  bool _agreedToTerms = false;
  bool _agreedToPrivacy = false;
  final List<String> _vehicleTypes = ['Moto', 'Bicicleta', 'Auto'];
  final List<String> _workSchedules = ['Tiempo Completo', 'Medio Tiempo', 'Fines de Semana'];
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _dniController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _departamentoController.dispose();
    _provinciaController.dispose();
    _distritoController.dispose();
    _licensePlateController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.orange,
              onPrimary: Colors.white,
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.orange),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
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
                child: Image.asset(
                  'assets/images/logo_driver.png',
                  height: 80,
                ),
              ),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'La super app de delivery ya esta aquí!',
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
                          ),
                        ),
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
                          ),
                        ),
                      ),
                      child: const Text('Registrarse'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (_isLogin) _buildDriverLoginForm(context) else _buildDriverRegistrationForm(context),
              const SizedBox(height: 20),
              Text(
                'o continúa con',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              // Social login: Only Google, full width
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Google Sign In
                        print('Google Sign In Tapped');
                      },
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white),
                      label: const Text('Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDB4437),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _buildDriverLoginForm(BuildContext context) {
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildSectionTitle('Información Personal'),
          _buildTextFormField(_fullNameController, 'Nombres completos', icon: Icons.person, hintText: 'Ingresa tu nombre'),
          _buildTextFormField(_dniController, 'DNI', keyboardType: TextInputType.number, maxLength: 8, icon: Icons.badge, hintText: 'Ingresa tu DNI'),
          _buildTextFormField(
            _dobController,
            'Fecha de nacimiento',
            readOnly: true,
            onTap: () => _selectDate(context),
            suffixIcon: Icons.calendar_today,
            hintText: 'Selecciona tu fecha de nacimiento',
          ),
          _buildTextFormField(_phoneController, 'Teléfono celular', keyboardType: TextInputType.phone, icon: Icons.phone, hintText: 'Ingresa tu teléfono'),
          _buildTextFormField(_emailController, 'Email', keyboardType: TextInputType.emailAddress, icon: Icons.email, hintText: 'Ingresa tu correo electrónico'),
          const Text('Contraseña', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          _buildTextFormField(_passwordController, 'Contraseña',
            icon: Icons.lock_outline,
            hintText: 'Crea una contraseña segura',
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa una contraseña';
              }
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          const Text('Repetir Contraseña', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          _buildTextFormField(_confirmPasswordController, 'Repetir Contraseña',
            icon: Icons.lock_outline,
            hintText: 'Repite la contraseña',
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor repite la contraseña';
              }
              if (value != _passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
          ),
          _buildTextFormField(_addressController, 'Dirección de domicilio', icon: Icons.home, hintText: 'Ingresa tu dirección'),
          _buildTextFormField(_distritoController, 'Distrito', icon: Icons.location_city, hintText: 'Ingresa tu distrito'),
          _buildTextFormField(_provinciaController, 'Provincia', icon: Icons.location_city, hintText: 'Ingresa tu provincia'),
          _buildTextFormField(_departamentoController, 'Departamento', icon: Icons.location_city, hintText: 'Ingresa tu departamento'),

          _buildSectionTitle('Vehículo y Equipamiento'),
          DialogPickerFormField(
            label: 'Tipo de vehículo',
            value: _selectedVehicleType,
            items: _vehicleTypes,
            onChanged: (value) {
              setState(() {
                _selectedVehicleType = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Este campo es obligatorio';
              return null;
            },
          ),
          if (_selectedVehicleType == 'Moto' || _selectedVehicleType == 'Auto')
            _buildTextFormField(_licensePlateController, 'Placa del vehículo', icon: Icons.traffic, hintText: 'Ingresa la placa del vehículo'),
          _buildCheckboxFormField('Tengo Casco de seguridad (si aplica)', _hasHelmet, (value) {
            setState(() {
              _hasHelmet = value!;
            });
          }),
          _buildCheckboxFormField('Tengo Mochila térmica/delivery bag', _hasThermalBag, (value) {
            setState(() {
              _hasThermalBag = value!;
            });
          }, isRequired: true),

          _buildSectionTitle('Disponibilidad'),
          _buildTextFormField(
            TextEditingController(),
            'Zonas donde puede trabajar',
            maxLines: 3,
            icon: Icons.map,
            hintText: 'Describe las zonas donde puedes trabajar',
          ),
          DialogPickerFormField(
            label: 'Disponibilidad horaria',
            value: _selectedWorkSchedule,
            items: _workSchedules,
            onChanged: (value) {
              setState(() {
                _selectedWorkSchedule = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Este campo es obligatorio';
              return null;
            },
          ),

          _buildSectionTitle('Información Adicional (Simplificado)'),
          const Text(
            'Documentos como SOAT, Licencia de Conducir, Antecedentes y Datos Bancarios se solicitarán posteriormente.',
            style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 12),
          ),
          const SizedBox(height: 20),

          _buildSectionTitle('Términos y Condiciones'),
          _buildCheckboxFormField('Acepto los Términos y Condiciones para Repartidores', _agreedToTerms, (value) {
            setState(() {
              _agreedToTerms = value!;
            });
          }, isRequired: true),
          _buildCheckboxFormField('Acepto la Política de Privacidad y Tratamiento de Datos', _agreedToPrivacy, (value) {
            setState(() {
              _agreedToPrivacy = value!;
            });
          }, isRequired: true),

          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (!_agreedToTerms || !_agreedToPrivacy) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Debe aceptar los términos y políticas.')),
                  );
                  return;
                }
                if (!_hasThermalBag) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Debe contar con mochila térmica.')),
                  );
                  return;
                }
                // Process data
                print('Formulario de Ser Repartidor Válido');
                // TODO: Implement actual data submission
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text('Enviar Solicitud', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    bool isOptional = false,
    int? maxLength,
    IconData? icon,
    String? hintText,
    bool readOnly = false,
    VoidCallback? onTap,
    IconData? suffixIcon,
    int maxLines = 1,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label + (isOptional ? ' (Opcional)' : ''),
            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
            readOnly: readOnly,
            onTap: onTap,
            maxLines: maxLines,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              filled: true,
              fillColor: Colors.grey[800],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.orange),
              ),
              prefixIcon: icon != null ? Icon(icon, color: Colors.grey[400]) : null,
              suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey[400]) : null,
              counterText: maxLength != null ? '' : null,
            ),
            validator: validator ?? (value) {
              if (!isOptional && (value == null || value.isEmpty)) {
                return 'Este campo es obligatorio';
              }
              if (label == 'Email' && value != null && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Por favor ingresa un correo válido';
              }
              if (label == 'DNI' && value != null && (value.length != 8 || int.tryParse(value) == null)) {
                return 'El DNI debe tener 8 dígitos numéricos';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxFormField(String title, bool value, ValueChanged<bool?> onChanged, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: FormField<bool>(
        initialValue: value,
        validator: (val) {
          if (isRequired && !val!) {
            return 'Debe seleccionar esta opción';
          }
          return null;
        },
        builder: (FormFieldState<bool> field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                title: Text(title, style: const TextStyle(color: Colors.white70)),
                value: value,
                onChanged: (newValue) {
                  onChanged(newValue);
                  field.didChange(newValue);
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.orange,
                checkColor: Colors.white,
                tileColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
              ),
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    field.errorText!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
