import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsdo/model/taskmodel.dart';

class DataRepository {
  final CollectionReference _collectionReferenceC =
      FirebaseFirestore.instance.collection('cin');
  // final CollectionReference _collectionReferenceF =
  //     FirebaseFirestore.instance.collection('fen');

  Stream<QuerySnapshot> getStream() {
    return _collectionReferenceC.snapshots();
  }

  Future<void> addTask(TaskModel data) {
    return _collectionReferenceC.doc(data.date).set(data.toMap());
  }

  // void updateTask(TaskModel data) async {
  //   await _collectionReferenceC.doc(pet.referenceId).update(pet.toJson());
  // }

  void deleteTask(TaskModel data) async {
    await _collectionReferenceC.doc(data.toString()).delete();
  }
}
