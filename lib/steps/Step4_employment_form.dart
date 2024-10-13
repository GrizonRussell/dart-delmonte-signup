// lib/steps/employment_form.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmploymentForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> formData;

  EmploymentForm({required this.formKey, required this.formData});

  @override
  _EmploymentFormState createState() => _EmploymentFormState();
}

class _EmploymentFormState extends State<EmploymentForm> {
  // Controllers for date fields
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime.now();
    if (controller.text.isNotEmpty) {
      try {
        initialDate = DateFormat.yMd().parse(controller.text);
      } catch (e) {
        // If parsing fails, use current date
        initialDate = DateTime.now();
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat.yMd().format(picked);
        // Update formData with the selected date
        if (controller == _startDateController) {
          widget.formData['startDate'] = controller.text;
        } else if (controller == _endDateController) {
          widget.formData['endDate'] = controller.text;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          _buildTextField(
            'Position',
            'position',
            widget.formData,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'This field is required'
                  : null;
            },
          ),
          _buildTextField(
            'Company',
            'company',
            widget.formData,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'This field is required'
                  : null;
            },
          ),
          _buildDateField(
            'Start Date',
            'startDate',
            widget.formData,
            controller: _startDateController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Start Date is required';
              }
              return null;
            },
          ),
          _buildDateField(
            'End Date',
            'endDate',
            widget.formData,
            controller: _endDateController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'End Date is required';
              }
              // Optional: Add logic to ensure End Date is after Start Date
              if (widget.formData['startDate'] != null &&
                  widget.formData['startDate']!.isNotEmpty) {
                try {
                  DateTime start =
                      DateFormat.yMd().parse(widget.formData['startDate']!);
                  DateTime end = DateFormat.yMd().parse(value);
                  if (end.isBefore(start)) {
                    return 'End Date cannot be before Start Date';
                  }
                } catch (e) {
                  // If parsing fails, skip date comparison
                }
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
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

  Widget _buildDateField(
    String label,
    String key,
    Map<String, String> formData, {
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _selectDate(context, controller),
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Colors.white),
              suffixIcon: const Icon(Icons.calendar_today, color: Colors.white),
              filled: true,
              fillColor:
                  const Color.fromARGB(255, 25, 189, 109).withOpacity(0.2),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        const Color.fromRGBO(11, 134, 74, 1).withOpacity(0.5)),
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
        ),
      ),
    );
  }
}
