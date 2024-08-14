import 'package:contact/sqld.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});
  static const String route = '/contact';

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final Sqldb sqldb = Sqldb();
  List<Map> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    List<Map> data = await sqldb.readData("SELECT * FROM contact");
  }

  void _showAddContactModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController nameController = TextEditingController();
        final TextEditingController numberController = TextEditingController();
        final TextEditingController imageController = TextEditingController();

        return Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Contact Name',
                    labelStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                TextFormField(
                  controller: numberController,
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    labelStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                TextFormField(
                  controller: imageController,
                  decoration: InputDecoration(
                    labelText: 'Contact image URL',
                    labelStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final String name = nameController.text;
                    final String number = numberController.text;
                    final String imageUrl = imageController.text;

                    try {
                      await sqldb.insertData(
                        'INSERT INTO contact (name, number, image) VALUES (?, ?, ?)',
                        [name, number, imageUrl],
                      );

                      Navigator.pushNamed(context, '/info') ;

                    } catch (e) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error adding contact: $e'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'ADD',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 23,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    minimumSize: Size(390, 40),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "My Contacts",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _showAddContactModal,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            child: Column(
              children: [
                Image.network(
                  contact['image'] ?? '',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    contact['name'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  contact['number'] ?? '',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
