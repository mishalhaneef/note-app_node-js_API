import 'package:crud_operations/screen/add_note_screen/addnote.dart';
import 'package:crud_operations/screen/home_screen/widgets/app_modules.dart';
import 'package:crud_operations/data/data.dart';
import 'package:crud_operations/data/note_model/note_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //code of frame call back
    //* Why?
    // cos when the notelist is called while the screen is building there is
    // a huge chance to clash the build. cos while building the screen the code
    // is trying to call the [notelist]. so when its called the screen will rebuild again
    // so there is a big chance to crash the build. thats why we called a [addPostFrameCallback]
    // so that will make sure that the notelist called after screen build
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final value = await NoteDB.instance.getAllNotes();
    });
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2C),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                TextNote(), // => Head Text Widget of 'Notes'
                AccountImage(), // => widget of account image
              ],
            ),
            const SizedBox(height: 30),
            const SearchBar(), // => widget of search bar (not implemented yet)
            const SizedBox(height: 49),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: NoteDB.instance.noteListNotifier,
                builder: (context, List<NoteModel> newNotes, _) {
                  //if there is no note then a text will show else the note will appear
                  return newNotes.isEmpty
                      ? const EmptyNoteText()
                      : NoteItems(newNotes: newNotes);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigating to add note page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage(
                type: ActionType.addNote,
              ),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 144, 139, 189),
        child: const Icon(
          Icons.add,
          color: Color(0xFF1F1D2C),
        ),
      ),
    );
  }
}
