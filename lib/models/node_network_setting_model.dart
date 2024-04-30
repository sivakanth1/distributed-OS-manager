class NodeNetworkSetting {
  String? nodeId;
  String? name;
  String ipAddress;
  String subnet;

  NodeNetworkSetting({
    this.nodeId,
    this.name,
    required this.ipAddress,
    required this.subnet,
  });

  factory NodeNetworkSetting.fromJson(String id, Map<dynamic, dynamic> json) {
    return NodeNetworkSetting(
      nodeId: id,
      ipAddress: json['IP'],
      subnet: json['subnet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IP': ipAddress,
      'subnet': subnet,
    };
  }
}
