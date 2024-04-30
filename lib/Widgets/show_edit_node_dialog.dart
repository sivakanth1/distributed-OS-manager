import "package:flutter/material.dart";
import "package:distributed_os_manager/models/node.dart";
import "../services/firebase_service.dart";

Future<void> showEditNodeDialog(BuildContext context, Node node) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Node'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: node.name,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                      onSaved: (value) => node.name = value!,
                    ),
                    TextFormField(
                      initialValue: node.status,
                      decoration: const InputDecoration(labelText: 'Status'),
                      validator: (value) => value!.isEmpty ? 'Please enter status' : null,
                      onSaved: (value) => node.status = value!,
                    ),
                    TextFormField(
                      initialValue: node.cpuUsage,
                      decoration: const InputDecoration(labelText: 'CPU Usage'),
                      validator: (value) => value!.isEmpty ? 'Please enter CPU usage' : null,
                      onSaved: (value) => node.cpuUsage = value!,
                    ),
                    TextFormField(
                      initialValue: node.memoryUsage,
                      decoration: const InputDecoration(labelText: 'Memory Usage'),
                      validator: (value) => value!.isEmpty ? 'Please enter memory usage' : null,
                      onSaved: (value) => node.memoryUsage = value!,
                    ),
                    TextFormField(
                      initialValue: node.location,
                      decoration: const InputDecoration(labelText: 'Location'),
                      validator: (value) => value!.isEmpty ? 'Please enter location' : null,
                      onSaved: (value) => node.location = value!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                FirebaseService firebaseService = FirebaseService();
                firebaseService.updateNode(node).then((_) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Node updated successfully"))
                  );
                }).catchError((error) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to update node: $error"))
                  );
                });
              }
            },
          ),
        ],
      );
    },
  );
}
