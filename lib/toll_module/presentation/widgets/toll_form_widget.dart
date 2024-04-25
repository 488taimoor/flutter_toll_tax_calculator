import 'package:flutter/material.dart';
import 'package:flutter_application_1/toll_module/bussiness_logic/toll_calculation.dart';

class TollFormwidget extends StatefulWidget {
  TollFormwidget({super.key, required this.callback});

  final void Function(Map<String, double>) callback;

  @override
  State<TollFormwidget> createState() => _TollFormwidgetState();
}

class _TollFormwidgetState extends State<TollFormwidget> {
  String? selectedEntryPoint;
  String? selectedExitPoint;
  DateTime selectedDate = DateTime.now();

  TextEditingController numberPlateController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> entryPoints = TollCalculator.entryPoints.keys.toList();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String? _validateNumberPlate(String? value) {
    String pattern = r'^[A-Za-z]{3}-\d{3}$';
    RegExp regex = RegExp(pattern);
    if (value != null) {
      if (!regex.hasMatch(value)) {
        return 'Invalid number plate format (LLL-NNN)';
      }
    }
    return null;
  }

  String? _validateExitPoint(String? value) {
    if (value != null) {
      if (selectedEntryPoint == null) {
        return 'Please select entry point';
      }

      if (entryPoints.indexOf(value) <=
          entryPoints.indexOf(selectedEntryPoint!)) {
        return 'Exit point must be greater than entry point';
      }
    } else {
      return 'Please select exit point';
    }
    return null;
  }

  String? _validateEntryPoint(String? value) {
    if (value != null) {
      if (selectedExitPoint != null) {
        if (entryPoints.indexOf(value) >=
            entryPoints.indexOf(selectedExitPoint!)) {
          return 'Exit point must be greater than entry point';
        }
      }
    } else {
      return 'Please select entry point';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedEntryPoint,
              validator: _validateEntryPoint,
              items: entryPoints.map((entryPoint) {
                return DropdownMenuItem<String>(
                  value: entryPoint,
                  child: Text(entryPoint),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedEntryPoint = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Entry Point',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedExitPoint,
              validator: _validateExitPoint,
              items: entryPoints.map((exitPoint) {
                return DropdownMenuItem<String>(
                  value: exitPoint,
                  child: Text(exitPoint),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedExitPoint = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Exit Point',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: numberPlateController,
              validator: _validateNumberPlate,
              decoration: const InputDecoration(
                labelText: 'Number Plate (LLL-NNN)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Select Date',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${selectedDate.toLocal()}'.split(' ')[0]),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.callback(TollCalculator.calculateToll(
                      selectedEntryPoint!,
                      selectedExitPoint!,
                      selectedDate,
                      numberPlateController.text));
                }
              },
              child: const Text('Calculate Toll'),
            ),
          ],
        ),
      ),
    );
  }
}
