import 'package:expenses/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';
import 'adaptative_date_picker.dart';
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
              AdaptativeDatePicker(
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
                selectedDate: _selectedDate,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Salvar Transação',
                    onPressed: _submitForm,
                  ),
                  /*RaisedButton(
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
