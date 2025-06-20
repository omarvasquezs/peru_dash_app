import 'package:flutter/material.dart';
import 'package:peru_dash_app/shared_widgets/dialog_picker_form_field.dart'; // Import the new widget

class BecomeCourierScreen extends StatefulWidget {
  const BecomeCourierScreen({super.key});

  @override
  State<BecomeCourierScreen> createState() => _BecomeCourierScreenState();
}

class _BecomeCourierScreenState extends State<BecomeCourierScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers & variables for form fields
  final _fullNameController = TextEditingController();
  final _dniController = TextEditingController();
  final _dobController = TextEditingController(); // For Date of Birth
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  // Add Departamento and Provincia controllers
  final _departamentoController = TextEditingController();
  final _provinciaController = TextEditingController();
  final _distritoController = TextEditingController(); // New text field for Distrito
  String? _selectedVehicleType;
  final _licensePlateController = TextEditingController();
  final _driverLicenseController = TextEditingController();
  bool _hasHelmet = false;
  bool _hasThermalBag = false;
  String? _selectedWorkSchedule; // Full-time, Part-time
  bool _agreedToTerms = false;
  bool _agreedToPrivacy = false;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // TODO: Populate with actual Lima districts and other relevant options
  final List<String> _vehicleTypes = ['Moto', 'Bicicleta', 'Auto'];
  final List<String> _workSchedules = ['Tiempo Completo', 'Medio Tiempo', 'Fines de Semana'];

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
    _driverLicenseController.dispose();
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
              primary: Colors.orange, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.white, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange, // button text color
              ),
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
      appBar: AppBar(
        title: const Text('Ser Repartidor Perú Dash'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: const Color(0xFF1A202C),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Personal Information
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
              _buildTextFormField(_addressController, 'Dirección de domicilio', icon: Icons.home, hintText: 'Ingresa tu dirección'),
              _buildTextFormField(_distritoController, 'Distrito', icon: Icons.location_city, hintText: 'Ingresa tu distrito'),
              _buildTextFormField(_provinciaController, 'Provincia', icon: Icons.location_city, hintText: 'Ingresa tu provincia'),
              _buildTextFormField(_departamentoController, 'Departamento', icon: Icons.location_city, hintText: 'Ingresa tu departamento'),
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

              // Vehicle & Equipment
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
              // SOAT and License are important but might be part of a later verification step
              // For now, we simplify the initial form.
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

              // Availability
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
              
              // Legal & Financial (Simplified)
              _buildSectionTitle('Información Adicional (Simplificado)'),
              const Text(
                'Documentos como SOAT, Licencia de Conducir, Antecedentes y Datos Bancarios se solicitarán posteriormente.',
                style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 12),
              ),
              const SizedBox(height: 20),

              // Terms & Conditions
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
        ),
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
