import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Taller Flutter',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}

/// -------------------------
/// RUTAS CON go_router
/// -------------------------
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),
    GoRoute(
      path: '/detalle/:parametro/:metodo',
      builder: (context, state) {
        final parametro = state.pathParameters['parametro']!;
        final metodo = state.pathParameters['metodo']!;
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    GoRoute(
      path: '/widgets',
      builder: (context, state) => const WidgetsScreen(),
    ),
  ],
);

/// -------------------------
/// HOME
/// -------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Bienvenido al Taller de Flutter 🚀"),
            ElevatedButton(
              onPressed: () => context.go('/paso_parametros'),
              child: const Text("Paso de Parámetros"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/ciclo_vida'),
              child: const Text("Ciclo de Vida"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/widgets'),
              child: const Text("Widgets"),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------------------------
/// PASO DE PARÁMETROS
/// -------------------------
class PasoParametrosScreen extends StatefulWidget {
  const PasoParametrosScreen({super.key});

  @override
  State<PasoParametrosScreen> createState() => _PasoParametrosScreenState();
}

class _PasoParametrosScreenState extends State<PasoParametrosScreen> {
  final TextEditingController controller = TextEditingController();

  void goToDetalle(String metodo) {
    String valor = controller.text;
    if (valor.isEmpty) return;

    // Imprime en consola qué método se usó
    print("🔹 Navegación con: $metodo, valor: $valor");

    switch (metodo) {
      case 'go':
        context.go('/detalle/$valor/$metodo');
        break;
      case 'push':
        context.push('/detalle/$valor/$metodo');
        break;
      case 'replace':
        context.replace('/detalle/$valor/$metodo');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paso de Parámetros")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingrese un valor',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => goToDetalle('go'),
              child: const Text('Ir con Go'),
            ),
            ElevatedButton(
              onPressed: () => goToDetalle('push'),
              child: const Text('Ir con Push'),
            ),
            ElevatedButton(
              onPressed: () => goToDetalle('replace'),
              child: const Text('Ir con Replace'),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------------------------
/// DETALLE
/// -------------------------
class DetalleScreen extends StatelessWidget {
  final String parametro;
  final String metodoNavegacion;

  const DetalleScreen({
    super.key,
    required this.parametro,
    required this.metodoNavegacion,
  });

  void _volver(BuildContext context) {
    if (metodoNavegacion == 'push') {
      context.pop(); // Con push sí se puede volver
    } else {
      context.go('/paso_parametros'); // Con go y replace hay que redirigir
    }
  }

  @override
  Widget build(BuildContext context) {
    // Imprime cuando llega a esta pantalla
    print("📌 Llegó a DetalleScreen con parámetro: $parametro y método: $metodoNavegacion");

    return Scaffold(
      appBar: AppBar(title: const Text("Detalle")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Parámetro recibido: $parametro"),
            Text("Método: $metodoNavegacion"),
            ElevatedButton(
              onPressed: () => _volver(context),
              child: const Text("Volver"),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------------------------
/// CICLO DE VIDA
/// -------------------------
class CicloVidaScreen extends StatefulWidget {
  const CicloVidaScreen({super.key});

  @override
  State<CicloVidaScreen> createState() => _CicloVidaScreenState();
}

class _CicloVidaScreenState extends State<CicloVidaScreen> {
  String texto = "Texto inicial 🟢";

  @override
  void initState() {
    super.initState();
    print("🟢 initState() → se ejecuta al crear la pantalla");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("🟡 didChangeDependencies() → cuando cambian dependencias");
  }

  @override
  Widget build(BuildContext context) {
    print("🔵 build() → construyendo la pantalla");
    return Scaffold(
      appBar: AppBar(title: const Text("Ciclo de Vida")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(texto),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  texto = "Texto actualizado 🟠";
                  print("🟠 setState() → estado actualizado");
                });
              },
              child: const Text("Actualizar Texto"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("🔴 dispose() → cuando la pantalla se destruye");
    super.dispose();
  }
}

/// -------------------------
/// WIDGETS DEMO (GridView + TabBar + FAB)
/// -------------------------
class WidgetsScreen extends StatefulWidget {
  const WidgetsScreen({super.key});

  @override
  State<WidgetsScreen> createState() => _WidgetsScreenState();
}

class _WidgetsScreenState extends State<WidgetsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Widgets"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Grid"),
            Tab(text: "Lista"),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: 6,
                  itemBuilder: (context, index) => Card(
                    child: Center(child: Text("Item ${index + 1}")),
                  ),
                ),
                ListView(
                  children: const [
                    ListTile(title: Text("Elemento A")),
                    ListTile(title: Text("Elemento B")),
                  ],
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(12),  // margen externo
            elevation: 4,                       // sombra para resaltar el card
            child: ListTile(                    // contenido del card
              leading: const Icon(
                Icons.info,
                color: Colors.blue,
              ),                                // icono al inicio
              title: const Text("Card como tercer widget"),
              subtitle: const Text("Muestra información destacada"),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("⚡ FAB presionado en WidgetsScreen");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
