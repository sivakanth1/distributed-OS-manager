class NodeData {
  String name;
  String status;
  String cpuUsage;
  String memoryUsage;
  String location;
  String ipAddress;
  String subnet;

  NodeData({
    required this.name,
    required this.status,
    required this.cpuUsage,
    required this.memoryUsage,
    required this.location,
    required this.ipAddress,
    required this.subnet,
  });

  Map<String, dynamic> nodeToJson() {
    return {
      'name': name,
      'status': status,
      'CPU_usage': cpuUsage,
      'memory_usage': memoryUsage,
      'location': location,
    };
  }

  Map<String, dynamic> networkToJson(){
    return {
        'IP': ipAddress,
        'subnet': subnet,
    };
  }
}
