import 'package:flutter/material.dart';
import 'package:gunfire/model/user_model.dart';
import 'package:gunfire/service/api_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<UserModel>? _userModel = [];
  late List<UserModel>? _filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _getData();
    _searchController.addListener(_onSearchChanged);
  }

  void _getData() async {
    _userModel = (await ApiService().getUsers());
    setState(() {
      _filteredUsers = _userModel;
    });
  }

  void _onSearchChanged() {
    if (_userModel == null) return;

    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _userModel!
          .where((user) =>
              user.username.toLowerCase().contains(query) ||
              user.email.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                ),
                autofocus: true,
              )
            : const Text('REST API Example'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _filteredUsers = _userModel; // Reset to the full list
                }
              });
            },
          ),
        ],
      ),
      body: _filteredUsers == null || _filteredUsers!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _filteredUsers!.length,
              itemBuilder: (context, index) {
                var user = _filteredUsers![index];
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(user.id.toString()),
                          Text(user.username),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(user.email),
                          Text(user.website),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
