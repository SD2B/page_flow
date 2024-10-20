import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PageWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const PageWidget({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }

  // Method to create a copy of SectionWidget with a new key
  PageWidget copyWith({Key? key}) {
    return PageWidget(key: key ?? this.key, title: title, child: child);
  }
}

class MultiPageViewController {
  final Map<String, GlobalKey> _keys = {};

  // Method to register section keys
  void registerSection(String sectionName) {
    _keys[sectionName] = GlobalKey();
  }

  // Method to jump to a specific section
  void jumpToSection(String sectionName) {
    final key = _keys[sectionName];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // Getter to retrieve the keys map
  Map<String, GlobalKey> get keys => _keys;
}

class PageFlow extends HookWidget {
  final MultiPageViewController? controller;
  final List<Widget> sections;

  const PageFlow({super.key, this.controller, required this.sections});

  @override
  Widget build(BuildContext context) {
    // Initialize a controller if one isn't passed
    final scrollViewController =
        controller ?? useRef(MultiPageViewController()).value;

    // Register each section with a key
    for (var section in sections) {
      if (section is PageWidget) {
        scrollViewController.registerSection(section.title);
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: sections.map((section) {
          if (section is PageWidget) {
            // Use the registered key for each section
            return section.copyWith(
                key: scrollViewController.keys[section.title]);
          }
          return section;
        }).toList(),
      ),
    );
  }
}
