import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;

class CommonInputDelegate extends WatchUi.Menu2InputDelegate {
  function initialize() {
    Menu2InputDelegate.initialize();
  }

  function onSelect(item) {
    switch (item.getId()) {
      case "ShowSideText":
      var current = Properties.getValue("ShowSideText");
        Properties.setValue("ShowSideText", !current);
        break;
      
       



    }
  }

  function onBack() {
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
  }
}
