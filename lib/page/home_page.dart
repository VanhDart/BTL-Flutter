import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_5/page/login_page.dart';
import 'package:flutter_application_5/page/setting_page.dart';
import 'package:flutter_application_5/services/alert_service.dart';
// import 'package:flutter_application_5/services/auth_services.dart';
import 'package:flutter_application_5/wedgets/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _page = [
    HomeContent(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          )
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final TextEditingController _nameItemController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final CollectionReference _items = FirebaseFirestore.instance.collection("items");

  HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                _formAddItem(context);
              },
              icon: const Icon(Icons.add_box))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder(
            stream: _items.snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return const CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  var item = snapshot.data!.docs[index];
                  return Card(
                    key: Key(item.id),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        item['nameItem'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        item['content'],
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: (){
                              _editItem(item, context);
                            },
                            icon: const Icon(Icons.edit) ,
                          ),
                          IconButton(
                            onPressed: (){
                               AlertService().showToast(
                                context: context, 
                                text: "Delete ${item['nameItem']} successfully", 
                                icon: Icons.check,
                              );
                              _deleteItem(item.id);
                            },
                            icon: const Icon(Icons.delete) ,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
  }

  void _deleteItem(String itemID){
    _items.doc(itemID).delete();
  }

 void _editItem(DocumentSnapshot item , BuildContext context){
  _nameItemController.text = item['nameItem'];
  _contentController.text = item['content'];

   showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            color: Colors.white,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldLog(
                    textEditingController: _nameItemController,
                    hintText: "Name Item",
                    icon: Icons.person,
                  ),
                  TextFieldLog(
                    textEditingController: _contentController,
                    hintText: "Context",
                    icon: Icons.email,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          AlertService().showToast(
                            context: context, 
                            text: "Update ${item['nameItem']} successfully", 
                            icon: Icons.check
                          );
                          _updateItem(item.id);
                          Navigator.pop(context);
                        },
                        child: const Text('Update')
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('cancle')
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
 }

  void _updateItem(String itemID){
    _items.doc(itemID).update({
      'nameItem': _nameItemController.text,
      'content': _contentController.text, 
    });
    _nameItemController.clear();
    _contentController.clear();
  }

  void _formAddItem(BuildContext context) {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            color: Colors.white,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldLog(
                    textEditingController: _nameItemController,
                    hintText: "Name Item",
                    icon: Icons.person,
                  ),
                  TextFieldLog(
                    textEditingController: _contentController,
                    hintText: "Context",
                    icon: Icons.email,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          AlertService().showToast(
                            context: context, 
                            text: "Add item new successfully", 
                            icon: Icons.check
                          );
                          _addItem();
                          Navigator.pop(context);
                        },
                        child: const Text('Add')
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('cancle')
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
  void _addItem() {
    _items.add({
      'nameItem': _nameItemController.text,
      'content': _contentController.text,
    });
    _nameItemController.clear();
    _contentController.clear();
  }
}
