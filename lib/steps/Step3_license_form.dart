// lib/steps/license_form.dart
import 'package:flutter/material.dart';

class LicenseForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> formData;

  LicenseForm({required this.formKey, required this.formData});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          _buildTextField(
            'Index',
            'index',
            formData,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          _buildTextField(
            'License Type',
            'licenseType',
            formData,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'This field is required'
                  : null;
            },
          ),
          _buildTextField(
            'License',
            'license',
            formData,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'This field is required'
                  : null;
            },
          ),
          _buildTextField(
            'License No.',
            'licenseNo',
            formData,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'This field is required'
                  : null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String key,
    Map<String, String> formData, {
    FormFieldValidator<String>? validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          filled: true,
          fillColor: const Color.fromARGB(255, 25, 189, 109).withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromRGBO(11, 134, 74, 1).withOpacity(0.5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(11, 134, 74, 1)),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onSaved: (value) {
          formData[key] = value ?? '';
        },
      ),
    );
  }
}
