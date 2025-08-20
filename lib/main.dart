import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

bool isAuthenticated = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotas com Autenticação',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => LoginScreen());
        }

        if (settings.name == '/home') {
          if (isAuthenticated) {
            return MaterialPageRoute(builder: (_) => HomeScreen());
          } else {
            return MaterialPageRoute(
                builder: (_) => NotAuthorizedScreen(routeName: '/home'));
          }
        }

        if (settings.name == '/detalhes') {
          if (isAuthenticated) {
            final Map<String, dynamic> args =
                settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
                builder: (_) => DetalhesScreen(dados: args));
          } else {
            return MaterialPageRoute(
                builder: (_) => NotAuthorizedScreen(routeName: '/detalhes'));
          }
        }

        return MaterialPageRoute(builder: (_) => Scaffold(
              body: Center(child: Text("Rota não encontrada")),
            ));
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: ElevatedButton(
          child: Text("Fazer Login"),
          onPressed: () {
            isAuthenticated = true;
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuario = {
      "nome": "Caio Geraldo",
      "nascimento": "19/08/2004",
      "telefone": "(11) 99999-9999"
    };

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bem-vindo à Home!"),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Ver Detalhes"),
              onPressed: () {
                Navigator.pushNamed(context, '/detalhes', arguments: usuario);
              },
            )
          ],
        ),
      ),
    );
  }
}

class DetalhesScreen extends StatelessWidget {
  final Map<String, dynamic> dados;

  DetalhesScreen({required this.dados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes do Usuário")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome: ${dados['nome']}"),
            Text("Nascimento: ${dados['nascimento']}"),
            Text("Telefone: ${dados['telefone']}"),
          ],
        ),
      ),
    );
  }
}

class NotAuthorizedScreen extends StatelessWidget {
  final String routeName;

  NotAuthorizedScreen({required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Acesso Negado")),
      body: Center(
        child: Text("Você precisa estar logado para acessar $routeName"),
      ),
    );
  }
}