import 'package:flutter/material.dart';

class Skills extends StatefulWidget {
  final List<Map<String, String>> skillList;

  Skills({required this.skillList});

  @override
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  List<Map<String, dynamic>> skillData = [];
  int? indexToRemove;
  String alertMessage = '';
  bool showAlert = false;
  bool showSkillsModal = false;

  void handleShowAlert(String message) {
    setState(() {
      alertMessage = message;
      showAlert = true;
    });
  }

  void handleCloseAlert(int status) {
    if (status == 1) {
      setState(() {
        skillData.removeAt(indexToRemove!);
        storeData("skills", skillData);
      });
    }
    setState(() {
      showAlert = false;
    });
  }

  void handleOpenSkillsModal() {
    setState(() {
      showSkillsModal = true;
    });
  }

  void handleCloseSkillsModal(Map<String, dynamic>? newSkill) {
    if (newSkill != null) {
      setState(() {
        skillData.add(newSkill);
        storeData("skills", skillData);
      });
    }
    setState(() {
      showSkillsModal = false;
    });
  }

  void handleRemoveList(int index) {
    setState(() {
      indexToRemove = index;
    });
    handleShowAlert(
        "This action cannot be undone. It will permanently delete the item and remove it from your list");
  }

  @override
  void initState() {
    super.initState();
    final savedSkills = retrieveData("skills");
    if (savedSkills != null) {
      setState(() {
        skillData = savedSkills;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: handleOpenSkillsModal,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF5F5F5),
          ),
          child: Row(
            children: const [
              Icon(Icons.add, size: 16),
              SizedBox(width: 4),
              Text('Add Skills', style: TextStyle(color: Color(0xFF0E4028))),
            ],
          ),
        ),
        const SizedBox(height: 10),
        skillData.isNotEmpty
            ? Column(
                children: skillData.map((data) {
                  int index = skillData.indexOf(data);
                  return Card(
                    color: const Color(0xFF0E5A35),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(
                        widget.skillList.firstWhere((item) =>
                            item['value'] == data['skills'])['label']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => handleRemoveList(index),
                      ),
                    ),
                  );
                }).toList(),
              )
            : const Center(
                child: Text('No skills added yet',
                    style: TextStyle(color: Colors.white)),
              ),
        if (showAlert)
          AlertDialog(
            title: const Text('Warning'),
            content: Text(alertMessage),
            actions: [
              TextButton(
                onPressed: () => handleCloseAlert(1),
                child: const Text('Confirm'),
              ),
              TextButton(
                onPressed: () => handleCloseAlert(0),
                child: const Text('Cancel'),
              ),
            ],
          ),
        if (showSkillsModal)
          AddSkillModal(
            skillList: widget.skillList,
            onHide: handleCloseSkillsModal,
          ),
      ],
    );
  }

  void storeData(String key, List<Map<String, dynamic>> data) {
    // Implement your local storage logic here
  }

  List<Map<String, dynamic>>? retrieveData(String key) {
    // Implement your local retrieval logic here
    return [];
  }
}

class AddSkillModal extends StatelessWidget {
  final List<Map<String, String>> skillList;
  final Function(Map<String, dynamic>?) onHide;

  AddSkillModal({required this.skillList, required this.onHide});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Select Skill'),
          // Logic to select a skill from the list
          ElevatedButton(
            onPressed: () {
              Map<String, dynamic> selectedSkill = {
                "skills": skillList[0]['value']
              }; // Example selection
              onHide(selectedSkill);
            },
            child: const Text('Add'),
          ),
          TextButton(
            onPressed: () => onHide(null),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
