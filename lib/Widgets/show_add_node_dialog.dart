import "package:distributed_os_manager/models/node_network_setting_model.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "../models/node_data.dart";
import "../services/firebase_service.dart";

Future<void> showAddNodeDialog(BuildContext context) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NodeData nodeData = NodeData(
    name: '',
    status: '',
    cpuUsage: '',
    memoryUsage: '',
    location: '',
    ipAddress: '',
    subnet: '',
  );

  final NodeNetworkSetting nodeNetworkSettingData = NodeNetworkSetting(
    name: '',
    ipAddress: '',
    subnet: '',
  ) ;

  void showToast(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add New Node'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                      onSaved: (value) => {
                        nodeData.name = value!,
                        nodeNetworkSettingData.name = value,
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Status'),
                      validator: (value) => value!.isEmpty ? 'Please enter status' : null,
                      onSaved: (value) => nodeData.status = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'CPU Usage'),
                      validator: (value) => value!.isEmpty ? 'Please enter CPU usage' : null,
                      onSaved: (value) => nodeData.cpuUsage = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Memory Usage'),
                      validator: (value) => value!.isEmpty ? 'Please enter memory usage' : null,
                      onSaved: (value) => nodeData.memoryUsage = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Location'),
                      validator: (value) => value!.isEmpty ? 'Please enter location' : null,
                      onSaved: (value) => nodeData.location = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'IP Address'),
                      validator: (value) => value!.isEmpty ? 'Please enter IP address' : null,
                      onSaved: (value) => {
                        nodeData.ipAddress = value!,
                        nodeNetworkSettingData.ipAddress = value,
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Subnet Mask'),
                      validator: (value) => value!.isEmpty ? 'Please enter subnet mask' : null,
                      onSaved: (value) => {
                        nodeData.subnet = value!,
                        nodeNetworkSettingData.subnet = value,
                      },
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
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                final firebaseService = FirebaseService();

                firebaseService.addNode(nodeData)
                    .then((_) => {
                      firebaseService.addNodeSettings(nodeNetworkSettingData).then((_) => showToast('Node added to the database.'))
                    })
                    .catchError((error) => showToast('Error adding node: $error'));
                Navigator.of(context).pop();
              }
            },

          ),
        ],
      );
    },
  );
}
