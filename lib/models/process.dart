class Process {
  final String name;
  final String status;

  Process({required this.name, required this.status});

  factory Process.fromJson(Map<dynamic, dynamic> json) {
    return Process(
      name: json['name'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
    };
  }
}

class Service {
  final String name;
  final String status;

  Service({required this.name, required this.status});

  factory Service.fromJson(Map<dynamic, dynamic> json) {
    return Service(
      name: json['name'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
    };
  }
}
