import 'dart:math' as math;
import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  final String nodeName;
  final String status;

  const NodeWidget({super.key, required this.nodeName, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: status == "Active" ? Colors.green : Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.computer, size: 30, color: status == "Active" ? Colors.green : Colors.red),
          const SizedBox(height: 8),
          Text(nodeName, style: const TextStyle(fontSize: 14)),
          Text('Status: $status', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class NodeNetworkWidget extends StatelessWidget {
  final List<NodeWidget> nodeWidgets;

  const NodeNetworkWidget({super.key, required this.nodeWidgets});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size containerSize = Size(constraints.maxWidth, constraints.maxHeight);

        final positions = List.generate(nodeWidgets.length, (index) {
          final theta = (index / (nodeWidgets.length)) * 2 * math.pi;
          final radius = containerSize.width / 5;
          return Offset(
            containerSize.width / 2 + radius * math.cos(theta),
            containerSize.height / 2 + radius * math.sin(theta),
          );
        });

        return CustomPaint(
          painter: NodeConnectionPainter(nodePositions: positions, containerSize: containerSize),
          child: Stack(
            children: [
              Positioned(
                left: containerSize.width / 2 - 30,
                top: containerSize.height / 2 - 30,
                child: const NodeWidget(nodeName: 'Managing Application', status: 'Active'),
              ),
              ...List.generate(nodeWidgets.length, (index) {
                return Positioned(
                  left: positions[index].dx - 30,
                  top: positions[index].dy - 30,
                  child: nodeWidgets[index],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class NodeConnectionPainter extends CustomPainter {
  final List<Offset> nodePositions;
  final Size containerSize;

  NodeConnectionPainter({required this.nodePositions, required this.containerSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade200
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    final center = Offset(containerSize.width / 2, containerSize.height / 2);

    for (var nodePosition in nodePositions) {
      canvas.drawLine(center, nodePosition, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
