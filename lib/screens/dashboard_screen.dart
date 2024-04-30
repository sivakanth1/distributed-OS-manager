import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../Widgets/node_widget.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  Stream<List<NodeWidget>> _getNodesStream() {
    return FirebaseDatabase.instance.ref('nodes').onValue.map((event) {
      Map<dynamic, dynamic> nodesMap = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      List<NodeWidget> nodeWidgets = nodesMap.entries.map((entry) {
        return NodeWidget(
          nodeName: entry.value['name'],
          status: entry.value['status'],
        );
      }).toList();
      return nodeWidgets;
    });
  }


  void _navigateTo(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distributed OS Manager Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logout,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: const Text('Node Management'),
              onTap: () => _navigateTo('/nodeManagement'),
            ),
            ListTile(
              title: const Text('Resource Management'),
              onTap: () => _navigateTo('/resourceManagement'),
            ),
            ListTile(
              title: const Text('Network Settings'),
              onTap: () => _navigateTo('/networkSettings'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<NodeWidget>>(
                stream: _getNodesStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  List<NodeWidget> nodeWidgets = snapshot.data ?? [];
                  return NodeNetworkWidget(nodeWidgets: nodeWidgets);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
