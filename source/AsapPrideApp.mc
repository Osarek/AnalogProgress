import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class AsapApp extends Application.AppBase {
        var view;


    function initialize() {
        AppBase.initialize();
        view = new AsapView();
        view.loadProperties();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [ WatchUi.Views ] or [ WatchUi.Views, WatchUi.InputDelegates ] {
        return [ view,new WatchDelegate(view) ] ;
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        view.loadProperties();

        WatchUi.requestUpdate();
    }


function getSettingsView()  as [ WatchUi.Views ] or [ WatchUi.Views, WatchUi.InputDelegates ] or Null{
    return (
      [new CommonMenuSettings(), new CommonInputDelegate()] 
    );
  }

}



