import 'package:flutter/material.dart';

class Training extends StatefulWidget {
  final List<Map<String, String>> trainingList;

  Training({required this.trainingList});

  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  List<Map<String, dynamic>> trainingData = [];
  int? indexToRemove;
  String alertMessage = '';
  bool showAlert = false;
  bool showTrainingModal = false;

  void handleShowAlert(String message) {
    setState(() {
      alertMessage = message;
      showAlert = true;
    });
  }

  void handleCloseAlert(int status) {
    if (status == 1) {
      setState(() {
        trainingData.removeAt(indexToRemove!);
        storeData("training", trainingData);
      });
    }
    setState(() {
      showAlert = false;
    });
  }

  void handleOpenTrainingModal() {
    setState(() {
      showTrainingModal = true;
    });
  }

  void handleCloseTrainingModal(Map<String, dynamic>? newTraining) {
    if (newTraining != null) {
      setState(() {
        trainingData.add(newTraining);
        storeData("training", trainingData);
      });
    }
    setState(() {
      showTrainingModal = false;
    });
  }

  void handleRemoveList(int index) {
    setState(() {
      indexToRemove = index;
    });
    handleShowAlert(
        "This action cannot be undone. It will permanently delete the item and remove it from your list.");
  }

  @override
  void initState() {
    super.initState();
    final savedTrainingData = retrieveData("training");
    if (savedTrainingData != null) {
      setState(() {
        trainingData = savedTrainingData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: handleOpenTrainingModal,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF5F5F5),
          ),
          child: Row(
            children: const [
              Icon(Icons.add, size: 16),
              SizedBox(width: 4),
              Text('Add Training', style: TextStyle(color: Color(0xFF0E4028))),
            ],
          ),
        ),
        const SizedBox(height: 10),
        trainingData.isNotEmpty
            ? Column(
                children: trainingData.map((data) {
                  int index = trainingData.indexOf(data);
                  return Card(
                    color: const Color(0xFF0E5A35),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(
                        widget.trainingList.firstWhere((item) =>
                            item['value'] == data['training'])['label']!,
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
                child: Text('No training added yet',
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
        if (showTrainingModal)
          AddTrainingModal(
            trainingList: widget.trainingList,
            onHide: handleCloseTrainingModal,
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

class AddTrainingModal extends StatelessWidget {
  final List<Map<String, String>> trainingList;
  final Function(Map<String, dynamic>?) onHide;

  AddTrainingModal({required this.trainingList, required this.onHide});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Select Training'),
          // Logic to select a training from the list
          ElevatedButton(
            onPressed: () {
              Map<String, dynamic> selectedTraining = {
                "training": trainingList[0]['value']
              }; // Example selection
              onHide(selectedTraining);
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
