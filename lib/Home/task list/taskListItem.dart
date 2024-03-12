import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/firebaseUtl.dart';
import 'package:todoapp/mytheme.dart';
import 'package:todoapp/provider/Listprovider.dart';

import '../../model/task.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  const TaskListItem({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: const EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(12),
              onPressed: (context) {
                FirebaseUtls.deleteTaskFromFireStore(widget.task).timeout(
                  const Duration(milliseconds: 400),
                  onTimeout: () {
                    listProvider.getAllTasksFromFireStore();
                  },
                );
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _pressed = !_pressed;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.whiteColor,
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 4,
                    color: MyTheme.primaryColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.task.title ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            color: _pressed
                                ? MyTheme.greenColor
                                : MyTheme.primaryColor,
                          ),
                        ),
                        Text(
                          widget.task.description ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            color: _pressed
                                ? MyTheme.greenColor
                                : MyTheme.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pressed = !_pressed;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        color: MyTheme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _pressed
                          ? Text(
                        'DONE!',
                        style: TextStyle(
                          color: MyTheme.greenColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          : Icon(
                        Icons.check,
                        color: MyTheme.whiteColor,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
