import 'package:flutter/material.dart';
import 'sqld.dart';

class Info extends StatefulWidget {
  const Info({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.number,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String number;

  static const String route = '/info';

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final Sqldb sqldb = Sqldb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Contact Info",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              widget.imageUrl,
              width: double.infinity,
              height: 370,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.number,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20.0),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {

                    await sqldb.insertData(
                      'INSERT INTO contact (name, number, image) VALUES (?, ?, ?)',
                      [widget.name, widget.number, widget.imageUrl],
                    );
                    Navigator.of(context).pop({
                      'name': widget.name,
                      'number': widget.number,
                      'image': widget.imageUrl,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 140.0),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 140.0),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
