import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httprequestsample/fake_data.dart';
import 'post.dart';

Future<List<Post>> fetchFakePosts() async {
  // throw Exception('Failed to load posts');
  await Future.delayed(const Duration(milliseconds: 1000));
  return List<Post>.from(json.decode(fakeData).map((x) => Post.fromJson(x)));
}

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/posts'));
  if (response.statusCode == 200) {
    return List<Post>.from(
        json.decode(response.body).map((x) => Post.fromJson(x)));
  } else {
    throw Exception('Failed to load posts');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Post>> futurePost;

  @override
  void initState() {
    super.initState();
    // futurePost = fetchPosts();
    futurePost = fetchFakePosts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Post>>(
            future: futurePost,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(snapshot.data![index].title),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
