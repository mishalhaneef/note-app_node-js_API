import 'package:crud_operations/data/data.dart';
import 'package:crud_operations/data/note_model/note_model.dart';
import 'package:crud_operations/screen/home_screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/app_modules.dart';

//code for adding note
enum ActionType {
  //what enum is actually like flag , we can also use a variable for this
  //in this case, but on another case there is also another use with enum
  //in main page we required this actiontype to change purpose of this page dependas
  //on these enum, while choosing the page also enum parameter has been sending
  //and after that these code will decide what has to do , cos there is
  //lot if else case setted for to change the page purposes depend on the enum
  addNote,
  editNote,
}

// ignore: must_be_immutable
class AddNotePage extends StatelessWidget {
  //declaring a action type as enum
  final ActionType type;
  //
  String? id;

  AddNotePage({Key? key, required this.type, this.id}) : super(key: key);

  //button coded and assigned to a variable called [saveButton];
  Widget get saveButton => ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFF706FC8)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
      onPressed: () {
//the edit page and add note page are the same, the purpose will change
//depends on the button click, means if edit note button pressed that will
//direct to this page but with deferent purposes, and if the add note the
//purpose will change to adding a new note .
//so in that note there is a button addnote/update_note, its allso depend
//as the comments says. and the purpose of the button will also change depend
//on the click
        switch (type) {
          case ActionType.addNote:
            saveNote();
            // code add
            break;
          case ActionType.editNote:
            //code to edit
            saveUpdatedNote();
            break;
        }
      },
      child: Text(
        //if else case code to change the button text, if the user click edit
        //note, then the button text will be edit note, else it should be add note
        (type == ActionType.addNote ? 'Add Note' : 'Update Note'),
      ));

  //text editing controller to parse text from textfield
  final contentController = TextEditingController();
  final titleController = TextEditingController();

  //it is a stateless widget, and also need to share the context to a function,
  //as it is a stateless widget we need to take the context from scaffold state.
  //code for taking scaffold contex
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (type == ActionType.editNote) {
      //checking the id is null or not, if null it will back the screen or continue
      //to editing page
      if (id == null) {
        Navigator.of(context).pop();
      }
      //the selected or matched note aaddinging to a variable ot creating a object for that
      final note = NoteDB.instance.getNoteByID(id!);
      //if the note model is null then it will back to homepage
      if (note == null) {
        Navigator.of(context).pop();
      }

      //note's data assigning to exact texfield
      //so this will show the model's title and content to the textfiled
      contentController.text = note!.content ?? 'Error Found';
      titleController.text = note.title ?? 'Error Found';
    }
    return Scaffold(
      //scaffold key assgin as the scaffold key
      key: scaffoldKey,
      backgroundColor: const Color(0xFF1F1D2C),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1F1D2C),
        title: Text(
          //head of page depends on tap
          (type == ActionType.addNote ? 'Add Note' : 'Edit Note'),
          style: GoogleFonts.righteous(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 236, 236, 236),
              fontSize: 28,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: Column(
                  //note typing ui section
                  children: [
                    const SizedBox(height: 100),
                    HeadTextField(titleController: titleController),
                    const SizedBox(height: 51),
                    BodyTextField(contentController: contentController),
                    ClearButton(contentController: contentController),
                    //saved button's widget variable
                    saveButton
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> saveNote() async {
    final title = titleController.text;
    final content = contentController.text;

    //sending user's data to database when press save button
    //set a data model and assigned to [_newNote]
    final _newNote = NoteModel.create(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
    );
    //sending whole data model to create note function
    final newNote = await NoteDB().createNote(_newNote);
    if (newNote != null) {
      //when presed the save button it will save data and also have to
      //quit the page after purpose -- the code for poping out the screen
      Navigator.push(
        scaffoldKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      return;
    }
  }

  Future<void> saveUpdatedNote() async {
    final _title = titleController.text;
    final _content = contentController.text;

    // assgining user typed data to a variable
    final _updatedNote =
        NoteModel.create(id: id, title: _title, content: _content);

    //and sending the variable to update note function
    final _note = await NoteDB.instance.updateNote(_updatedNote);

    if (_note == null) {
    } else {
      Navigator.of(scaffoldKey.currentContext!).pop();
    }
  }
}


//widgets =>
