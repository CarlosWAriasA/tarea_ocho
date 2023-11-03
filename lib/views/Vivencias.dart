import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tarea_ocho/views/VivenciaDetalle.dart';

import '../util/sql.helper.dart';

class VivenciasList extends StatefulWidget {
  @override
  _VivenciasListState createState() => _VivenciasListState();
}

class _VivenciasListState extends State<VivenciasList> {
  late Future<List<Map<String, dynamic>>> _vivencias;

  @override
  void initState() {
    super.initState();
    _vivencias = SQLHelper.getVivencias();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refreshVivencias() {
    setState(() {
      _vivencias = SQLHelper.getVivencias();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _vivencias,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay vivencias registradas.'));
        } else {
          final vivencias = snapshot.data!;
          return ListView.builder(
            itemCount: vivencias.length,
            itemBuilder: (context, index) {
              final vivencia = vivencias[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VivenciaDetalle(
                            title: vivencia['title'],
                            description: vivencia['descripcion'],
                            fecha: vivencia['fecha'],
                            photoPath: vivencia['photo'],
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(vivencia['title'], style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(vivencia['descripcion']),
                    ),
                  ),
                  Divider(), // Agrega un Divider entre los elementos
                ],
              );
            },
          );
        }
      },
    );
  }
}