import 'package:firebase_database/firebase_database.dart';

class PushDataService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<void> initializeDatabase() async {
    await _dbRef.set({
      "nodes": {
        "node1": {
          "id": "node1",
          "name": "Server A",
          "status": "Active",
          "CPU_usage": "40%",
          "memory_usage": "60%",
          "location": "Data Center 1"
        },
        "node2": {
          "id": "node2",
          "name": "Server B",
          "status": "Inactive",
          "CPU_usage": "10%",
          "memory_usage": "30%",
          "location": "Data Center 2"
        }
      },
      "resources": {
        "node1": {
          "services": {
            "service1": {
              "name": "Database Service",
              "status": "Running"
            },
            "service2": {
              "name": "Web Server",
              "status": "Stopped"
            }
          },
          "processes": {
            "process1": {
              "name": "mysqld",
              "status": "Active"
            },
            "process2": {
              "name": "nginx",
              "status": "Active"
            }
          }
        },
        "node2": {
          "services": {
            "service1": {
              "name": "File Server",
              "status": "Running"
            }
          },
          "processes": {
            "process1": {
              "name": "sshd",
              "status": "Active"
            }
          }
        }
      },
      "networkSettings": {
        "node1": {
          "IP": "192.168.1.1",
          "subnet": "255.255.255.0"
        },
        "node2": {
          "IP": "192.168.1.2",
          "subnet": "255.255.255.0"
        }
      }
    });
  }
}
