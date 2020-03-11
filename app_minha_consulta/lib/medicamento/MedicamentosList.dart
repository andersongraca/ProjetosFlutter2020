import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:intl/intl.dart";
import "MedicamentosDB.dart";
import "MedicamentosModel.dart"
    show Medicamento, MedicamentosModel, medicamentosModel;

/// ********************************************************************************************************************
/// The medicamentos List sub-screen.
/// ********************************************************************************************************************
class MedicamentosList extends StatelessWidget {
  /// The build() method.
  ///
  /// @param  inContext The BuildContext for this widget.
  /// @return           A Widget.
  Widget build(BuildContext inContext) {
    print("##12 MedicamentosList.build()");

    // Return widget.
    return ScopedModel<MedicamentosModel>(
        model: medicamentosModel,
        child: ScopedModelDescendant<MedicamentosModel>(builder:
                (BuildContext inContext, Widget inChild,
                    MedicamentosModel inModel) {
          return Scaffold(
              // Add medicamento.
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add, color: Colors.white),
                  onPressed: () async {
                    medicamentosModel.entityBeingEdited = Medicamento();
                    medicamentosModel.setChosenDate(null);
                    medicamentosModel.setStackIndex(1);
                  }),
              body: ListView.builder(
                  // Get the first Card out of the shadow.
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  itemCount: medicamentosModel.entityList.length,
                  itemBuilder: (BuildContext inBuildContext, int inIndex) {
                    Medicamento medicamento =
                        medicamentosModel.entityList[inIndex];
                    // Get the date, if any, in a human-readable format.
                    String sDueDate;
                    if (medicamento.dueDate != null) {
                      List dateParts = medicamento.dueDate.split(",");
                      DateTime dueDate = DateTime(int.parse(dateParts[0]),
                          int.parse(dateParts[1]), int.parse(dateParts[2]));
                      sDueDate =
                          DateFormat.yMMMMd("en_US").format(dueDate.toLocal());
                    }
                    // Create the Slidable.
                    return Slidable(
                      actionPane:
                          SlidableDrawerActionPane(), //SlidableDrawerDelegate(),
                      actionExtentRatio: .25,
                      child: ListTile(
                          leading: Checkbox(
                              value: medicamento.completed == "true"
                                  ? true
                                  : false,
                              onChanged: (inValue) async {
                                // Update the completed value for this medicamento and refresh the list.
                                medicamento.completed = inValue.toString();
                                await MedicamentosDB.db.update(medicamento);
                                medicamentosModel.loadData(
                                    "medicamentos", MedicamentosDB.db);
                              }),
                          title: Text("${medicamento.description}",
                              // Dim and strikethrough the text when the medicamento is completed.
                              style: medicamento.completed == "true"
                                  ? TextStyle(
                                      color: Theme.of(inContext).disabledColor,
                                      decoration: TextDecoration.lineThrough)
                                  : TextStyle(
                                      color: Theme.of(inContext)
                                          .textTheme
                                          .headline
                                          .color)),
                          subtitle: medicamento.dueDate == null
                              ? null
                              : Text(sDueDate,
                                  // Dim and strikethrough the text when the medicamento is completed.
                                  style: medicamento.completed == "true"
                                      ? TextStyle(
                                          color:
                                              Theme.of(inContext).disabledColor,
                                          decoration:
                                              TextDecoration.lineThrough)
                                      : TextStyle(
                                          color: Theme.of(inContext)
                                              .textTheme
                                              .headline
                                              .color)),
                          // Edit existing medicamento.
                          onTap: () async {
                            // Can't edit a completed medicamento.
                            if (medicamento.completed == "true") {
                              return;
                            }
                            // Get the data from the database and send to the edit view.
                            medicamentosModel.entityBeingEdited =
                                await MedicamentosDB.db.get(medicamento.id);
                            // Parse out the due date, if any, and set it in the model for display.
                            if (medicamentosModel.entityBeingEdited.dueDate ==
                                null) {
                              medicamentosModel.setChosenDate(null);
                            } else {
                              medicamentosModel.setChosenDate(sDueDate);
                            }
                            medicamentosModel.setStackIndex(1);
                          }),
                      secondaryActions: [
                        IconSlideAction(
                            caption: "Delete",
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () =>
                                _deleteMedicamento(inContext, medicamento))
                      ],
                    ); /* End Slidable. */
                  } /* End itemBuilder. */
                  ) /* End ListView.builder. */
              ); /* End Scaffold. */
        } /* End ScopedModelDescendant builder. */
            ) /* End ScopedModelDescendant. */
        ); /* End ScopedModel. */
  } /* End build(). */

  /// Show a dialog requesting delete confirmation.
  ///
  /// @param  inContext The parent build context.
  /// @param  inMedicamento    The medicamento (potentially) being deleted.
  /// @return           Future.
  Future _deleteMedicamento(
      BuildContext inContext, Medicamento inMedicamento) async {
    print(
        "##13 MedicamentosList._deleteMedicamento(): inMedicamento = $inMedicamento");

    return showDialog(
        context: inContext,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return AlertDialog(
              title: Text("Delete medicamento"),
              content: Text(
                  "Are you sure you want to delete ${inMedicamento.description}?"),
              actions: [
                FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      // Just hide dialog.
                      Navigator.of(inAlertContext).pop();
                    }),
                FlatButton(
                    child: Text("Delete"),
                    onPressed: () async {
                      // Delete from database, then hide dialog, show SnackBar, then re-load data for the list.
                      await MedicamentosDB.db.delete(inMedicamento.id);
                      Navigator.of(inAlertContext).pop();
                      Scaffold.of(inContext).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          content: Text("medicamento deleted")));
                      // Reload data from database to update list.
                      medicamentosModel.loadData(
                          "medicamentos", MedicamentosDB.db);
                    })
              ]);
        });
  } /* End _deleteMedicamento(). */

} /* End class. */
