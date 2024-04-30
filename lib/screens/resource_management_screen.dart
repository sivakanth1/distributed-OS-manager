import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:distributed_os_manager/models/process.dart';

class ResourceManagementScreen extends StatefulWidget {
  const ResourceManagementScreen({super.key});

  @override
  State<ResourceManagementScreen> createState() => _ResourceManagementScreenState();
}

class _ResourceManagementScreenState extends State<ResourceManagementScreen> {
  final DatabaseReference _nodesRef = FirebaseDatabase.instance.ref('resources');
  Map<String, List<Process>> nodeProcesses = {};
  Map<String, List<Service>> nodeServices = {};

  @override
  void initState() {
    super.initState();
    _nodesRef.onValue.listen((event) {
      var nodesSnapshot = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      Map<String, List<Process>> processes = {};
      Map<String, List<Service>> services = {};

      nodesSnapshot.forEach((nodeId, nodeData) {
        var nodeMap = nodeData as Map<dynamic, dynamic>;
        if (nodeMap.containsKey('processes')) {
          processes[nodeId] = (nodeMap['processes'] as Map<dynamic, dynamic>).values.map<Process>((json) => Process.fromJson(json)).toList();
        }
        if (nodeMap.containsKey('services')) {
          services[nodeId] = (nodeMap['services'] as Map<dynamic, dynamic>).values.map<Service>((json) => Service.fromJson(json)).toList();
        }
      });

      setState(() {
        nodeProcesses = processes;
        nodeServices = services;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resource Management'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: ListView(
        children: nodeProcesses.keys.map((nodeId) {
          var processes = nodeProcesses[nodeId] ?? [];
          var services = nodeServices[nodeId] ?? [];
          return ExpansionTile(
            title: Text('Node: $nodeId'),
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Status')),
                ],
                rows: [
                  ...processes.map(
                        (process) => DataRow(
                      cells: [
                        const DataCell(Text('Process')),
                        DataCell(Text(process.name)),
                        DataCell(Text(process.status)),
                      ],
                    ),
                  ),
                  ...services.map(
                        (service) => DataRow(
                      cells: [
                        const DataCell(Text('Service')),
                        DataCell(Text(service.name)),
                        DataCell(Text(service.status)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
