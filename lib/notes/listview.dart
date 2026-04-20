import 'package:flutter/material.dart';
import 'package:my_first_app/services/cloud/cloudnote.dart';
// import 'package:my_first_app/services/crud/note_service.dart';
import 'package:my_first_app/utilities/deletedialogue.dart';

typedef NoteCallBack = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onTap;

  const NotesListView({
    super.key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(note);
          },
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialogue(context);
              if (shouldDelete) {
                onDeleteNote(note);
              }
            },

            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
