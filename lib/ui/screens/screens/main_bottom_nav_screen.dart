import 'package:flutter/material.dart';


class MainBottomNavScreen extends StatefulWidget { //ট্যাব পরিবর্তন হলে UI-ও পরিবর্তন হবে।
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0; //এটা মনে রাখে এখন কোন ট্যাব সিলেক্ট করা আছে।0 মানে প্রথম ট্যাব → New Tasks

  final List<Widget> _screens = const [
    //NewTasksScreen(),
    //ProgressTasksScreen(),
    //CompletedTasksScreen(),
    //CancelledTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;//_selectedIndex আপডেট হবে
          setState(() {});//setState() UI রিফ্রেশ করবে
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.change_circle_outlined), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Cancelled'),


          //0	New 1	In Progress 2	Completed 3	Cancelled
        ],
      ),
    );
  }
}