import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:expenses/Models/transaction.dart';
import 'components/tranaction_list.dart';
import 'components/transaction_form.dart';
import 'Models/transaction.dart';
import 'components/chart.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.blueGrey[900],
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        // ======== Theme AppBar ======
        appBarTheme: AppBarTheme(
          // Mudando o titulo do AppBar
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
      ), // Definindo o tema da aplicação - Cores e fontes
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Onde recebemos a lista
  final List<Transaction> _transactions = [];

  bool _showChart = false;

// Filtrando para mostrar os últimos 7 dias (transações recete)
  List<Transaction> get _recentTransaction {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(
      String titleAdd, double valueAdd, DateTime dateAdd, String brokerAdd) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: titleAdd,
      value: valueAdd,
      date: dateAdd,
      broker: brokerAdd,
    );

    // Altera a nova transação
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transacao) => transacao.id == id);
    });
  }

  _openTransactionForModal(BuildContext contextF) {
    showModalBottomSheet(
      context: contextF,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool islandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final ichartList =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = <Widget>[
      if (islandscape)
        _getIconButton(
          _showChart ? iconList : ichartList,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.account_balance_wallet,
        () => _openTransactionForModal(context),
      ),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Carteira de Investimento'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              "Carteira de Investimento",
            ),
            actions: actions,
          );

    // pegar o tamanho Vertical
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final boryPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /*if (islandscape)
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("Exibir Gráfico"),
                  Switch(
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      }),
                ],
              ), */
            if (_showChart || !islandscape)
              Container(
                height: availableHeight * (islandscape ? 0.7 : 0.25),
                child: Chart(_recentTransaction),
              ),
            if (!_showChart || !islandscape)
              Container(
                height: availableHeight * (islandscape ? 1 : 0.7),
                child: TransactionList(_transactions, _removeTransaction),
              ), // formulário
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: boryPage,
          )
        : Scaffold(
            appBar: appBar,
            body: boryPage,
            floatingActionButton: Platform
                    .isIOS // Escondendo o FloatingActionButton quando foi IOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionForModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
