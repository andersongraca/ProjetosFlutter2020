import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "NotasDB.dart";
import "NotasModel.dart" show NotasModel, notasModel;


/// ****************************************************************************
/// The Notes Entry sub-screen.
/// ****************************************************************************
class NotasForm extends StatelessWidget {


  /// Controllers for TextFields.
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contentEditingController = TextEditingController();


  // Key for form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  /// Constructor.
  NotasForm() {

    print("##40 NotasForm.constructor");

    // Attach event listeners to controllers to capture entries in model.
    _titleEditingController.addListener(() {
      notasModel.entityBeingEdited.title = _titleEditingController.text;
    });
    _contentEditingController.addListener(() {
      notasModel.entityBeingEdited.content = _contentEditingController.text;
    });

  } /* End constructor. */


  /// The build() method.
  ///
  /// @param  inContext The BuildContext for this widget.
  /// @return           A Widget.
  Widget build(BuildContext inContext) {

    print("##41 NotasForm.build()");

    // Set value of controllers.
    _titleEditingController.text = notasModel.entityBeingEdited.title;
    _contentEditingController.text = notasModel.entityBeingEdited.content;

    // Return widget.
    return ScopedModel(
      model : notasModel,
      child : ScopedModelDescendant<NotasModel>(
        builder : (BuildContext inContext, Widget inChild, NotasModel inModel) {
          return Scaffold(
            bottomNavigationBar : Padding(
              padding : EdgeInsets.symmetric(vertical : 0, horizontal : 5),
              child : Row(
                children : [
                  FlatButton(
                    child : Text("Cancel"),
                    onPressed : () {
                      // Hide soft keyboard.
                      FocusScope.of(inContext).requestFocus(FocusNode());
                      // Go back to the list view.
                      inModel.setStackIndex(0);
                    }
                  ),
                  Spacer(),
                  FlatButton(
                    child : Text("Save"),
                    onPressed : () { _save(inContext, notasModel); }
                  )
                ]
              )
            ),
            body : Form(
              key : _formKey,
              child : ListView(
                children : [
                  // Title.
                  ListTile(
                    leading : Icon(Icons.title),
                    title : TextFormField(
                      decoration : InputDecoration(hintText : "Title"),
                      controller : _titleEditingController,
                      validator : (String inValue) {
                        if (inValue.length == 0) { return "Please enter a title"; }
                        return null;
                      }
                    )
                  ),
                  // Content.
                  ListTile(
                    leading : Icon(Icons.content_paste),
                    title : TextFormField(
                      keyboardType : TextInputType.multiline, maxLines : 8,
                      decoration : InputDecoration(hintText : "Content"),
                      controller : _contentEditingController,
                      validator : (String inValue) {
                        if (inValue.length == 0) { return "Please enter content"; }
                        return null;
                      }
                    )
                  ),
                  // Note color.
                  ListTile(
                    leading : Icon(Icons.color_lens),
                    title : Row(
                      children : [
                        GestureDetector(
                          child : Container(
                            decoration : ShapeDecoration(shape :
                              Border.all(color : Colors.red, width : 15) +
                              Border.all(
                                width : 5,
                                color : notasModel.color == "red" ? Colors.red : Theme.of(inContext).canvasColor
                              )
                            )
                          ),
                          onTap : () {
                            notasModel.entityBeingEdited.color = "red";
                            notasModel.setColor("red");
                          }
                        ),
                        Spacer(),
                        GestureDetector(
                          child : Container(
                            decoration : ShapeDecoration(shape :
                              Border.all(color : Colors.green, width : 15) +
                              Border.all(
                                width : 5,
                                color : notasModel.color == "green" ? Colors.green : Theme.of(inContext).canvasColor
                              )
                            )
                          ),
                          onTap : () {
                            notasModel.entityBeingEdited.color = "green";
                            notasModel.setColor("green");
                          }
                        ),
                        Spacer(),
                        GestureDetector(
                          child : Container(
                            decoration : ShapeDecoration(shape :
                              Border.all(color : Colors.blue, width : 15) +
                              Border.all(
                                width : 5,
                                color : notasModel.color == "blue" ? Colors.blue : Theme.of(inContext).canvasColor
                              )
                            )
                          ),
                          onTap : () {
                            notasModel.entityBeingEdited.color = "blue";
                            notasModel.setColor("blue");
                          }
                        ),
                        Spacer(),
                        GestureDetector(
                          child : Container(
                            decoration : ShapeDecoration(shape :
                              Border.all(color : Colors.yellow, width : 15) +
                              Border.all(
                                width : 5,
                                color : notasModel.color == "yellow" ? Colors.yellow : Theme.of(inContext).canvasColor
                              )
                            )
                          ),
                          onTap : () {
                            notasModel.entityBeingEdited.color = "yellow";
                            notasModel.setColor("yellow");
                          }
                        ),
                        Spacer(),
                        GestureDetector(
                          child : Container(
                            decoration : ShapeDecoration(shape :
                              Border.all(color : Colors.grey, width : 15) +
                              Border.all(
                                width : 5,
                                color : notasModel.color == "grey" ? Colors.grey : Theme.of(inContext).canvasColor
                              )
                            )
                          ),
                          onTap : () {
                            notasModel.entityBeingEdited.color = "grey";
                            notasModel.setColor("grey");
                          }
                        ),
                        Spacer(),
                        GestureDetector(
                          child : Container(
                            decoration : ShapeDecoration(shape :
                              Border.all(color : Colors.purple, width : 15) +
                              Border.all(
                                width : 5,
                                color : notasModel.color == "purple" ? Colors.purple : Theme.of(inContext).canvasColor
                              )
                            )
                          ),
                          onTap : () {
                            notasModel.entityBeingEdited.color = "purple";
                            notasModel.setColor("purple");
                          }
                        )
                      ]
                    )
                  )
                ] /* End Column children. */
              ) /* End ListView. */
            ) /* End Form. */
          ); /* End Scaffold. */
        } /* End ScopedModelDescendant builder(). */
      ) /* End ScopedModelDescendant. */
    ); /* End ScopedModel. */

  } /* End build(). */


  /// Save this contact to the database.
  ///
  /// @param inContext The BuildContext of the parent widget.
  /// @param inModel   The NotasModel.
  void _save(BuildContext inContext, NotasModel inModel) async {

    print("##42 NotasForm._save()");

    // Abort if form isn't valid.
    if (!_formKey.currentState.validate()) { return; }

    // Creating a new note.
    if (inModel.entityBeingEdited.id == null) {

      print("##43 NotasForm._save(): Creating: ${inModel.entityBeingEdited}");
      await NotasDB.db.create(notasModel.entityBeingEdited);

    // Updating an existing note.
    } else {

      print("##44 NotasForm._save(): Updating: ${inModel.entityBeingEdited}");
      await NotasDB.db.update(notasModel.entityBeingEdited);

    }

    // Reload data from database to update list.
    notasModel.loadData("notes", NotasDB.db);

    // Go back to the list view.
    inModel.setStackIndex(0);

    // Show SnackBar.
    Scaffold.of(inContext).showSnackBar(
      SnackBar(
        backgroundColor : Colors.green,
        duration : Duration(seconds : 2),
        content : Text("Note saved")
      )
    );

  } /* End _save(). */


} /* End class. */
