import 'package:expenses/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adaptative_button.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime, String) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _brokerController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  /* // Banco de Dados
  DatabaseHelper db = DatabaseHelper();
  List<Transaction> transactionDb = List<Transaction>();

  @override
  void initState() {
    super.initState();
    Transaction t1 = Transaction(
        id: "1",
        title: "BTC",
        broker: "Binance",
        value: 5.0,
        date: _selectedDate);

    db.insertTransaction(t1);

    db.getTransactionList().then((lista){
      print(lista);
    });

  } */

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final broker = _brokerController.text;
    // Validando se o Titulo possui algum valor
    if (title.isEmpty ||
        value <= 0 ||
        broker.isEmpty ||
        _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate, broker);
  }

  _showDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      // Alterar status
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                labelTitulo: 'Título do Investimento',
                onSubmitted: (_) => _submitForm(),
                titleController: _titleController,
                labelValue: 'Valor (R\$)',
                valueController: _valueController,
                labelBroker: 'Corretora',
                brokerController: _brokerController,
              ),

              // TextField(
              // controller:  _titleController, // Pegando o valor digitado
              //onSubmitted: (_) =>
              // _submitForm(), // Gravar atravez da opção do teclado
              //decoration: InputDecoration(
              // labelText: 'Título do Investimento',
              // ),
              // ),
              /*  TextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              TextField(
                controller: _brokerController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Corretora',
                ),
              ), */
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                      ),
                    ),
                    FlatButton(
                      color: Colors.blueGrey[50],
                      textColor: Colors.orangeAccent[400],
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _showDataPicker,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Salvar Transação',
                    onPressed: _submitForm,
                  ),
                  /* RaisedButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Salvar Transação'),
                    onPressed: _submitForm,
                  ), */
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
