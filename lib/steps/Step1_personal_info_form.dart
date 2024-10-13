// lib/steps/personal_info_form.dart
import 'package:flutter/material.dart';

class PersonalInfoForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> formData;

  PersonalInfoForm({required this.formKey, required this.formData});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          _buildTextField('First Name', 'firstName', formData),
          _buildTextField('Last Name', 'lastName', formData),
          _buildTextField('Middle Name', 'middleName', formData),
          _buildTextField(
            'Email',
            'email',
            formData,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              } else if (!RegExp(
                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(value)) {
                return 'Invalid email address';
              }
              return null;
            },
          ),
          _buildTextField(
            'Alternate Email',
            'alternateEmail',
            formData,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (!RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                    .hasMatch(value)) {
                  return 'Invalid email address';
                }
              }
              return null;
            },
          ),
          _buildTextField(
            'Contact Number',
            'contact',
            formData,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              } else if (!RegExp(r'^\+?[0-9]{1,14}$').hasMatch(value)) {
                return 'Invalid contact number format';
              }
              return null;
            },
          ),
          _buildTextField(
            'Alternate Contact Number',
            'alternateContact',
            formData,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              } else if (!RegExp(r'^\+?[0-9]{1,14}$').hasMatch(value)) {
                return 'Invalid contact number format';
              }
              return null;
            },
          ),
          _buildTextField('Gender', 'gender', formData),
          _buildTextField('SSS Number', 'sss', formData),
          _buildTextField('TIN', 'tin', formData),
          _buildTextField('Philhealth', 'philhealth', formData),
          _buildTextField('Pag-ibig', 'pagibig', formData),
          _buildTextField(
            'Password',
            'password',
            formData,
            obscureText: true,
            validator: (value) {
              if (value == null || value.length < 5) {
                return 'Password must be at least 5 characters';
              }
              return null;
            },
          ),
          _buildTextField(
            'Confirm Password',
            'confirmPassword',
            formData,
            obscureText: true,
            validator: (value) {
              if (value != formData['password']) {
                return 'Passwords do not match';
              }
              return null;
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
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          filled: true,
          fillColor:
              const Color.fromARGB(255, 25, 189, 109).withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromRGBO(11, 134, 74, 1).withOpacity(0.5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(11, 134, 74, 1)),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        obscureText: obscureText,
        validator: validator,
        onSaved: (value) {
          formData[key] = value ?? '';
        },
      ),
    );
  }
}
