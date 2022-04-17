import 'package:crud_operations/screen/add_note_screen/addnote.dart';
import 'package:crud_operations/data/data.dart';
import 'package:crud_operations/data/note_model/note_model.dart';
import 'package:crud_operations/screen/home_screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountImage extends StatelessWidget {
  const AccountImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, top: 20),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          child: Image.asset('asset/bill-gates-wealthiest-person.jpg'),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}

class TextNote extends StatelessWidget {
  const TextNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 20),
      child: Text(
        'Notes',
        style: GoogleFonts.righteous(
          textStyle: const TextStyle(
              color: Color.fromARGB(255, 236, 236, 236), fontSize: 36),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext contet) {
    return Container(
      height: 38,
      width: 323,
      decoration: BoxDecoration(
          color: const Color(0xFF262636),
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'asset/search.svg',
                color: const Color.fromARGB(
                  255,
                  119,
                  119,
                  119,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NoteItems extends StatelessWidget {
  const NoteItems({
    Key? key,
    required this.newNotes,
  }) : super(key: key);
  final List<NoteModel> newNotes;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 3 / 4,
      crossAxisCount: 2,
      mainAxisSpacing: 34,
      crossAxisSpacing: 30,
      padding: const EdgeInsets.all(20),
      //generating list for all note
      children: List.generate(
        newNotes.length,
        (index) {
          //setting the notelist to a variable called [note]
          final note = newNotes[index];
          if (note.id == null) {
            //if the note's id is null set to sizedbox
            //the note id never be null
            const SizedBox();
          }
          return NoteItem(
            id: note.id!,
            //the ?? is the statement (if null)
            content: note.content ?? 'No Content',
            title: note.title ?? 'No Title',
          );
        },
      ),
    );
  }
}

class EmptyNoteText extends StatelessWidget {
  const EmptyNoteText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'No Note Found',
      style: TextStyle(color: Colors.white),
    ));
  }
}

class NoteItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;

  const NoteItem(
      {Key? key, required this.id, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // when tapping the page it will redirect to the page for editing with [id]
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AddNotePage(
              type: ActionType.editNote,
              id: id,
            ),
          ),
        );
      },
      child: Container(
        height: 259,
        width: 167,
        decoration: BoxDecoration(
            color: const Color(0xFF3B3A4D),
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      //title text code displayed here
                      title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.righteous(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 184, 184, 184))),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.more_vert),
                  //   splashRadius: 1,
                  // )

                  //pop menu for edit and delete note
                  PopupMenuButton<int>(
                      //on selected controlle on on selected function
                      onSelected: (item) => onSelected(context, item),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 0,
                              child: const Text('Edit Notes'),
                              onTap: () {},
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: const Text('Delete'),
                              onTap: () {},
                            ),
                          ])
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Text(
                //content text displayed here
                content,
                maxLines: 9,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: GoogleFonts.workSans(
                  textStyle: const TextStyle(
                      color: Color.fromARGB(255, 228, 228, 228)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        // when tapping the page it will redirect to the page for editing with [id],
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AddNotePage(
              type: ActionType.editNote,
              id: id,
            ),
          ),
        );
        break;
      case 1:
        //code to delete note
        NoteDB.instance.deleteNote(id);
        break;
    }
  }
}
