import 'package:bankapp/database/dao/contact_dao.dart';
import 'package:bankapp/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final Contact contact;

  ContactForm({this.contact});

  @override
  _ContactFormState createState() => _ContactFormState(contact: this.contact);
}

class _ContactFormState extends State<ContactForm> {
  final Contact contact;
  final ContactDao _dao = ContactDao();

  _ContactFormState({this.contact});

  @override
  Widget build(BuildContext context) {

    final TextEditingController _nameController = TextEditingController(text: (this.contact != null) ? this.contact.name : "");
    final TextEditingController _accountNumberController = TextEditingController(text: (this.contact != null) ? this.contact.account.toString() : "");

    return Scaffold(
      appBar: AppBar(
        title: Text(this.contact != null ? "Edit contact" : "New contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                ),
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text("Add"),
                  onPressed: () {
                    final String name = _nameController.text;
                    final int accountNumber = int.tryParse(_accountNumberController.text);

                    final Contact contact = Contact(
                      (this.contact != null) ? this.contact.id : null,
                      name,
                      accountNumber,
                    );

                    if (this.contact != null) {
                      _dao.update(contact).then((id) => Navigator.pop(context));
                    } else {
                      _dao.save(contact).then((id) => Navigator.pop(context));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
