import 'package:distributed_os_manager/models/node_network_setting_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/node_data.dart';
import '../models/node.dart';

class FirebaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final DatabaseReference _nodesRef = FirebaseDatabase.instance.ref('nodes');

  Stream<int> getNumberOfNodes() {
    return _dbRef.child('nodes').onValue.map((event) {
      final nodesMap = event.snapshot.value as Map<dynamic, dynamic>?;
      return nodesMap?.length ?? 0;
    });
  }

  Future<void> addNode(NodeData nodeData) async {
    final newNodeRef = _dbRef.child('nodes').push();
    await newNodeRef.set(nodeData.nodeToJson());
  }

  Future<void> addNodeSettings(NodeNetworkSetting nodeNetworkSetting) async {
    final newNodeRef = _dbRef.child('networkSettings');
    await newNodeRef.child(nodeNetworkSetting.name.toString()).update(nodeNetworkSetting.toJson());
  }

  Future<void> updateNode(Node node) async {
    await _nodesRef.child(node.id).update(node.toJson());
  }

  void updateNodeNetwork(BuildContext context,NodeNetworkSetting node) {
    _dbRef.child('networkSettings').child(node.nodeId.toString()).update({
      'IP': node.ipAddress,
      'subnet': node.subnet,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Node updated successfully"))
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update node: $error"))
      );
    });
  }
}
