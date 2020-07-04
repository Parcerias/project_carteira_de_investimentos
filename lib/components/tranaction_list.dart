import 'package:expenses/Models/transaction.dart';
import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart'; // Pacote adiquirido

class TransactionList extends StatelessWidget {
  final List<Transaction> tranaction;
  final void Function(String) onRemove;

  TransactionList(this.tranaction, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return tranaction.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ), // Definir Espaçamento
                  Text(
                    'Nenhum investimento cadastrado.',
                    //style: Theme.of(context).textTheme.title,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.4,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover, // Definir a area da img
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: tranaction
                .length, // Saber a quantidade idem que vai ter na Lista
            itemBuilder: (ctx, index) {
              final tr = tranaction[
                  index]; // será renderizado conforme for sendo chamado no scroll ( Todos os elementos que estiver fora da tela não será renderizados)
              return Card(
                color: Colors.blueGrey[50],
                elevation: 3,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          'R\$${tr.value}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    '${tr.title} (${tr.broker})',
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat('d/MMM/y').format(tr.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? FlatButton.icon(
                          onPressed: () => onRemove(tr.id),
                          icon: Icon(Icons.delete),
                          label: Text('Excluir'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => onRemove(tr.id),
                        ),
                ),
              );
            },
          );
  }
}
