import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomNav + TabBar Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text("Página 1 - Home")),
    ModuleTwo(),
    Center(child: Text("Página 3 - Configurações")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Conteúdo"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Config"),
        ],
      ),
    );
  }
}

class ModuleTwo extends StatelessWidget {
  const ModuleTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Módulo 2"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.star), text: "Aba 1"),
              Tab(icon: Icon(Icons.favorite), text: "Aba 2"),
              Tab(icon: Icon(Icons.person), text: "Aba 3"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NestedPage(title: "Conteúdo da Aba 1"),
            NestedPage(title: "Conteúdo da Aba 2"),
            NestedPage(title: "Conteúdo da Aba 3"),
          ],
        ),
      ),
    );
  }
}

class NestedPage extends StatelessWidget {
  final String title;

  const NestedPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("$title\nIr para Detalhes"),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DetailPage(info: title),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String info;

  const DetailPage({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes")),
      body: Center(child: Text("Detalhes da: $info")),
    );
  }
}
