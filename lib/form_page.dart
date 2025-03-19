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
}
