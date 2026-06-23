import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense.dart';

class ExpenseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addExpense(Expense expense, String userId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .add(expense.toMap());
  }

  Stream<List<Expense>> getExpenses(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) {
              return Expense.fromMap(doc.id, doc.data());
            }).toList());
  }
}