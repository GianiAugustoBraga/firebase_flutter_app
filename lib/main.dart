import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter_app/firebase_options.dart';
import 'package:firebase_flutter_app/pages/home_page.dart';
import 'package:flutter/material.dart';

// Função principal que inicializa o Firebase e executa o aplicativo
void main() async {
  // Garante que os Widgets do Flutter estão inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as opções padrão da plataforma atual
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Executa o aplicativo
  runApp(const MyApp());
}

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título do aplicativo
      title: 'Flutter Firebase',

      // remover o banner de debug
      debugShowCheckedModeBanner: false,

      // Tema do aplicativo
      theme: ThemeData(
        // Esquema de cores personalizado
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        // Usa o design do Material 3
        useMaterial3: true,
      ),

      // Carrega a Página inicial do aplicativo
      home: const HomePage(),
    );
  }
}
