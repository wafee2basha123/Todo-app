import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Home/task%20list/taskListItem.dart';

import '../../mytheme.dart';
import '../../provider/Listprovider.dart';

class TaskListTab extends StatefulWidget {
  const TaskListTab({Key? key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  late ListProvider listProvider; // Declare listProvider here

  @override
  void initState() {
    super.initState();
    listProvider = Provider.of<ListProvider>(
        context, listen: false); // Initialize listProvider
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStore();
    }
  }

  @override
  Widget build(BuildContext context) {
    var textColor = listProvider.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 32.0,
          ),
          _changeDayStructureExample(textColor),
          const SizedBox(
            height: 32.0,
          ),
          const SizedBox(height: 20),
          // Add some space between the calendar and task list
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskListItem(
                  task: listProvider.tasksList[index],
                );
              },
              itemCount: listProvider.tasksList.length,
            ),
          ),
        ],
      ),
    );
  }

  EasyDateTimeLine _changeDayStructureExample(Color textColor) {
    return EasyDateTimeLine(
      initialDate: listProvider.selectedDate,
      // Access selectedDate from listProvider
      onDateChange: (date) {
        setState(() {
          listProvider.selectedDate =
              date; // Update selectedDate through listProvider
        });
        listProvider.changeSelectedDate(date);
      },
      activeColor: MyTheme.primaryColor,
      headerProps: const EasyHeaderProps(
        dateFormatter: DateFormatter.monthOnly(),
      ),
      dayProps: EasyDayProps(
        height: 56.0,
        width: 56.0,
        dayStructure: DayStructure.dayNumDayStr,
        inactiveDayStyle: DayStyle(
          borderRadius: 50.0,
          dayNumStyle: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: textColor, // Use textColor here
          ),
        ),
        activeDayStyle: DayStyle(
          dayNumStyle: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: textColor, // Use textColor here
          ),
        ),
      ),
    );
  }
}