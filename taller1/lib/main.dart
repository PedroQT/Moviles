import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _title = "Hola, Flutter";

  void _changeTitle() {
    setState(() {
      _title = _title == "Hola, Flutter" ? "¡Título cambiado!" : "Hola, Flutter";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Título actualizado")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Pedro Quiñones – Código 123456",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThirELARItPuAkokYup7a1lneO1aRc9_2g8g&s",
                  width: 100,
                ),
                const SizedBox(width: 20),
                Image.asset(
                  "assets/logo.png", // recuerda configurar pubspec.yaml
                  width: 100,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Widget adicional: ListView en un contenedor
            Expanded(
              child: ListView(
                children: const [
                  ListTile(leading: Icon(Icons.star), title: Text("Elemento 1")),
                  ListTile(leading: Icon(Icons.star), title: Text("Elemento 2")),
                  ListTile(leading: Icon(Icons.star), title: Text("Elemento 3")),
                ],
              ),
            ),

            // Botón principal
            ElevatedButton(
              onPressed: _changeTitle,
              child: const Text("Cambiar título"),
            ),

            // Widget adicional: otro botón con icono
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.info),
              label: const Text("Botón extra"),
            ),
          ],
        ),
      ),
    );
  }
}
