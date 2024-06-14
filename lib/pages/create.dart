import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPatrimonioPage extends StatefulWidget {
  @override
  _AddPatrimonioPageState createState() => _AddPatrimonioPageState();
}

class _AddPatrimonioPageState extends State<AddPatrimonioPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPatrimonio;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Patrimônio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('patrimonios')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final patrimonios = snapshot.data!.docs;
                  return DropdownButtonFormField<String>(
                    hint: Text('Selecione um patrimônio'),
                    items: patrimonios.map((patrimonio) {
                      return DropdownMenuItem<String>(
                        value: patrimonio.id,
                        child: Text(patrimonio['cod_patrimonio']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPatrimonio = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Selecione um patrimônio' : null,
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final user = _auth.currentUser;
                        FirebaseFirestore.instance
                            .collection('retiradas')
                            .doc(_selectedPatrimonio)
                            .set({
                          'userId': user!.uid,
                          'data_retirada': DateTime.now(),
                          'cod_patrimonio': _selectedPatrimonio,
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Confirmar'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
