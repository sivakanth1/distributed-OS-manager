import 'package:distributed_os_manager/services/firebase_service.dart';
import 'package:flutter/material.dart';
import '../models/node_network_setting_model.dart';

Future<void> showEditNodeNetworkDialog(BuildContext context, NodeNetworkSetting node) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nodeData = NodeNetworkSetting(
    nodeId: node.nodeId,
    name: node.name,
    ipAddress: node.ipAddress,
    subnet: node.subnet,
  );

  showDialog<void>(
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
                      initialValue: nodeData.ipAddress,
                      decoration: const InputDecoration(labelText: 'IP Address'),
                      onSaved: (value) => nodeData.ipAddress = value!,
                    ),
                    TextFormField(
                      initialValue: nodeData.subnet,
                      decoration: const InputDecoration(labelText: 'Subnet'),
                      onSaved: (value) => nodeData.subnet = value!,
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
                FirebaseService().updateNodeNetwork(context,nodeData);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
