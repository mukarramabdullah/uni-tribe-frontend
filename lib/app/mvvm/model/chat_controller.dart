import 'package:get/get.dart';
import 'package:flutter/material.dart';

// Group Model
class Group {
  final String id;
  final String name;
  final String description;
  final String? coverImagePath;
  final String category;
  final IconData icon;
  final Color iconColor;
  final DateTime createdAt;

  Group({
    required this.id,
    required this.name,
    required this.description,
    this.coverImagePath,
    required this.category,
    required this.icon,
    required this.iconColor,
    required this.createdAt,
  });
}

// Controller to manage groups
class ChatController extends GetxController {
  final RxList<Group> groups = <Group>[].obs;

  void addGroup(Group group) {
    groups.insert(0, group);
  }

  Map<String, List<Group>> get groupedByCategory {
    Map<String, List<Group>> grouped = {};
    for (var group in groups) {
      if (!grouped.containsKey(group.category)) {
        grouped[group.category] = [];
      }
      grouped[group.category]!.add(group);
    }
    return grouped;
  }
}