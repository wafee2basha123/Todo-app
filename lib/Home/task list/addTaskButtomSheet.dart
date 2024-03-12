import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/firebaseUtl.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/provider/Listprovider.dart';
import '../../mytheme.dart';

class AddTaskButtomSheet extends StatefulWidget {
  final Function(String, String, DateTime) onTaskAdded;

  const AddTaskButtomSheet({Key? key, required this.onTaskAdded}) : super(key: key);

  @override
  State<AddTaskButtomSheet> createState() => _AddTaskButtomSheetState();
}

class _AddTaskButtomSheetState extends State<AddTaskButtomSheet> {
  late bool _isAddingTask = false;

  var selectDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (context, provider, _) {
        var currentTheme = Theme.of(context);
        Color? textColor;
        Color? buttonColor;

        // Set colors based on theme mode
        if (provider.appTheme == ThemeMode.dark) {
          textColor = MyTheme.whiteColor;
          buttonColor = MyTheme.primaryColor;
        } else {
          textColor = MyTheme.blackColor;
          buttonColor = MyTheme.primaryColor; // Use primary color for button in light mode
        }

        return Container(
          color: provider.appTheme == ThemeMode.dark ?
          MyTheme.backgroundDarkColor : MyTheme.whiteColor, // Set background color based on theme mode
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center( // Center the text
                  child: Text(
                    'Add New Task',
                    style: currentTheme.textTheme.titleMedium?.copyWith(color: textColor),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Please enter a task title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Task Title',
                          hintStyle: TextStyle(color: textColor),
                        ),
                        onChanged: (value) {
                          setState(() {
                            title = value; // Update the title variable
                          });
                        },
                        style: TextStyle(color: textColor),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Task Description',
                          hintStyle: TextStyle(color: textColor),
                        ),
                        maxLines: 4,
                        onChanged: (value) {
                          setState(() {
                            description = value; // Update the description variable
                          });
                        },
                        style: TextStyle(color: textColor),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        'Select Date ',
                        style: currentTheme.textTheme.titleMedium?.copyWith(color: textColor),
                      ),
                      const SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                          showCalendar(context);
                        },
                        child: Text(
                          '${selectDate.day}/${selectDate.month}/${selectDate.year}',
                          style: currentTheme.textTheme.titleSmall?.copyWith(color: textColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20,),

                      ElevatedButton(
                        onPressed: _isAddingTask ? null : () {
                          addTask(context);
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor, // Set the button color
                        ),
                        child: Text(
                          'Add',
                          style: currentTheme.textTheme.titleMedium?.copyWith(color: textColor),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCalendar(BuildContext context) async {
    var chosen = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (chosen != null) {
      setState(() {
        selectDate = chosen;
      });
    }
  }

  Future<void> addTask(BuildContext context) async {
    var listProvider = Provider.of<ListProvider>(context, listen: false);
    if (formKey.currentState?.validate() == true) {
      setState(() {
        _isAddingTask = true;
      });

      Task task = Task(title: title, description: description, dateTime: selectDate);
      await FirebaseUtls.AddTaskToFireStore(task);
      listProvider.getAllTasksFromFireStore();

      Navigator.pop(context);
    }
  }
}
