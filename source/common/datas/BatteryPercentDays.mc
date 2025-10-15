import Toybox.Lang;


class BatteryPercentDays extends Battery {
  static const CODE=301;
  function initialize() {
    Battery.initialize();
  }

  function getString() as $.Toybox.Lang.String {
    return Battery.getPercent()+"/"+Battery.getDays();
  }
}
