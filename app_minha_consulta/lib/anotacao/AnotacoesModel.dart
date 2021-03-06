import "../BaseModel.dart";


/// A class representing this PIM entity type.
class Anotacao {


  /// The fields this entity type contains.
  int id;
  String title;
  String description;
  String apptDate; // YYYY,MM,DD
  String apptTime; // HH,MM


  /// Just for debugging, so we get something useful in the console.
  String toString() {
    return "{ id=$id, title=$title, description=$description, apptDate=$apptDate, apptDate=$apptTime }";
  }


} /* End class. */


/// ********************************************************************************************************************
/// The model backing this entity type's views.
/// ********************************************************************************************************************
class AnotacoesModel extends BaseModel {


  /// The Anotacao time.  Needed to be able to display what the user picks in the Text widget on the entry screen.
  String apptTime;


  /// For display of the Anotacao time chosen by the user.
  ///
  /// @param inApptTime The Anotacao date in HH:MM form.
  void setApptTime(String inApptTime) {

    apptTime = inApptTime;
    notifyListeners();

  } /* End setApptTime(). */


} /* End class. */


// The one and only instance of this model.
AnotacoesModel anotacoesModel = AnotacoesModel();
