 import Toybox.Lang;

class WeatherTemperature extends WeatherData {
 

  static const CODE = 511;

  function initialize() {
    WeatherData.initialize();
    Temperature.initialize();
  }
  var text;

  function getString() as $.Toybox.Lang.String {
     if (!(Toybox has :Weather)) {
      return "N/A";
    }
    return getTemperature();
  }  
  
}
