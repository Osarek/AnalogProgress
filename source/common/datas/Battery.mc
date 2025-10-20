import Toybox.Lang;

class Battery extends Datas {
    static const CODE=3;

var days,hours;
  function initialize() {
    Datas.initialize(Rez.Drawables.battery, "BAT","BATTERY");
  }

    function hasProgress(){
    return true;
  }
  

  function getNumber(){
     if (!(Toybox.System.Stats has :battery)) {
      return 0;
     }
    return System.getSystemStats().battery.toNumber();
  }

  function getString() as String {
     if (!(Toybox.System.Stats has :battery)) {
      return "N/A";
    }
    return Battery.getPercent();
  }

  function getPercent() as String {
      if (!(Toybox.System.Stats has :battery)) {
      return "N/A";
    }
    return System.getSystemStats().battery.toNumber() + "%";
  }

  function getDays() as String  {
      if (!(Toybox.System.Stats has :batteryInDays)) {
      return "N/A";
    }
    var batteryString;
    var days =
      System.getDeviceSettings().systemLanguage == System.LANGUAGE_FRE
        ? "J"
        : "D";
    if (System.getSystemStats().batteryInDays < 1) {
      batteryString =
        (System.getSystemStats().batteryInDays * 24).toNumber() + "H";
    } else {
      batteryString = System.getSystemStats().batteryInDays.toNumber() + days;
    }

    return batteryString;
  }
}
