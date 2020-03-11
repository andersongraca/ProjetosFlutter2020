import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import 'AlergiasForm.dart';
import "AlergiasModel.dart" show AlergiasModel, alergiasModel;
import 'AlergiasDB.dart';
import 'AlergiasList.dart';

/// ********************************************************************************************************************
/// The Alergias screen.
/// ********************************************************************************************************************
class Alergia extends StatelessWidget {


  /// Constructor.
  Alergia() {

    print("##62 Alergia(): constructor");

    // Initial load of data.
    alergiasModel.loadData("alergia", AlergiasDB.db);
    //nAlergiasModel.loadData(inEntityType, inDatabase);

  } /* End constructor. */


  /// The build() method.
  ///
  /// @param  inContext The BuildContext for this widget.
  /// @return           A Widget.
  Widget build(BuildContext inContext) {

    print("##63 Alergias.build()");

    return ScopedModel<AlergiasModel>(
      model : alergiasModel,
      child : ScopedModelDescendant<AlergiasModel>(
        builder : (BuildContext inContext, Widget inChild, AlergiasModel inModel) {
          return IndexedStack(
            index : inModel.stackIndex,
            children : [
              AlergiasList(),
              AlergiasForm()
            ] /* End IndexedStack children. */
          ); /* End IndexedStack. */
        } /* End ScopedModelDescendant builder(). */
      ) /* End ScopedModelDescendant. */
    ); /* End ScopedModel. */

  } /* End build(). */


} /* End class. */
