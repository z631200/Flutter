import 'package:flutter/material.dart';
import 'course.dart'; // Import the common components

class FilePage extends StatefulWidget {
  final String courseName;
  final List<String> files;
  final List<String> otherFiles;
  final CourseManagementPageState courseManager;

  FilePage({required this.courseName, required this.files, required this.otherFiles, required this.courseManager});

  @override
  _FilePageState createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  PageController _pageController = PageController();
  List<Widget> fileTiles = [];
  List<Widget> otherFileTiles = [];
  final TextEditingController _fileNameController = TextEditingController();
  final TextEditingController _otherFileNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fileTiles.add(AddCourseTile(onAddCourse: promptFileName, text: '新增簡報'));
    otherFileTiles.add(AddCourseTile(onAddCourse: promptOtherFileName, text: '新增補充教材'));

    for (var file in widget.files) {
      fileTiles.add(FileTile(title: file));
    }
    for (var otherfile in widget.otherFiles) {
      otherFileTiles.add(FileTile(title: otherfile));
    }
  }

  void promptFileName() {
    if (!mounted) return;
    _fileNameController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('請輸入簡報名稱'),
          content: TextField(
            controller: _fileNameController,
            decoration: InputDecoration(hintText: 'PPT Name'),
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
                addFileTile(_fileNameController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void promptOtherFileName() {
    if (!mounted) return;
    _otherFileNameController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('請輸入補充教材名稱'),
          content: TextField(
            controller: _otherFileNameController,
            decoration: InputDecoration(hintText: 'Supplementary Material Name'),
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
                addOtherFileTile(_otherFileNameController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void addFileTile(String fileName) {
    setState(() {
      fileTiles.insert(
        fileTiles.length - 1,
        FileTile(title: fileName),
      );
      widget.courseManager.addFileToCourse(widget.courseName, fileName);
    });
  }

  void addOtherFileTile(String fileName) {
    setState(() {
      otherFileTiles.insert(
        otherFileTiles.length - 1,
        FileTile(title: fileName),
      );
      // Assuming you have a method to add supplementary files to the course
      widget.courseManager.addOtherFileToCourse(widget.courseName, fileName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 48, 48, 48), // Set button color to black
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    '課程簡報',
                    style: TextStyle(color: Colors.white), // Set text color to white
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 48, 48, 48), // Set button color to black
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    '補充教材',
                    style: TextStyle(color: Colors.white), // Set text color to white
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white), // Set icon color to white
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            itemCount: fileTiles.length,
                            itemBuilder: (context, index) {
                              return fileTiles[index];
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            itemCount: otherFileTiles.length,
                            itemBuilder: (context, index) {
                              return otherFileTiles[index];
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FileTile extends StatelessWidget {
  final String title;

  FileTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 48, 48, 48),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}