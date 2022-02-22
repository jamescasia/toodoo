import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toodoo/models/Task.dart';
import 'package:toodoo/services/Env.dart';

/*
 * Class for performing http requests, fetch, upload, delete, and update
 */
class ApiProvider {
  Future<List<Task>> fetchTasks() async {
    http.Client client = http.Client();
    final response = await client.get(Uri.parse(Environment.URL.toString()));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      final List jsonlist = json.decode(response.body);
      final List<Task> tasks = jsonlist.map((t) => Task.fromJson(t)).toList();
      return tasks;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tasks');
    }
  }

  uploadTask(Task task) async {
    http.Client client = http.Client();
    return await client.post(Uri.parse(Environment.URL), body: task.toJson());
  }

  deleteTask(Task task) async {
    http.Client client = http.Client();
    return await client.delete(Uri.parse(Environment.URL + "/${task.id}"),
        body: task.toJson());
  }

  updateTask(Task task) async {
    http.Client client = http.Client();
    return await client.patch(Uri.parse(Environment.URL + "/${task.id}"),
        body: task.toJson());
  }
}
