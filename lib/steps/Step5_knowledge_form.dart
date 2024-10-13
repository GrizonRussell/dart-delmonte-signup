import 'package:flutter/material.dart';

class KnowledgeForm extends StatefulWidget {
  final List<Map<String, String>> knowledgeList;

  KnowledgeForm({required this.knowledgeList});

  @override
  _KnowledgeFormState createState() => _KnowledgeFormState();
}

class _KnowledgeFormState extends State<KnowledgeForm> {
  List<String> data = [];
  int? indexToRemove;
  String alertMessage = "";
  bool showAlert = false;

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  Future<void> _retrieveData() async {
    // Simulate data retrieval (e.g., SharedPreferences or local storage)
    final savedData = await _loadStoredData();
    if (savedData.isNotEmpty) {
      setState(() {
        data = savedData;
      });
    }
  }

  Future<List<String>> _loadStoredData() async {
    // Add logic to load stored data
    return [];
  }

  Future<void> _storeData(List<String> newData) async {
    // Add logic to store data
  }

  void _handleShowAlert(String message) {
    setState(() {
      alertMessage = message;
      showAlert = true;
    });
  }

  void _handleCloseAlert(int status) {
    if (status == 1 && indexToRemove != null) {
      setState(() {
        data.removeAt(indexToRemove!);
        _storeData(data);
        showAlert = false;
      });
    } else {
      setState(() {
        showAlert = false;
      });
    }
  }

  void _handleOpenModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddKnowledgeModal(onClose: _handleCloseModal);
      },
    );
  }

  void _handleCloseModal(String newKnowledge) {
    setState(() {
      data.add(newKnowledge);
      _storeData(data);
    });
  }

  void _handleRemoveList(int index) {
    setState(() {
      indexToRemove = index;
    });
    _handleShowAlert(
        "This action cannot be undone. It will permanently delete the item.");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _handleOpenModal,
          icon: Icon(Icons.add),
          label: Text('Add Knowledge and Compliance'),
        ),
        data.isNotEmpty
            ? Column(
                children: data.map((knowledgeItem) {
                  final int index = data.indexOf(knowledgeItem);
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.green[700],
                    child: ListTile(
                      title: Text(
                        widget.knowledgeList.firstWhere((item) =>
                                item['value'] == knowledgeItem)['label'] ??
                            '',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => _handleRemoveList(index),
                      ),
                    ),
                  );
                }).toList(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Text('No knowledge added yet', textAlign: TextAlign.center),
              ),
        if (showAlert)
          AlertDialog(
            content: Text(alertMessage),
            actions: [
              TextButton(
                onPressed: () => _handleCloseAlert(0),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => _handleCloseAlert(1),
                child: Text('Delete'),
              ),
            ],
          ),
      ],
    );
  }
}

class AddKnowledgeModal extends StatelessWidget {
  final Function(String) onClose;

  AddKnowledgeModal({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Add Knowledge'),
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter knowledge'),
            onFieldSubmitted: (value) {
              onClose(value);
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            onPressed: () {
              // You can handle form submission here
              Navigator.pop(context);
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
