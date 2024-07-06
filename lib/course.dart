import 'package:flutter/material.dart';

class CourseManagementPage extends StatefulWidget {
  const CourseManagementPage({super.key});

  @override
  _CourseManagementPageState createState() => _CourseManagementPageState();
}

class _CourseManagementPageState extends State<CourseManagementPage> {
  
  List<Widget> courseTiles = [];
  final TextEditingController _courseNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Add the AddCourseTile initially
    courseTiles.add(AddCourseTile(onAddCourse: _promptCourseName));
  }

  void _promptCourseName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('請輸入課程名稱'),
          content: TextField(
            controller: _courseNameController,
            decoration: InputDecoration(hintText: 'Course Name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addCourseTile(_courseNameController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void _addCourseTile(String courseName) {
    setState(() {
      courseTiles.insert(courseTiles.length - 1, CourseTile(title: courseName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 61, 61, 61),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns
                  crossAxisSpacing: 75, // Horizontal spacing between items
                  mainAxisSpacing: 75, // Vertical spacing between items
                ),
                itemCount: courseTiles.length,
                itemBuilder: (context, index) {
                  return courseTiles[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}

class CourseTile extends StatelessWidget {
  final String title;
  final String? imageUrl;

  CourseTile({required this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Color.fromARGB(255, 48, 48, 48),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageUrl != null)
                Image.asset(imageUrl!)
              else
                Icon(
                  Icons.book_outlined,
                  size: 100,
                  color: Colors.white, // Change 'Colors.red' to your desired color
                ),

              SizedBox(height: 4),

              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white), // Change 'Colors.red' to your desired color
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white, // Change 'Colors.red' to your desired color
                    ),
                    onSelected: (String newValue) {
                      // Handle the selection of an item
                      // You can add your logic here
                      print('Selected: $newValue');
                    },
                    itemBuilder: (BuildContext context) {
                      return <String>['編輯名稱', '刪除課程'].map<PopupMenuItem<String>>((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddCourseTile extends StatelessWidget {

final VoidCallback onAddCourse;

const AddCourseTile({required this.onAddCourse});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAddCourse,
      child: Card(
        color: Color.fromARGB(255, 48, 48, 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 100,
              color: Colors.white, // Change 'Colors.red' to your desired color
            ),
            SizedBox(height: 8),
            Text(
                    "新增課程",
                    style: TextStyle(color: Colors.white), // Change 'Colors.red' to your desired color
                  ),
          ],
        ),
      ),
    );
  }
}