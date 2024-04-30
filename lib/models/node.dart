class Node {
  String id;
  String name;
  String status;
  String cpuUsage;
  String memoryUsage;
  String location;

  Node({
    required this.id,
    required this.name,
    required this.status,
    required this.cpuUsage,
    required this.memoryUsage,
    required this.location,
  });

  factory Node.fromJson(Map<dynamic, dynamic> json) {
    return Node(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      cpuUsage: json['CPU_usage'] as String,
      memoryUsage: json['memory_usage'] as String,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'CPU_usage': cpuUsage,
      'memory_usage': memoryUsage,
      'location': location,
    };
  }

  Map<String, dynamic> updateToJson() {
    return {
      'name': name,
      'status': status,
      'CPU_usage': cpuUsage,
      'memory_usage': memoryUsage,
      'location': location,
    };
  }
}
