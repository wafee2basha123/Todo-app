import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../firebaseUtl.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier{
  bool isDarkMode = false;
  List<Task> tasksList = [];
  late DateTime selectedDate = DateTime.now();

  ListProvider() {
    selectedDate = DateTime.now();
    // No need to call getAllTasksFromFirestore() here
  }
  void getAllTasksFromFireStore()async{
    QuerySnapshot<Task>  querySnapshot =  await FirebaseUtls.getTaskCollection().get();
    tasksList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();

    tasksList = tasksList.where((task) {
if(selectedDate.day == task.dateTime!.day &&
    selectedDate.month == task.dateTime!.month &&
    selectedDate.year == task.dateTime!.year ){
  return true;
}
return false;
}).toList();

    tasksList.sort((task1, task2){
      return task1.dateTime!.compareTo(task2.dateTime!);


    });

  notifyListeners();
  }
  void changeSelectedDate (DateTime newSelectedDate){
    selectedDate = newSelectedDate;
    getAllTasksFromFireStore();

  }
  String appLanguage = 'en';
  void changeLanguage (String newLanguage) {
    if(appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();

  }
  ThemeMode appTheme =  ThemeMode.light ;
  void changeTheme(ThemeMode newMode) {
    if (appTheme == newMode) {
      return;
    }
    appTheme = newMode;
    isDarkMode = appTheme == ThemeMode.dark; // Update isDarkMode based on the new theme
    notifyListeners();

}
}
