import 'package:flutter/material.dart';
import 'file.dart';

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

  void _updateCourseTileTitle(String oldTitle, String newTitle) {
    setState(() {
      for (var tile in courseTiles) {
        if (tile is CourseTile && tile.title == oldTitle) {
          tile.title = newTitle;
          break;
        }
      }
    });
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
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('加入'),
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
      courseTiles.insert(
        courseTiles.length - 1,
        CourseTile(
          title: courseName,
          courseManager: this,
        ),
      );
    });
  }

  void _deleteCourseTile(String courseName) {
    setState(() {
      courseTiles.remove(
        courseTiles.firstWhere(
          (element) => element is CourseTile && element.title == courseName,
        ),
      );
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

class CourseTile extends StatefulWidget {
  String title;
  final String? imageUrl;
  final _CourseManagementPageState courseManager;

  CourseTile({required this.title, this.imageUrl, required this.courseManager});

  @override
  _CourseTileState createState() => _CourseTileState();

}

class _CourseTileState extends State<CourseTile> {
  late String _title;

  @override
  void initState() {
    super.initState();
    try {
      _title = widget.title;
      print('Title initialized: $_title');
    } catch (e) {
      print('Error in initState: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    try{
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FilePage(courseName: _title)),
        );
      },
      child: Card(
        color: Color.fromARGB(255, 48, 48, 48),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.imageUrl != null)
                Image.asset(widget.imageUrl!)
              else
                Icon(
                  Icons.book_outlined,
                  size: 100,
                  color: Colors.white,
                ),
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _title,
                    style: TextStyle(color: Colors.white),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    onSelected: (String newValue) {
                      if (newValue == '編輯名稱') {
                        _showEditDialog(context);
                      } else if (newValue == '刪除課程') {
                        widget.courseManager._deleteCourseTile(_title); 
                        print("Delete course");
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return <String>['編輯名稱', '刪除課程']
                          .map<PopupMenuItem<String>>((String value) {
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
    } catch (e) {
      print('Error in CourseTile build: $e');
      return Container();
    }
  }

  void _showEditDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: _title);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('編輯名稱'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'New title'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('保存'),
              onPressed: () {
                setState(() {
                  String newTitle = _controller.text;
                  widget.courseManager._updateCourseTileTitle(_title, newTitle);
                  _title = newTitle;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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