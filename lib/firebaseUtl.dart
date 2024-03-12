import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/model/task.dart';

class FirebaseUtls {

  static CollectionReference<Task> getTaskCollection() {
    return
      FirebaseFirestore.instance.collection(Task.collectionName).
      withConverter<Task>(
          fromFirestore: ((snapshot, options) =>
              Task.fromFireStore(snapshot.data()!)),

          toFirestore: (task, _) => task.toFireStore()
      );
  }

  static Future<void> AddTaskToFireStore(Task task) {
    CollectionReference<Task> taskcollection = getTaskCollection();
    DocumentReference<Task> taskDocRef = taskcollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task) async {
    await getTaskCollection().doc(task.id).delete();
  }

}
