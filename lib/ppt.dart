import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Color backgroundColor = Color.fromARGB(255, 61, 61, 61);
List<Widget> messages = [
  ChatMessage(
    message: "您好，需要什麼幫助ggggggggggggggggggggggggggggggggggg呢？",
    isSentByMe: false,
  ),
];

class PptPage extends StatefulWidget {
  const PptPage({Key? key}) : super(key: key);

  @override
  _PptPageState createState() => _PptPageState();
}

class _PptPageState extends State<PptPage> {
  void _updateMessages() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: SlideView(
              updateMessagesCallback: _updateMessages,
            ),
          ),
          VerticalDivider(width: 1, color: Colors.grey),
          Expanded(
            flex: 1,
            child: ChatSidebar(),
          ),
        ],
      ),
    );
  }
}


class SlideView extends StatefulWidget {
  final VoidCallback updateMessagesCallback;

  const SlideView({Key? key, required this.updateMessagesCallback}) : super(key: key);


  @override
  _SlideViewState createState() => _SlideViewState();
}

class _SlideViewState extends State<SlideView> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final String text = _controller.text;
    if (text.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(message: text, isSentByMe: true));
        _controller.clear();
      });
      widget.updateMessagesCallback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'Slide Content Here',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              Text('2 / 36'),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    hintStyle: TextStyle(color: Colors.white), // Changed hint text color to white
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  onSubmitted: (value) {
                    _sendMessage(); // Call the _sendMessage function when 'Enter' is pressed
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.white), // Changed icon color to white
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class ChatSidebar extends StatefulWidget {
  @override
  _ChatSidebarState createState() => _ChatSidebarState();
}

class _ChatSidebarState extends State<ChatSidebar> {
  final ScrollController _scrollController = ScrollController(); // Step 1: Declare ScrollController

  @override
  void initState() {
    super.initState();
    // Initialize your ScrollController here if needed
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 48, 48, 48),
      child: Scrollbar(
        thickness: 6.0,
        radius: Radius.circular(10),
        controller: _scrollController, // Connect the Scrollbar to the ScrollController
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController, // Step 4: Assign the ScrollController to ListView.builder
                padding: EdgeInsets.all(10),
                itemCount: messages.length,
                itemBuilder: (context, index) => messages[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatefulWidget {
  final String message;
  final bool isSentByMe;

  ChatMessage({required this.message, required this.isSentByMe});

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  String selectedText = "";

  void _handleSelectionChange(TextSelection selection, SelectionChangedCause? cause) {
    if (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.drag) {
      setState(() {
        selectedText = widget.message.substring(selection.start, selection.end);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget messageWidget = Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.isSentByMe ? backgroundColor : Color.fromARGB(255, 80, 80, 80),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SelectableText(
        widget.message,
        style: TextStyle(fontSize: 16, color: Colors.white),
        onSelectionChanged: _handleSelectionChange,
      ),
    );

    if (!widget.isSentByMe) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: messageWidget,
            ),
            IconButton(
              icon: Icon(Icons.volume_up_rounded, size: 30, color: Colors.white),
              onPressed: () {
                // Print the selected text when the volume_up button is clicked
                print('Selected text: $selectedText');
              },
            ),
          ],
        ),
      );
    }

    return Align(
      alignment: widget.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: messageWidget,
    );
  }
}