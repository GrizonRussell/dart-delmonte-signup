// lib/steps/education_form.dart
import 'package:flutter/material.dart';

class EducationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> formData;

  EducationForm({required this.formKey, required this.formData});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          _buildTextField(
            'College Course',
            'collegeCourse',
            formData,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'This field is required'
                  : null;
            },
          ),
          _buildTextField(
            'Graduate Course',
            'graduateCourse',
            formData,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'This field is required'
                  : null;
            },
          ),
          _buildTextField(
            'Date of Graduation',
            'graduationDate',
            formData,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'This field is required'
                  : null;
            },
          ),
          _buildTextField(
            'PRC License No.',
            'prcLicenseNo',
            formData,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'This field is required'
                  : null;
            },
          ),
          SizedBox(height: 20), // Add some spacing
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String key,
    Map<String, String> formData, {
    FormFieldValidator<String>? validator,
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
        validator: validator,
        onSaved: (value) {
          formData[key] = value ?? '';
        },
      ),
    );
  }
}
