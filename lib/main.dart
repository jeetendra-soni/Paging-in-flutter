import 'package:flutter/material.dart';

void main() {
  runApp(PagingApp());
}

class PagingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paging Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PagingScreen(),
    );
  }
}

class PagingScreen extends StatefulWidget {
  @override
  _PagingScreenState createState() => _PagingScreenState();
}

class _PagingScreenState extends State<PagingScreen> {
  final ScrollController _scrollController = ScrollController();
  List<String> items = List.generate(50, (index) => 'Item ${index + 1}');
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isLoading = true;
        _loadMoreItems();
      });
    }
  }

  Future<void> _loadMoreItems() async {
    // Simulate an asynchronous delay for loading more items
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      List<String> newItems = List.generate(20, (index) => 'Item ${items.length + index + 1}');
      items.addAll(newItems);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paging Example'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        controller: _scrollController,
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < items.length) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text("${index+1}"),
                ),
                title: Text("Title of List Item ${index + 1}"),
                subtitle:Text("Sub title here.."),
                trailing: Icon(Icons.double_arrow),
              ),

            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
