import 'package:flutter/material.dart';
import 'package:peru_dash_app/shared_widgets/dialog_picker_form_field.dart'; // Import the new widget

class RegisterBusinessScreen extends StatefulWidget {
  const RegisterBusinessScreen({super.key});

  @override
  State<RegisterBusinessScreen> createState() => _RegisterBusinessScreenState();
}

class _RegisterBusinessScreenState extends State<RegisterBusinessScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _businessNameController = TextEditingController();
  final _rucController = TextEditingController();
  String? _selectedBusinessType;
  final _businessDescriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _departamentoController = TextEditingController();
  final _provinciaController = TextEditingController();
  final _distritoController = TextEditingController();
  final _locationReferenceController = TextEditingController();
  final _openingHoursController = TextEditingController();
  final _legalRepController = TextEditingController();
  bool _agreedToTerms = false;
  bool _agreedToPrivacy = false;

  // TODO: Populate with actual Lima districts
  final List<String> _businessTypes = ['Restaurante', 'Farmacia', 'Supermercado', 'Tienda', 'Otro'];

  @override
  void dispose() {
    _businessNameController.dispose();
    _rucController.dispose();
    _businessDescriptionController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _departamentoController.dispose();
    _provinciaController.dispose();
    _distritoController.dispose();
    _locationReferenceController.dispose();
    _openingHoursController.dispose();
    _legalRepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar mi Negocio'),
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
              // Basic Information
              _buildSectionTitle('Información Básica'),
              _buildTextFormField(
                _businessNameController,
                'Nombre del negocio/restaurante',
                icon: Icons.store,
                hintText: 'Ingresa el nombre de tu negocio',
              ),
              _buildTextFormField(
                _rucController,
                'RUC',
                keyboardType: TextInputType.number,
                icon: Icons.badge,
                hintText: 'Ingresa el RUC',
              ),
              // Tipo de negocio label
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                child: Text(
                  'Tipo de negocio',
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
              DialogPickerFormField(
                label: 'Tipo de negocio',
                value: _selectedBusinessType,
                items: _businessTypes,
                onChanged: (value) {
                  setState(() {
                    _selectedBusinessType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Este campo es obligatorio';
                  return null;
                },
              ),
              _buildTextFormField(
                _businessDescriptionController,
                'Descripción breve (opcional)',
                isOptional: true,
                maxLines: 3,
                hintText: 'Ingresa una descripción breve',
              ),
              
              // Contact Details
              _buildSectionTitle('Datos de Contacto'),
              _buildTextFormField(
                _phoneController,
                'Teléfono principal',
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
                hintText: 'Ingresa tu teléfono',
              ),
              _buildTextFormField(
                _emailController,
                'Correo corporativo',
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
                hintText: 'Ingresa tu correo',
              ),

              // Location
              _buildSectionTitle('Ubicación'),
              _buildTextFormField(
                _addressController,
                'Dirección de domicilio',
                icon: Icons.location_on,
                hintText: 'Ingresa la dirección completa',
              ),
              _buildTextFormField(
                _distritoController,
                'Distrito',
                icon: Icons.map,
                hintText: 'Ingresa el distrito',
              ),
              _buildTextFormField(
                _provinciaController,
                'Provincia',
                icon: Icons.location_city,
                hintText: 'Ingresa la provincia',
              ),
              _buildTextFormField(
                _departamentoController,
                'Departamento',
                icon: Icons.apartment,
                hintText: 'Ingresa el departamento',
              ),
              _buildTextFormField(
                _locationReferenceController,
                'Referencias de ubicación',
                isOptional: true,
                icon: Icons.note,
                hintText: 'Ingresa referencias de ubicación',
              ),
              // TODO: Add GPS auto-detect / map pin functionality

              // Business Operations
              _buildSectionTitle('Operaciones del Negocio'),
              _buildTextFormField(
                _openingHoursController,
                'Horarios de atención (Ej: L-V 9am-6pm)',
                icon: Icons.access_time,
                hintText: 'Ingresa los horarios de atención',
                maxLines: 3,
              ),
              
              // Legal & Financial
              _buildSectionTitle('Legal y Financiero'),
              _buildTextFormField(
                _legalRepController,
                'Nombre del Representante Legal',
                icon: Icons.person,
                hintText: 'Ingresa el nombre del representante legal',
              ),
              _buildTextFormField(
                TextEditingController(),
                'Teléfono del Representante Legal',
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
                hintText: 'Ingresa el teléfono del representante legal',
              ),
              _buildTextFormField(
                TextEditingController(),
                'DNI del Representante Legal',
                keyboardType: TextInputType.number,
                icon: Icons.badge,
                hintText: 'Ingresa el DNI del representante legal',
                maxLength: 8,
              ),
              const SizedBox(height: 10),
              const Text(
                'Documentos como Licencia de Funcionamiento, Certificado DIGESA (si aplica) y Datos Bancarios se solicitarán posteriormente.',
                style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 12),
              ),
              const SizedBox(height: 20),

              // Terms & Conditions
              _buildSectionTitle('Términos y Condiciones'),
              _buildCheckboxFormField('Acepto los Términos y Condiciones', _agreedToTerms, (value) {
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
                    // Process data
                    print('Formulario de Registro de Negocio Válido');
                    // TODO: Implement actual data submission
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Registrar Negocio', style: TextStyle(fontSize: 16, color: Colors.white)),
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
    int maxLines = 1,
    IconData? icon,
    String? hintText,
    bool readOnly = false,
    VoidCallback? onTap,
    int? maxLength,
    IconData? suffixIcon,
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
            maxLines: maxLines,
            readOnly: readOnly,
            onTap: onTap,
            maxLength: maxLength,
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
            validator: (value) {
              if (!isOptional && (value == null || value.isEmpty)) {
                return 'Este campo es obligatorio';
              }
              if (label.contains('Correo') && value != null && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Por favor ingresa un correo válido';
              }
              if (label == 'RUC' && value != null && (value.length != 11 || int.tryParse(value) == null)) {
                return 'El RUC debe tener 11 dígitos numéricos';
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
            return 'Debe aceptar esta condición';
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
                  padding: const EdgeInsets.only(left: 12.0), // Adjust padding to align with checkbox text
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
