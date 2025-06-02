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
  bool _acceptsCash = false;
  bool _acceptsYapePlin = false;
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
              _buildTextFormField(_businessNameController, 'Nombre del negocio/restaurante'),
              _buildTextFormField(_rucController, 'RUC', keyboardType: TextInputType.number),
              DialogPickerFormField( // Replaced DropdownButtonFormField
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
              _buildTextFormField(_businessDescriptionController, 'Descripción breve (opcional)', isOptional: true, maxLines: 3),
              
              // Contact Details
              _buildSectionTitle('Datos de Contacto'),
              _buildTextFormField(_phoneController, 'Teléfono principal', keyboardType: TextInputType.phone),
              _buildTextFormField(_emailController, 'Correo corporativo', keyboardType: TextInputType.emailAddress),

              // Location
              _buildSectionTitle('Ubicación'),
              _buildTextFormField(_addressController, 'Dirección completa'),
              _buildTextFormField(_departamentoController, 'Departamento'),
              _buildTextFormField(_provinciaController, 'Provincia'),
              _buildTextFormField(_distritoController, 'Distrito'),
              _buildTextFormField(_locationReferenceController, 'Referencias de ubicación', isOptional: true),
              // TODO: Add GPS auto-detect / map pin functionality

              // Business Operations
              _buildSectionTitle('Operaciones del Negocio'),
              _buildTextFormField(_openingHoursController, 'Horarios de atención (Ej: L-V 9am-6pm)'),
              _buildCheckboxFormField('Acepta efectivo', _acceptsCash, (value) {
                setState(() {
                  _acceptsCash = value!;
                });
              }),
              _buildCheckboxFormField('Acepta Yape/Plin', _acceptsYapePlin, (value) {
                setState(() {
                  _acceptsYapePlin = value!;
                });
              }),
              
              // Legal & Financial
              _buildSectionTitle('Legal y Financiero (Simplificado)'),
              _buildTextFormField(_legalRepController, 'Nombre del Representante Legal'),
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

  Widget _buildTextFormField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text, bool isOptional = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label + (isOptional ? ' (Opcional)' : ''),
          labelStyle: TextStyle(color: Colors.grey[400]),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.orange),
          ),
        ),
        validator: (value) {
          if (!isOptional && (value == null || value.isEmpty)) {
            return 'Este campo es obligatorio';
          }
          if (label == 'Correo corporativo' && value != null && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Por favor ingresa un correo válido';
          }
          if (label == 'RUC' && value != null && (value.length != 11 || int.tryParse(value) == null)) {
            return 'El RUC debe tener 11 dígitos numéricos';
          }
          return null;
        },
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
