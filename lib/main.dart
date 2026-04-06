import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Student {
  String name;
  int age;
  String city;

  Student(this.name, this.age, this.city);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Student> students = [
    Student("Sohaila", 25, "Cairo"),
    Student("Mahmoud", 22, "Cairo"),
    Student("Lama", 20, "Cairo"),
  ];

  void addStudent(Student s) {
    setState(() {
      students.add(s);
    });
  }

  void updateStudent(int index, Student s) {
    setState(() {
      students[index] = s;
    });
  }

  void deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Manager App",
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text("Students"),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () async {
                final newStudent = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddStudentPage()),
                );

                if (newStudent != null) {
                  addStudent(newStudent);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Student Added")),
                  );
                }
              },
              child: const Icon(Icons.add),
            );
          },
        ),
        body: students.isEmpty
            ? const Center(child: Text("No Students Yet"))
            : ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            Student s = students[index];

            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 8,
                      offset: Offset(0, 3))
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.person,
                      size: 60, color: Colors.blue),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsPage(student: s),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Age: ${s.age}"),
                          Text("City: ${s.city}"),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit,
                            color: Colors.blue),
                        onPressed: () async {
                          final updatedStudent =
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddStudentPage(student: s),
                            ),
                          );

                          if (updatedStudent != null) {
                            updateStudent(index, updatedStudent);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                  content:
                                  Text("Student Updated")),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.red),
                        onPressed: () {
                          deleteStudent(index);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                                content:
                                Text("Student Deleted")),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Student student;

  const DetailsPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(student.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 120),
            const SizedBox(height: 20),
            Text(student.name,
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Age: ${student.age}"),
            Text("City: ${student.city}"),
          ],
        ),
      ),
    );
  }
}

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

  @override
  void initState() {
    super.initState();

    if (widget.student != null) {
      nameController.text = widget.student!.name;
      ageController.text = widget.student!.age.toString();
      cityController.text = widget.student!.city;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: Text(widget.student == null ? "Add" : "Edit")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration:
                const InputDecoration(labelText: "Name"),
                validator: (value) =>
                value!.isEmpty ? "Enter name" : null,
              ),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration:
                const InputDecoration(labelText: "Age"),
                validator: (value) =>
                int.tryParse(value!) == null
                    ? "Enter valid age"
                    : null,
              ),
              TextFormField(
                controller: cityController,
                decoration:
                const InputDecoration(labelText: "City"),
                validator: (value) =>
                value!.isEmpty ? "Enter city" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final student = Student(
                      nameController.text,
                      int.parse(ageController.text),
                      cityController.text,
                    );

                    Navigator.pop(context, student);
                  }
                },
                child:
                Text(widget.student == null ? "Add" : "Update"),
              )
            ],
          ),
        ),
      ),
    );
  }
}