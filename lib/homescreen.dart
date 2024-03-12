import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/Listprovider.dart';
import 'Home/settings/settingsTab.dart';
import 'Home/task list/addTaskButtomSheet.dart';
import 'Home/task list/task list tab.dart';
import 'mytheme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<String> tasks = []; // Define tasks list to store added tasks

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ListProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: provider.appTheme == ThemeMode.dark ? MyTheme.darkmode : MyTheme.lightmode, // Use provider to get the theme
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 140,
          title: Text(
            'To Do List',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: tabs[selectedIndex],
        bottomNavigationBar: Container(
          color: provider.appTheme == ThemeMode.dark ? MyTheme.backgroundDarkColor :
          MyTheme.whiteColor, // Set the background color of the bottom navigation bar based on the current theme mode
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Task list',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              )
            ],
            selectedFontSize: 12,
            unselectedFontSize: 14,
            selectedItemColor: provider.appTheme == ThemeMode.dark ?
            MyTheme.primaryColor : Colors.blue, // Set the color of selected items based on the current theme mode
            unselectedItemColor: Colors.grey, // Set the color of unselected items
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Show the bottom sheet to add a new task
            showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskButtomSheet(
                onTaskAdded: (title, description, date) {
                  // Add the task details to the list
                  setState(() {
                    tasks.add('$title - $description - $date');
                  });
                  // Close the bottom sheet after adding the task
                  Navigator.pop(context);
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  List<Widget> tabs = [TaskListTab(), SettingTab()];
}
