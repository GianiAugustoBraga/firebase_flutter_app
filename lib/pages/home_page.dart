import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Inicializa a instância do Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Variável para armazenar o usuário autenticado
  User? _user;

  @override
  void initState() {
    super.initState();

    // Escuta as mudanças no estado de autenticação
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google SignIn"),
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }

  // Widget para exibir o botão de login do Google
  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign Up with Google",
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }

  // Widget para exibir as informações do usuário
  Widget _userInfo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Exibe a foto do perfil do usuário
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_user!.photoURL!),
              ),
            ),
          ),

          // Exibe o e-mail do usuário
          Text(_user!.email!),

          // Exibe o nome do usuário, se disponível
          Text(_user!.displayName ?? ""),

          // Botão para fazer logout
          MaterialButton(
            color: Colors.red,
            child: const Text("Sign Out"),
            onPressed: () {
              _auth.signOut();
            },
          ),
        ],
      ),
    );
  }

  // Função para lidar com o login com o Google
  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }
}
