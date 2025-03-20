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
  
  }

  
}
