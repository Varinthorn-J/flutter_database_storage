import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/database/transaction_db.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'EditForm.dart';

// import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List users = [];
  loadusers() async {
    // final List<Transactions> res = await TransactionDB().loadAllData();
    // final res = await TransactionDB().loadAllData();
    // print(res);
    // setState(() {
    //   users = res;
    // });
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  void initState() {
    // TODO: implement initState
    loadusers();
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("data"),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  SystemNavigator.pop();
                })
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget child) {
            var count = provider.transactions.length; //นับจำนวนข้อมูล
            if (count <= 0) {
              return Center(
                child: Text(
                  "no data",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      elevation: 8,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditForm(
                                                  title: data.title,
                                                  lastname: data.lastname,
                                                  address: data.address,
                                                  password: data.password,
                                                )))
                                  },
                              child: Text('Edit')),
                          ElevatedButton(
                              onPressed: () {
                                provider
                                    .removeTransaction(
                                        Transactions(email: data.email))
                                    .whenComplete(() {
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .initData();
                                });
                              },
                              child: Text('delete')),
                          ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.purple[50],
                                radius: 60,
                                // child: FittedBox(
                                //   child: Text(data.amount.toInt().toString()),
                                // ),
                              ),
                              title: Text(
                                  "${data.title} ${data.lastname}\n ${data.address}\n ${data.amount.toInt().toString()}\n ${data.email}\n ${data.password}")),
                        ],
                      ),
                    );
                  });
            }
          },
        ));
  }
}
