import 'package:fb_rtdb_pg/applicant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ApplicantProvider extends ChangeNotifier {
  String _error = "";
  List<Applicant> _applicants = [];
  final String _collName = "applicants";
  final _dbRef = FirebaseDatabase.instance.ref();

  String get error => _error;
  List<Applicant> get applicants => _applicants;

  ApplicantProvider() {
    streamApplicants();
  }

  Future<Applicant?> getApplicant(String id) async {
    try {
      final res = await _dbRef.child(_collName).child(id).once();
      final values = res.snapshot.value;

      if (values != null) {
        Map values_ = values as Map;
        Map<Object?, Object?> map = values_.entries.first.value;
        return Applicant.fromMap(map.cast<String, dynamic>());
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      _error = e.message ?? "Unknown error";
      debugPrint(_error);
      return null;
    }
  }

  Future<bool> listApplicants() async {
    try {
      final res = await _dbRef.child(_collName).once();
      final values = res.snapshot.value;

      if (values != null) {
        Map values_ = values as Map;
        _applicants = values_.entries.map((e) {
          Map<Object?, Object?> map = e.value;
          return Applicant.fromMap(map.cast<String, dynamic>().values.first.cast<String, dynamic>());
        }).toList();
      }

      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      _error = e.message ?? "Unknown error";
      debugPrint(_error);
      return false;
    }
  }

  void streamApplicants() {
    try {
      _dbRef.child(_collName).onValue.listen((event) {
        final values = event.snapshot.value;

        if (values != null) {
          Map values_ = values as Map;
          _applicants = values_.entries.map((e) {
            Map<Object?, Object?> map = e.value;
            return Applicant.fromMap(map.cast<String, dynamic>().values.first.cast<String, dynamic>());
          }).toList();
          _applicants = [..._applicants];
          notifyListeners();
        }
      });
      notifyListeners();
    } on FirebaseException catch (e) {
      _error = e.message ?? "Unknown error";
      debugPrint(_error);
    }
  }

  Future<bool> createApplicant(Applicant applicant) async {
    try {
      await _dbRef.child(_collName).child(id(applicant.name)).push().set(applicant.toMap());
      return true;
    } on FirebaseException catch (e) {
      _error = e.message ?? "Unknown error";
      debugPrint(_error);
      return false;
    }
  }

  Future<bool> updateApplicant(Applicant applicant) async {
    try {
      await _dbRef.child(_collName).child(applicant.id).update(applicant.toMap());
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      _error = e.message ?? "Unknown error";
      debugPrint(_error);
      return false;
    }
  }

  Future<bool> deleteApplicant(String id) async {
    try {
      await _dbRef.child(_collName).child(id).remove();
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      _error = e.message ?? "Unknown error";
      debugPrint(_error);
      return false;
    }
  }
}

String id(String name) {
  return name.toLowerCase().replaceAll(" ", "");
}
