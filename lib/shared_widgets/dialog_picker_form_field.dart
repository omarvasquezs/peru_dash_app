import 'package:flutter/material.dart';

class DialogPickerFormField extends StatefulWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final IconData? icon;

  const DialogPickerFormField({
    super.key,
    required this.label,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.icon,
  });

  @override
  State<DialogPickerFormField> createState() => _DialogPickerFormFieldState();
}

class _DialogPickerFormFieldState extends State<DialogPickerFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(DialogPickerFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showOptionsDialog(BuildContext context) async {
    final String? selectedValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D3748), // Darker background for dialog
          title: Text('Selecciona ${widget.label}', style: const TextStyle(color: Colors.white)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.items[index];
                return ListTile(
                  title: Text(item, style: const TextStyle(color: Colors.white70)),
                  onTap: () {
                    Navigator.of(context).pop(item);
                  },
                  // Highlight selected item
                  selected: widget.value == item,
                  selectedTileColor: Colors.orange.withAlpha((0.2 * 255).round()),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar', style: TextStyle(color: Colors.orange)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (selectedValue != null) {
      widget.onChanged(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _controller,
        readOnly: true,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.grey[400]),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.orange),
          ),
          suffixIcon: Icon(widget.icon ?? Icons.arrow_drop_down, color: Colors.grey[400]),
        ),
        onTap: () => _showOptionsDialog(context),
        validator: widget.validator,
      ),
    );
  }
}
