import 'package:flutter/material.dart';

class Student {
  Student({
    required this.id,
    required this.name,
    required this.surname,
    required this.gpd,
  });

  final int id;
  final String name;
  final String surname;
  final double gpd;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Student',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'New Student'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController gpdController = TextEditingController();
  List<Student> students = [];

  void _addStudent() {
    final id = int.tryParse(idController.text) ?? 0;
    final name = nameController.text;
    final surname = surnameController.text;
    final gpd = double.tryParse(gpdController.text) ?? 0;

    if (id > 0 && name.isNotEmpty && surname.isNotEmpty && gpd > 0) {
      final newStudent = Student(id: id, name: name, surname: surname, gpd: gpd);
      setState(() {
        students.add(newStudent);
      });

      // Clear the input fields
      idController.clear();
      nameController.clear();
      surnameController.clear();
      gpdController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: surnameController,
              decoration: const InputDecoration(labelText: 'Surname'),
            ),
            TextField(
              controller: gpdController,
              decoration: const InputDecoration(labelText: 'GPD'),
            ),
            ElevatedButton(
              onPressed: _addStudent,
              child: Text("Add Student"),
            ),
            SizedBox(height: 16), // Add some spacing
            Text("", style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID: ${student.id}"),
                          Text("GPD: ${student.gpd.toStringAsFixed(2)}"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${student.name}"),
                          Text("Surname: ${student.surname}"),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
