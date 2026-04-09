import 'package:flutter/material.dart';
import 'package:student_app/models/student.dart';
import 'package:student_app/screens/add_student.dart';
import 'package:student_app/screens/details.dart';
import 'package:student_app/widgets/student_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Student> _students = [
    Student(name: "Sohaila", age: 25, city: "Cairo"),
    Student(name: "Mahmoud", age: 22, city: "Cairo"),
    Student(name: "Lama", age: 20, city: "Cairo"),
  ];

  void _addStudent(Student student) {
    setState(() => _students.add(student));
  }

  void _updateStudent(int index, Student student) {
    setState(() => _students[index] = student);
  }

  void _deleteStudent(int index) {
    setState(() => _students.removeAt(index));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  Future<void> _navigateToAdd() async{
    final newStudent = await Navigator.push<Student>(
      context,
      MaterialPageRoute(builder: (_) => const AddStudentPage())
    );
    if (!mounted) return;
    if (newStudent != null) {
      _addStudent(newStudent);
      _showSnackBar("Student Added");
    }
  }

  Future<void> _navigateToEdit(int index) async{
    final updatedStudent = await Navigator.push<Student>(
        context,
        MaterialPageRoute(builder: (_) => AddStudentPage(student: _students[index],))
    );
    if (!mounted) return;
    if (updatedStudent != null) {
      _updateStudent(index, updatedStudent);
      _showSnackBar("Student Updated");
    }
  }

  void _navigateToDetails(Student student) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailsPage(student: student))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("Students"),),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: _navigateToAdd,
            child: const Icon(Icons.add),
          );
        }
      ),
      body: _students.isEmpty
          ? const Center(child: Text("No Students Yet"),)
          : ListView.builder(
        itemCount: _students.length,
        itemBuilder: (_, index) => StudentCard(
          student: _students[index],
          onEdit: () => _navigateToEdit(index),
          onDelete: () {
            _deleteStudent(index);
            _showSnackBar("Student Deleted");
          },
          onTap: () => _navigateToDetails(_students[index]),
        )
      ),
    );
  }
}
