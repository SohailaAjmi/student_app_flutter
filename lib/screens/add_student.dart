import 'package:flutter/material.dart';
import 'package:student_app/models/student.dart';

class AddStudentPage extends StatefulWidget {
  final Student? student;
  const AddStudentPage({super.key, this.student});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool get isEditing => widget.student != null;

  @override
  void initState() {
    super.initState();

    if (isEditing){
      nameController.text = widget.student!.name;
      ageController.text = widget.student!.age.toString();
      cityController.text = widget.student!.city;
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    ageController.dispose();
    cityController.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        name: nameController.text,
        age: int.parse(ageController.text),
        city: cityController.text,
      );
      Navigator.pop(context, student);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Student" : "Add Student")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (v) => v!.isEmpty ? "Enter name" : null,
              ),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Age"),
                validator: (v) => int.tryParse(v!) == null ? "Enter valid age" : null,
              ),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(labelText: "City"),
                validator: (v) => v!.isEmpty ? "Enter City" : null,
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? "Update" : "Add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
