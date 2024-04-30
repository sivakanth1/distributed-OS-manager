import 'package:distributed_os_manager/Widgets/show_edit_node_network.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/node_network_setting_model.dart';

class NetworkSettingsScreen extends StatefulWidget {
  const NetworkSettingsScreen({super.key});

  @override
  State<NetworkSettingsScreen> createState() => _NetworkSettingsScreenState();
}

class _NetworkSettingsScreenState extends State<NetworkSettingsScreen> {
  List<NodeNetworkSetting> nodes = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('networkSettings');
    DatabaseEvent event = await ref.once();
    Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
    List<NodeNetworkSetting> fetchedNodes = [];
    data.forEach((id, value) {
      fetchedNodes.add(NodeNetworkSetting.fromJson(id, value));
    });
    setState(() {
      nodes = fetchedNodes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchData,
          ),
        ],
      ),
      body: Center(
        child: DataTable(
          columnSpacing: 38.0,
          headingRowColor: MaterialStateProperty.all(Colors.blueGrey[200]),
          columns: const [
            DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.w800),)),
            DataColumn(label: Text('IP Address',style: TextStyle(fontWeight: FontWeight.w800),)),
            DataColumn(label: Text('Subnet',style: TextStyle(fontWeight: FontWeight.w800),)),
            DataColumn(label: Text('Edit',style: TextStyle(fontWeight: FontWeight.w800),)),
          ],
          rows: nodes.map((node) => DataRow(
            cells: [
              DataCell(Text(node.nodeId.toString())),
              DataCell(Text(node.ipAddress)),
              DataCell(Text(node.subnet)),
              DataCell(IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                   showEditNodeNetworkDialog(context, node);
                },
              )),
            ],
          )).toList(),
        ),
      )
    );
  }
}
