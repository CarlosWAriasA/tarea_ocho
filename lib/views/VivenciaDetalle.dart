import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VivenciaDetalle extends StatelessWidget {
  final String title;
  final String description;
  final String fecha;
  final String? photoPath; // Nullable for the photo

  const VivenciaDetalle({super.key,
    required this.title,
    required this.description,
    required this.fecha,
    this.photoPath,
  });

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(fecha);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.green,
        child: ListView(
          children: [
            if (photoPath != null)
              Image.file(File(photoPath!), height: 300),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Titulo: $title',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Fecha: ${parsedDate.day.toString().padLeft(2, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Descripción:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(description, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
