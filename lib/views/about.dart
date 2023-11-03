import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.green.shade300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
              'assets/my-image.jpg',
              height: 400,
            ))),
            const Text('Carlos Arias', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),),
            const Text('2022-0021', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
            const Text('"En la guerra, la verdad es la primera víctima."', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
