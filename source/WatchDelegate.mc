using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.ActivityMonitor as ActivityMonitor;
using Toybox.Timer as Timer;
using Toybox.Complications as Complications;

class WatchDelegate extends Ui.WatchFaceDelegate {
  var lib;
  function initialize(lib as AsapView) {
    WatchFaceDelegate.initialize();
    self.lib = lib;
  }

  public function onPress(clickEvent) {
    // grab the [x,y] position of the clickEvent

    System.println("pressed");

    // App.Properties.setValue(
    //   "ShowSideText",
    //   !(App.Properties.getValue("ShowSideText") as Lang.Boolean)
    // );
    return true;
  }
}
