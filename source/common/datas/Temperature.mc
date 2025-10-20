import Toybox.Lang;

class Temperature extends Datas {
  static const CODE = 5;

  function initialize() {
    Datas.initialize(Rez.Drawables.temperature, "TEMP","Temperature");
  }

  function getString() as $.Toybox.Lang.String {
     if (!(Toybox has :Weather)) {
      return "N/A";
    }
    return getTemperature();
  }

  function getTemperature() {
    MyWeather.registerCurrent = true;
    var temperatureString = "--°";
    MyWeather.refreshTemp();
    var currentCondition = MyWeather.getCurrentConditions();
    if (currentCondition != null) {
      if (currentCondition.temperature != null) {
        temperatureString = CtoF(currentCondition.temperature) + "°";
      }
    }
    return temperatureString;
  }

  function CtoF(number as Number) as Number {
    if (
      System.getDeviceSettings().temperatureUnits == System.UNIT_METRIC ||
      number == 999
    ) {
      return number.toNumber();
    } else {
      return ((number * 9) / 5 + 32).toNumber();
    }
  }
}
