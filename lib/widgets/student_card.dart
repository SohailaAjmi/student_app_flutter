import 'package:flutter/material.dart';
import 'package:student_app/models/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const StudentCard({
    super.key,
    required this.student,
    required this.onEdit,
    required this.onDelete,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 8, offset: Offset(0, 3))
        ]
      ),
      child: Row(
        children: [
          const Icon(Icons.person, size: 60, color: Colors.blue,),
          const SizedBox(width: 15,),
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Age: ${student.age}"),
                  Text("City: ${student.city}"),
                ],
              ),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, color: Colors.blue,),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Colors.red,),
              ),
            ],
          )
        ],
      ),
    );
  }
}
