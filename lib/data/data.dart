// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:convert';
import 'package:crud_operations/data/get_all_notes/get_all_notes.dart';
import 'package:crud_operations/data/note_model/note_model.dart';
import 'package:crud_operations/data/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

abstract class APIcalls {
  //abstract class for all function
  Future<NoteModel?> createNote(NoteModel value);
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel?> updateNote(NoteModel value);
  Future<void> deleteNote(String id);
}

class NoteDB extends APIcalls {
  //==singleton
  NoteDB._internal();
  static NoteDB instance = NoteDB._internal();
  NoteDB factory() {
    return instance;
  }

  //==singleton

  //object of dio class and url class
  final dio = Dio();
  final url = Url();

  ValueNotifier<List<NoteModel>> noteListNotifier = ValueNotifier([]);

  NoteDB() {
    //setting base url as common , and response type ad String
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }

  @override
  Future<NoteModel?> createNote(NoteModel value) async {
    try {
      final _result = await dio.post(
        //url fof create not function from API
        url.baseUrl + url.createNote,
        data: value.toJson(),
      );
      final _resultAsJsonMap = jsonDecode(_result.data);

      final note = NoteModel.fromJson(_resultAsJsonMap as Map<String, dynamic>);
      noteListNotifier.value.insert(0, note);
      noteListNotifier.notifyListeners();
      return note;
    } on DioError catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    final _result =
        await dio.delete(url.baseUrl + url.deleteNote.replaceFirst('{id}', id));
    if (_result == null) {
      return;
    } else {
      final _index = noteListNotifier.value.indexWhere((note) => note.id == id);
      if (_index == -1) {
        return;
      }
      noteListNotifier.value.removeAt(_index);
      noteListNotifier.notifyListeners();
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final _result = await dio.get(url.baseUrl + url.getAllNotes);
    if (_result.data != null) {
      //
      final noteResponse = GetAllNotes.fromJson(_result.data);
      noteListNotifier.value.clear();
      noteListNotifier.value.addAll(noteResponse.data.reversed);
      noteListNotifier.notifyListeners();
      //and returning the class
      return noteResponse.data;
    } else {
      noteListNotifier.value.clear();
      return [];
    }
  }

  @override
  Future<NoteModel?> updateNote(NoteModel value) async {
    final _result =
        await dio.put(url.baseUrl + url.updateNote, data: value.toJson());

    if (_result.data == null) {
      return null;
    }

    final index =
        noteListNotifier.value.indexWhere((note) => note.id == value.id);
    if (index == -1) {
      return null;
    }

    noteListNotifier.value.removeAt(index);
    //adding updated data to that index
    noteListNotifier.value.insert(index, value);
    noteListNotifier.notifyListeners();
    return value;
  }

  NoteModel? getNoteByID(String id) {
    try {
      return noteListNotifier.value.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
  }
}
