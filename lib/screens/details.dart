import 'package:flutter/material.dart';
import 'package:student_app/models/student.dart';

class DetailsPage extends StatelessWidget {
  final Student student;
  const DetailsPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(student.name),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 120,),
            const SizedBox(height: 20,),
            Text(student.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Age: ${student.age}"),
            Text("City: ${student.city}"),
          ],
        ),
      ),
    );
  }
}
