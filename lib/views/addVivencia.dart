import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarea_ocho/main.dart';
import '../util/sql.helper.dart';

class AddVivencia extends StatefulWidget {
  @override
  State<AddVivencia> createState() => _AddVivenciaState();
}

class _AddVivenciaState extends State<AddVivencia> {
  DateTime? selectedDate;
  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  ImagePicker picker = ImagePicker();
  File? selectedImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _saveVivencia() async {
    final int id = await SQLHelper.createVivencia(
        tituloController.text,
        selectedDate ??   DateTime.now(),
        descripcionController.text,
        selectedImage?.path ?? "");

    tituloController.clear();
    descripcionController.clear();
    setState(() {
      selectedImage = null;
      selectedDate = null;
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nueva Vivencia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 0, left: 12, right: 12, top: 12),
            child: TextField(
              controller: tituloController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid)),
                hintText: 'Titulo',
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 0, left: 12, right: 12, top: 12),
            child: TextFormField(
              readOnly: true,
              // Hace que el campo sea solo de lectura
              onTap: () {
                _selectDate(context);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                hintText: 'Seleccionar fecha',
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  size: 30,
                  color: Colors.green,
                ),
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              controller: TextEditingController(
                text: selectedDate != null
                    ? "${selectedDate?.toLocal()}".split(' ')[0]
                    : "",
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 0, left: 12, right: 12, top: 12),
            child: TextField(
              controller: descripcionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                hintText: 'Descripción',
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              minLines: 4,
              maxLines: 10,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 0, left: 12, right: 12, top: 12),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Elegir fuente de imagen"),
                          actions: [
                            TextButton(
                              child: const Text("Cámara"),
                              onPressed: () {
                                _pickImage(ImageSource.camera);
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text("Galería"),
                              onPressed: () {
                                _pickImage(ImageSource.gallery);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: selectedImage != null
                      ? Image.file(selectedImage ?? File(""),
                          width: 100, height: 100)
                      : const Icon(
                          Icons.camera_alt,
                          size: 100,
                          color: Colors.grey,
                        ),
                ),
                FilledButton.tonal(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(5)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    _saveVivencia();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Guardar vivencia',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
