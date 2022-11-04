import 'package:flutter/material.dart';
import 'package:master/models/note_model.dart';
import 'package:master/services/database_helper.dart';

// class NoteDetail extends StatefulWidget {
//   final Note? note;
//   const NoteDetail({Key? key, this.note}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return NoteDetailState();
//   }
// }

// class NoteDetailState extends State<NoteDetail> {
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();

//   if(note!=null){titleController.text =note!.title;}
class NoteDetail extends StatelessWidget {
  final Note? note;
  const NoteDetail({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.description;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Notes' : 'Edit Note'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextFormField(
                controller: titleController,
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextFormField(
                controller: descriptionController,
                onChanged: (value) {
                  debugPrint('Something changed in Description Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        note == null ? 'Save' : 'Edit',
                      ),
                      onPressed: () async {
                        final title = titleController.value.text;
                        final description = descriptionController.value.text;

                        if (title.isEmpty || description.isEmpty) {
                          return;
                        }
                        final Note model = Note(
                            title: title,
                            description: description,
                            id: note?.id);
                        if (note == null) {
                          await DatabaseHelper.addNote(model);
                        } else {
                          await DatabaseHelper.updateNote(model);
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
