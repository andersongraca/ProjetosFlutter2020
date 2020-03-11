import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "NotasDB.dart";
import "NotasModel.dart" show Nota, NotasModel, notasModel;


/// ****************************************************************************
/// The Notas List sub-screen.
/// ****************************************************************************
class NotasList extends StatelessWidget {


  /// The build() method.
  ///
  /// @param  inContext The BuildContext for this widget.
  /// @return           A Widget.
  Widget build(BuildContext inContext) {

    print("##38 NotasList.build()");

    // Return widget.
    return ScopedModel<NotasModel>(
      model : notasModel,
      child : ScopedModelDescendant<NotasModel>(
        builder : (BuildContext inContext, Widget inChild, NotasModel inModel) {
          return Scaffold(
            // Add nota.
            floatingActionButton : FloatingActionButton(
              child : Icon(Icons.add, color : Colors.white),
              onPressed : () async {
                notasModel.entityBeingEdited = Nota();
                notasModel.setColor(null);
                notasModel.setStackIndex(1);
              }
            ),
            body : ListView.builder(
              itemCount : notasModel.entityList.length,
              itemBuilder : (BuildContext inBuildContext, int inIndex) {
                Nota nota = notasModel.entityList[inIndex];
                // Determine nota background color (default to white if none was selected).
                Color color = Colors.white;
                switch (nota.color) {
                  case "red" : color = Colors.red; break;
                  case "green" : color = Colors.green; break;
                  case "blue" : color = Colors.blue; break;
                  case "yellow" : color = Colors.yellow; break;
                  case "grey" : color = Colors.grey; break;
                  case "purple" : color = Colors.purple; break;
                }
                return Container(
                  padding : EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child : Slidable(
                    actionPane : SlidableBehindActionPane(),//SlidableDrawerDelegate(),
                    actionExtentRatio : .25,
                    secondaryActions : [
                      IconSlideAction(
                        caption : "Delete",
                        color : Colors.red,
                        icon : Icons.delete,
                        onTap : () => _deleteNota(inContext, nota)
                      )
                    ],
                    child : Card(
                      elevation : 8,
                      color : color,
                      child : ListTile(
                        title : Text("${nota.title}"),
                        subtitle : Text("${nota.content}"),
                        // Edit existing nota.
                        onTap : () async {
                          // Get the data from the database and send to the edit view.
                          notasModel.entityBeingEdited = await NotasDB.db.get(nota.id);
                          notasModel.setColor(notasModel.entityBeingEdited.color);
                          notasModel.setStackIndex(1);
                        }
                      )
                    ) /* End Card. */
                  ) /* End Slidable. */
                ); /* End Container. */
              } /* End itemBuilder. */
            ) /* End End ListView.builder. */
          ); /* End Scaffold. */
        } /* End ScopedModelDescendant builder. */
      ) /* End ScopedModelDescendant. */
    ); /* End ScopedModel. */

  } /* End build(). */


  /// Show a dialog requesting delete confirmation.
  ///
  /// @param  inContext The BuildContext of the parent Widget.
  /// @param  inNota    The nota (potentially) being deleted.
  /// @return           Future.
  Future _deleteNota(BuildContext inContext, Nota inNota) async {

    print("##39 NotastList._deleteNota(): inNota = $inNota");

    return showDialog(
      context : inContext,
      barrierDismissible : false,
      builder : (BuildContext inAlertContext) {
        return AlertDialog(
          title : Text("Delete Nota"),
          content : Text("Are you sure you want to delete ${inNota.title}?"),
          actions : [
            FlatButton(child : Text("Cancel"),
              onPressed: () {
                // Just hide dialog.
                Navigator.of(inAlertContext).pop();
              }
            ),
            FlatButton(child : Text("Delete"),
              onPressed : () async {
                // Delete from database, then hide dialog, show SnackBar, then re-load data for the list.
                await NotasDB.db.delete(inNota.id);
                Navigator.of(inAlertContext).pop();
                Scaffold.of(inContext).showSnackBar(
                  SnackBar(
                    backgroundColor : Colors.red,
                    duration : Duration(seconds : 2),
                    content : Text("Nota deleted")
                  )
                );
                // Reload data from database to update list.
                notasModel.loadData("notas", NotasDB.db);
              }
            )
          ]
        );
      }
    );

  } /* End _deleteNota(). */


} /* End class. */
