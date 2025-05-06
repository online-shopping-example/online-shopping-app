import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home Screen'),
        backgroundColor: Colors.tealAccent,
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Admin Setting'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/adminHomeScreen/allCategories');
              },
              child: const Text('All Categories Screen'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                context.go('/adminHomeScreen/allCategories/allProducts');
              },
              child: const Text('All Products Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
