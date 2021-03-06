import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "MedicamentosDB.dart";
import "MedicamentosList.dart";
import "MedicamentosForm.dart";
import "MedicamentosModel.dart" show MedicamentosModel, medicamentosModel;

/// ********************************************************************************************************************
/// The Medicamentos screen.
/// ********************************************************************************************************************
class Medicamentos extends StatelessWidget {
  /// Constructor.
  Medicamentos() {
    print("##35 Medicamentos.constructor");

    // Initial load of data.
    medicamentosModel.loadData("Medicamentos", MedicamentosDB.db);
  } /* End constructor. */

  /// The build() method.
  ///
  /// @param  inContext The BuildContext for this widget.
  /// @return           A Widget.
  Widget build(BuildContext inContext) {
    
    print("##36 Medicamentos.build()");

    return ScopedModel<MedicamentosModel>(
        model: medicamentosModel,
        child: ScopedModelDescendant<MedicamentosModel>(builder:
                (BuildContext inContext, Widget inChild,
                    MedicamentosModel inModel) {
          return IndexedStack(index: inModel.stackIndex, children: [
            MedicamentosList(),
            MedicamentosForm()
          ] /* End IndexedStack children. */
              ); /* End IndexedStack. */
        } /* End ScopedModelDescendant builder(). */
            ) /* End ScopedModelDescendant. */
        ); /* End ScopedModel. */
  } /* End build(). */

} /* End class. */
