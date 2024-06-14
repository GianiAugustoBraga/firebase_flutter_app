import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatrimonyPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('Patrimônios Retirados')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('patrimonios')
            .where('userId', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final patrimonios = snapshot.data!.docs;
          return ListView.builder(
            itemCount: patrimonios.length,
            itemBuilder: (context, index) {
              final patrimonio = patrimonios[index];
              return ListTile(
                title: Text(patrimonio['nome']),
                subtitle: Text(
                    'Código: ${patrimonio['cod_patrimonio']} - Data: ${patrimonio['data_retirada']}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addPatrimonio'),
        child: Icon(Icons.add),
      ),
    );
  }
}
