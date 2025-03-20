import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController taskController = TextEditingController();
  final key = GlobalKey<FormState>();
  List<String> daftarTask = [];
  List<bool> isCheckedList = [];
  List<DateTime?> deadlines = [];
  String? dateError;
  DateTime? selectedDate;

  // Fungsi Format Waktu (HH:mm)
  String formatTime(int hour, int minute) {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  // Fungsi Pilih Tanggal dan Waktu
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          dateError = null; // Hapus error jika berhasil memilih tanggal
        });
      }
    }
  }

  void addTask() {
    if (taskController.text.isEmpty || selectedDate == null) {
      setState(() {
        dateError = selectedDate == null ? "Please select a date" : null;
      });
      return;
    }
    setState(() {
      daftarTask.add(taskController.text);
      isCheckedList.add(false);
      deadlines.add(selectedDate);
      selectedDate = null;
      taskController.clear();
      dateError = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Task successfully added!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Form Page',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              setState(() {
                daftarTask.clear();
                isCheckedList.clear();
                deadlines.clear();
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             Form(
              key: key,
              child: Column(
                 // Tanggal dan Waktu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Task Date :',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                            selectedDate != null
                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} ${formatTime(selectedDate!.hour, selectedDate!.minute)}'
                                : 'No date selected',
                            style: TextStyle(
                              color: selectedDate == null
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                          if (dateError != null)
                            Text(
                              dateError!,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 12),
                            ),
                        ],
                      ),
                        ]
                      )]
              )
             )


          ]
        )
      )

  }
}
