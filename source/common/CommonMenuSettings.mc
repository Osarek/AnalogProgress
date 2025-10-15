using Toybox.WatchUi;
import Toybox.Application;

class CommonMenuSettings extends WatchUi.Menu2 {
  function initialize() {
    Menu2.initialize(null);
    Menu2.setTitle("Settings");
    Menu2.addItem(
      new WatchUi.ToggleMenuItem(
        "Show side text",
        null,
        "ShowSideText",
        Properties.getValue("ShowSideText"),
        null
      )
    );
   
  
  }
}
