class BatteryDays extends Battery {
  static const CODE=300;
  function initialize() {
    Battery.initialize();
  }

  function getString() as $.Toybox.Lang.String {
    return Battery.getDays();
  }
}
