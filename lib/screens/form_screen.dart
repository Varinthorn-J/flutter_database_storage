import 'package:flutter/material.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:flutter_database/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  // controller
  final titleController = TextEditingController(); //รับค่าชื่อ
  final lastnameController = TextEditingController(); //รับค่านามสกุล
  final addressController = TextEditingController(); //รับค่าที่อยู่
  final amountController = TextEditingController(); //รับตัวเลข
  final emailController = TextEditingController(); //รับเมลล์
  final passwordController = TextEditingController(); //รับรหัส
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("6135512053"),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: new InputDecoration(labelText: "Name"),
                  autofocus: false,
                  controller: titleController,
                  validator: (String str) {
                    //ชื่อรายการเป็นค่าว่าง
                    if (str.isEmpty) {
                      return "name plase";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Last name"),
                  autofocus: false,
                  controller: lastnameController,
                  validator: (String str) {
                    //ชื่อรายการเป็นค่าว่าง
                    if (str.isEmpty) {
                      return "last name plase";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Address"),
                  autofocus: false,
                  controller: addressController,
                  validator: (String str) {
                    //ชื่อรายการเป็นค่าว่าง
                    if (str.isEmpty) {
                      return "address plase";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Phone"),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "phone";
                    }
                    if (double.parse(str) <= 0) {
                      return "เบอร์โทรศัพท์";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "email"),
                  autofocus: false,
                  controller: emailController,
                  validator: (String str) {
                    //ชื่อรายการเป็นค่าว่าง
                    if (str.isEmpty) {
                      return "Email plase";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "password"),
                  autofocus: false,
                  controller: passwordController,
                  validator: (String str) {
                    //ชื่อรายการเป็นค่าว่าง
                    if (str.isEmpty) {
                      return "Password plase";
                    }
                    return null;
                  },
                ),
                FlatButton(
                  child: Text("add"),
                  color: Colors.purple,
                  textColor: Colors.white,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      var title = titleController.text;
                      var lastname = lastnameController.text;
                      var address = addressController.text;
                      //  var phone = phoneController.text;
                      var amount = amountController.text;
                      var email = emailController.text;
                      var password = passwordController.text;
                      //เตรียมข้อมูล
                      Transactions statement = Transactions(
                          title: title,
                          lastname: lastname,
                          address: address,
                          amount: double.parse(amount),
                          email: email,
                          password: password,
                          date: DateTime.now()); //object

                      //เรียก Provider
                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.addTransaction(statement);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return MyHomePage();
                              }));
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
