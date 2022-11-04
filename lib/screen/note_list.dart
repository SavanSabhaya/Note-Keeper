import 'package:flutter/material.dart';
import 'package:master/main.dart';
import 'package:master/models/note_model.dart';
import 'package:master/screen/note_detail.dart';
import 'package:master/services/database_helper.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      // body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Note',
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NoteDetail()));
          setState(() {});
        },
      ),
      body: FutureBuilder<List<Note>?>(
        future: DatabaseHelper.getAllNote(),
        builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemBuilder: (context, index) => NoteWidget(
                  note: snapshot.data![index],
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoteDetail(
                                  note: snapshot.data![index],
                                )));
                    setState(() {});
                  },
                  onLongPress: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                'Are you sure you want to delete this note?'),
                            actions: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () async {
                                  await DatabaseHelper.deleteNote(
                                      snapshot.data![index]);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Text('Yes'),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black)),
                                onPressed: () => Navigator.pop(context),
                                child: const Text('No'),
                              ),
                            ],
                          );
                        });
                  },
                ),
                itemCount: snapshot.data!.length,
              );
            }
            return const Center(
              child: Text('No notes yet'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
