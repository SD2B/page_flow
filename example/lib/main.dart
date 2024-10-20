import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_flow/page_flow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Scroll View Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollViewController = useRef(MultiPageViewController()).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Scroll View Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => scrollViewController.jumpToSection("Home"),
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => scrollViewController.jumpToSection("About"),
          ),
          IconButton(
            icon: const Icon(Icons.contact_mail),
            onPressed: () => scrollViewController.jumpToSection("Contact"),
          ),
        ],
      ),
      body: PageFlow(
        controller: scrollViewController, // Pass the controller here
        sections: [
          PageWidget(
              title: 'Home',
              child: Container(
                height: 800,
                width: 500,
                color: Colors.red,
              )),
          const SizedBox(height: 50),
          PageWidget(
              title: 'About',
              child: Container(
                height: 800,
                width: 500,
                color: Colors.yellow,
              )),
          const SizedBox(height: 50),
          PageWidget(
              title: 'Contact',
              child: Container(
                height: 800,
                width: 500,
                color: Colors.green,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => scrollViewController.jumpToSection("About"),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
