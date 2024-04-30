import 'package:distributed_os_manager/Widgets/show_add_node_dialog.dart';
import 'package:distributed_os_manager/Widgets/show_edit_node_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/node.dart';

class NodeManagementScreen extends StatefulWidget {
  const NodeManagementScreen({super.key});

  @override
  State<NodeManagementScreen> createState() => _NodeManagementScreenState();
}

class _NodeManagementScreenState extends State<NodeManagementScreen> {
  final DatabaseReference _nodesRef = FirebaseDatabase.instance.ref('nodes');
  final DatabaseReference _nodesNetworkRef = FirebaseDatabase.instance.ref('networkSettings');
  List<Node> nodes = [];

  @override
  void initState() {
    super.initState();
    _nodesRef.onValue.listen((event) {
      var nodesSnapshot = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      List<Node> loadedNodes = [];
      nodesSnapshot.forEach((key, value) {
        loadedNodes.add(Node.fromJson({
          'id': key,
          ...value as Map<dynamic, dynamic>,
        }));
      });
      setState(() {
        nodes = loadedNodes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Node Management'),
        actions: <Widget>[
          TextButton.icon(onPressed: () => showAddNodeDialog(context), icon: const Icon(Icons.add), label: const Text("Add New Node")),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: DataTable(
              columnSpacing: 38.0,
              headingRowColor: MaterialStateProperty.all(Colors.blueGrey[200]),
              columns: const [
                DataColumn(label: Text('ID',style: TextStyle(fontWeight: FontWeight.w800),)),
                DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.w800),)),
                DataColumn(label: Text('Status',style: TextStyle(fontWeight: FontWeight.w800),)),
                DataColumn(label: Text('CPU Usage',style: TextStyle(fontWeight: FontWeight.w800),)),
                DataColumn(label: Text('Memory Usage',style: TextStyle(fontWeight: FontWeight.w800),)),
                DataColumn(label: Text('Location',style: TextStyle(fontWeight: FontWeight.w800),)),
                DataColumn(label: Text('Actions',style: TextStyle(fontWeight: FontWeight.w800),)),
              ],
              rows: nodes.map((node) => DataRow(cells: [
                DataCell(Text(node.id)),
                DataCell(Text(node.name)),
                DataCell(Text(node.status)),
                DataCell(Text(node.cpuUsage)),
                DataCell(Text(node.memoryUsage)),
                DataCell(Text(node.location)),
                DataCell(Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () =>showEditNodeDialog(context, node),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteNode(node.id,node.name);
                      },
                    ),
                  ],
                )),
              ])).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _deleteNode(String nodeId,String nodeName) {
    _nodesRef.child(nodeId).remove();
    _nodesNetworkRef.child(nodeName).remove();
  }
}