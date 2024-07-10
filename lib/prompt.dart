import 'package:flutter/material.dart';

const Color backgroundColor = Color.fromARGB(255, 61, 61, 61);

class PromptManagementPage extends StatefulWidget {
  @override
  _PromptManagementPageState createState() => _PromptManagementPageState();
}

class _PromptManagementPageState extends State<PromptManagementPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _items = [
    {'title': 'Item 1', 'description': 'Description 1', 'isStarred': false},
    {'title': 'Item 2', 'description': 'Description 2', 'isStarred': false},
    {'title': 'Item 3', 'description': 'Description 3', 'isStarred': false},
    {'title': 'Item 4', 'description': 'Description 4', 'isStarred': false},
    {'title': 'Item 5', 'description': 'Description 5', 'isStarred': false},
  ];
  List<Map<String, dynamic>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_items); // Ensure _filteredItems is a copy of _items
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      _filteredItems = _items
          .where((item) => item['title']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _toggleStar(int index) {
    setState(() {
      _filteredItems[index]['isStarred'] = !_filteredItems[index]['isStarred'];
      if (_filteredItems[index]['isStarred']) {
        var item = _filteredItems.removeAt(index);
        _filteredItems.insert(0, item);
      } else {
        var item = _filteredItems.removeAt(index);
        _filteredItems.add(item);
      }
    });
  }

  void _editItem(int index) {
    TextEditingController titleController = TextEditingController(text: _filteredItems[index]['title']);
    TextEditingController descriptionController = TextEditingController(text: _filteredItems[index]['description']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _filteredItems[index]['title'] = titleController.text;
                  _filteredItems[index]['description'] = descriptionController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 100.0, top: 100.0, right: 100.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.white54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _filteredItems[index]['title'],
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    subtitle: Text(
                      _filteredItems[index]['description'],
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            _filteredItems[index]['isStarred']
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.white54,
                          ),
                          onPressed: () => _toggleStar(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white54),
                          onPressed: () => _editItem(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.white54),
                          onPressed: () {
                            // Handle delete action
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}