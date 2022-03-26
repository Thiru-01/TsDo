import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:tsdo/components/components.dart';
import 'package:tsdo/controller/controller.dart';

import 'package:tsdo/model/taskmodel.dart';

class DataRepository {
  String doc;
  late CollectionReference _collectionReferenceC;

  final CollectionReference _collectionReferenceTask =
      FirebaseFirestore.instance.collection('task');
  final CollectionReference _collectionReferenceFen =
      FirebaseFirestore.instance.collection('fen');
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  DataRepository(this.doc) {
    setRefe();
    makeListener();
  }

  setRefe() {
    _collectionReferenceC = FirebaseFirestore.instance.collection(doc);
  }

  void makeListener() {
    _collectionReferenceC.snapshots().listen((event) {
      dataConroller.getGraphData();
    });
  }

  Future<QuerySnapshot<Object?>> getStream() async {
    return await _collectionReferenceC.get();
  }

  Future<void> addCin(TaskModel data) {
    return _collectionReferenceC
        .doc(formatter.parse(data.date).millisecondsSinceEpoch.toString())
        .set(data.toMap());
  }

  Future<void> addTask(TaskModel data) {
    return _collectionReferenceTask.doc(data.date).set(data.toMap());
  }

  Future<void> addFen(TaskModel data) {
    return _collectionReferenceFen.doc(data.date).set(data.toMap());
  }

  void updateTask(TaskModel data) async {
    await _collectionReferenceC
        .doc(formatter.parse(data.date).millisecondsSinceEpoch.toString())
        .update(data.toMap());
  }

  Future<QuerySnapshot<Object?>> get7days() {
    return _collectionReferenceC
        .orderBy('timestamp', descending: true)
        .limit(7)
        .get();
  }

  void deleteContent(TaskModel data) async {
    await _collectionReferenceC.doc(data.date.toString()).delete();
  }
}
