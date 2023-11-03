import 'package:flutter/material.dart';
import 'package:tarea_ocho/util/sql.helper.dart';
import 'package:tarea_ocho/views/Vivencias.dart';
import 'package:tarea_ocho/views/about.dart';
import 'package:tarea_ocho/views/addVivencia.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade700),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Vivencias'),
      debugShowCheckedModeBanner: false,
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
  final VivenciasList vivenciasList = VivenciasList();
  bool showVivencias = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.info_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => About()));
                },
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Eliminar vivencias'),
                          content: const Text('¿Estás seguro de que deseas eliminar todas las vivencias?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Eliminar'),
                              onPressed: () async {
                                await SQLHelper.deleteAllVivencias();
                                setState(() {
                                  showVivencias = false;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AddVivencia()));
                  },
                  icon: const Icon(
                    Icons.add_box_rounded,
                    color: Colors.black,
                  )),
            ]),
        body: showVivencias ? vivenciasList : const Center(child: Text('No hay vivencias registradas'))
    );
  }
}
