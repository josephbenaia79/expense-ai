import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;

  const ExpenseTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.monetization_on, color: Colors.white),
      ),
      title: Text(expense.title),
      subtitle: Text(expense.category),
      trailing: Text(
        "KES ${expense.amount}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}