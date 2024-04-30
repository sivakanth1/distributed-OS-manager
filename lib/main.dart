import 'package:distributed_os_manager/screens/dashboard_screen.dart';
import 'package:distributed_os_manager/screens/network_settings_screen.dart';
import 'package:distributed_os_manager/screens/node_management_screen.dart';
import 'package:distributed_os_manager/screens/resource_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distributed OS Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashBoardScreen(),
        '/nodeManagement': (context) => const NodeManagementScreen(),
        '/resourceManagement': (context) => const ResourceManagementScreen(),
        '/networkSettings': (context) => const NetworkSettingsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
