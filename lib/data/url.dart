class Url {
  /// used a api for local [hosting] , and its all n point for accesing API's
  /// function.and the base url is fixed local host port ip adress , for android
  /// emulator, this work basically like first the ip adress and then the link 
  /// for to the function, so we setting all these to a variable to ease of use
  String baseUrl = 'http://10.0.2.2:3000';
  String createNote = '/note/create';
  String updateNote = '/note/update';
  String deleteNote = '/note/delete/{id}';
  String getAllNotes = '/note/getAll';
}
