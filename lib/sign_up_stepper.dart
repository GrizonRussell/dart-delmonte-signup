import 'package:flutter/material.dart';
import 'steps/Step1_personal_info_form.dart';
import 'steps/Step2_education_form.dart';
import 'steps/Step3_license_form.dart';
import 'steps/Step4_employment_form.dart';
import 'steps/Step5_knowledge_form.dart';
import 'steps/Step6_skills_form.dart';
import 'steps/Step7_training_form.dart';
import 'steps/Step8_subscribe_email_form.dart';
import 'steps/Step9_complete_screen_form.dart';

class SignUpStepper extends StatefulWidget {
  @override
  _SignUpStepperState createState() => _SignUpStepperState();
}

class _SignUpStepperState extends State<SignUpStepper> {
  int _currentStep = 0;
  final Map<String, String> _formData = {
    'firstName': '',
    'lastName': '',
    'middleName': '',
    'email': '',
    'alternateEmail': '',
    'contact': '',
    'alternateContact': '',
    'presentAddress': '',
    'permanentAddress': '',
    'gender': '',
    'dob': '',
    'sss': '',
    'tin': '',
    'philhealth': '',
    'pagibig': '',
    'password': '',
    'confirmPassword': '',
    'collegeCourse': '',
    'graduateCourse': '',
    'graduationDate': '',
    'prcLicenseNo': '',
    'licenseType': '',
    'licenseNo': '',
    'expirationDate': '',
    'previousEmployer': '',
    'position': '',
    'yearsOfExperience': '',
    'knowledge': '',
    'skills': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 64, 40, 1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  FutureBuilder(
                    future: precacheImage(
                        AssetImage('images/delmonte.png'), context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Image.asset(
                          'images/delmonte.png',
                          height: 80,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Delmonte Signup",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stepper(
                type: StepperType.vertical,
                currentStep: _currentStep,
                onStepTapped: (step) => setState(() => _currentStep = step),
                onStepContinue: _onStepContinue,
                onStepCancel: _onStepCancel,
                steps: _buildSteps(),
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Row(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: const Text('Next'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF004d00),
                          backgroundColor: Colors.white,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                6.0), // Set the desired border radius
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Prev'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          backgroundColor: const Color.fromRGBO(14, 90, 53, 1),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                6.0), // Set the desired border radius
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onStepContinue() {
    if (_currentStep == 0) {
      if (_formKeys[0].currentState?.validate() ?? false) {
        _formKeys[0].currentState?.save();
        setState(() => _currentStep += 1);
      }
    } else if (_currentStep == 1) {
      if (_formKeys[1].currentState?.validate() ?? false) {
        _formKeys[1].currentState?.save();
        setState(() => _currentStep += 1);
      }
    } else if (_currentStep == 2) {
      if (_formKeys[2].currentState?.validate() ?? false) {
        _formKeys[2].currentState?.save();
        setState(() => _currentStep += 1);
      }
    } else if (_currentStep == 3) {
      if (_formKeys[3].currentState?.validate() ?? false) {
        _formKeys[3].currentState?.save();
        setState(() => _currentStep += 1);
      }
    } else if (_currentStep == 4) {
      if (_formKeys[4].currentState?.validate() ?? false) {
        _formKeys[4].currentState?.save();
        setState(() => _currentStep += 1);
      }
    } else if (_currentStep == 5) {
      if (_formKeys[5].currentState?.validate() ?? false) {
        _formKeys[5].currentState?.save();
        setState(() => _currentStep += 1);
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: const Text(
          'Step 1: Personal Information',
          style: TextStyle(color: Colors.white),
        ),
        content: PersonalInfoForm(
          formKey: _formKeys[0],
          formData: _formData,
        ),
        isActive: _currentStep >= 0,
        state: _stepState(0),
      ),
      Step(
        title: const Text(
          'Step 2: Educational Background',
          style: TextStyle(color: Colors.white),
        ),
        content: EducationForm(
          formKey: _formKeys[1],
          formData: _formData,
        ),
        isActive: _currentStep >= 1,
        state: _stepState(1),
      ),
      Step(
        title: const Text(
          'Step 3: Licenses',
          style: TextStyle(color: Colors.white),
        ),
        content: LicenseForm(
          formKey: _formKeys[2],
          formData: _formData,
        ),
        isActive: _currentStep >= 2,
        state: _stepState(2),
      ),
      Step(
        title: const Text(
          'Step 4: Employment History',
          style: TextStyle(color: Colors.white),
        ),
        content: EmploymentForm(
          formKey: _formKeys[3],
          formData: _formData,
        ),
        isActive: _currentStep >= 3,
        state: _stepState(3),
      ),
      // Step(
      //   title: const Text(
      //     'Step 5: Knowledge and Compliance',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   content: KnowledgeForm(
      //     formKey: _formKeys[4],
      //     formData: _formData,
      //   ),
      //   isActive: _currentStep >= 4,
      //   state: _stepState(4),
      // ),
      // Step(
      //   title: const Text(
      //     'Step 6: Skills',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   content: SkillsForm(
      //     formKey: _formKeys[5],
      //     formData: _formData,
      //   ),
      // ),
    ];
  }

  StepState _stepState(int step) {
    if (_currentStep == step) {
      return StepState.indexed;
    } else if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  // Define a list of form keys for each step
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(), // Personal Info
    GlobalKey<FormState>(), // Education
    GlobalKey<FormState>(), // License
    GlobalKey<FormState>(), // Employment
    GlobalKey<FormState>(), // Knowledge and Compliance
    GlobalKey<FormState>(), // Skills
  ];
}
