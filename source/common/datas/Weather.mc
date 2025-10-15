 import Toybox.Lang;

class WeatherData extends Temperature {
 

  static const CODE = 51;

  function initialize() {
    Temperature.initialize();
    Datas.initialize(Rez.Drawables.temperature, "TODO");
  }
  var text;

  function getString() as $.Toybox.Lang.String {
     if (!(Toybox has :Weather)) {
      return "N/A";
    }
    return text;
  }

  function refreshData() {
    var rez = null;

    if (Toybox has :Weather) {
      MyWeather.registerCurrent = true;
      MyWeather.refreshTemp();
      var currentCondition = MyWeather.getCurrentConditions();
      if (currentCondition != null) {
        if (currentCondition.condition != null) {
          rez = Rez.Drawables.small_clouds;
          switch (currentCondition.condition) {
            case Weather.CONDITION_CLEAR:
              text = "Clear";
              rez = Rez.Drawables.sunny;
              break;
            case Weather.CONDITION_PARTLY_CLOUDY:
              text = "Partly cloudy";
              rez = Rez.Drawables.suncloud;
              break;
            case Weather.CONDITION_MOSTLY_CLOUDY:
              text = "Mostly cloudy";
              rez = Rez.Drawables.big_clouds;
              break;
            case Weather.CONDITION_RAIN:
              text = "Rain";
              rez = Rez.Drawables.rain;
              break;
            case Weather.CONDITION_SNOW:
              text = "Snow";
              rez = Rez.Drawables.snow;
              break;
            case Weather.CONDITION_WINDY:
              text = "Windy";
              rez = Rez.Drawables.big_clouds;
              break;
            case Weather.CONDITION_THUNDERSTORMS:
              text = "Thunderstorms";
              rez = Rez.Drawables.thunder;
              break;
            case Weather.CONDITION_WINTRY_MIX:
              text = "Wintry mix";
              break;
            case Weather.CONDITION_FOG:
              text = "Fog";
              rez = Rez.Drawables.fog;
              break;
            case Weather.CONDITION_HAZY:
              text = "Hazy";
              rez = Rez.Drawables.haize;
              break;
            case Weather.CONDITION_HAIL:
              text = "Hail";
              rez = Rez.Drawables.haize;
              break;
            case Weather.CONDITION_SCATTERED_SHOWERS:
              text = "Scattered showers";
              break;
            case Weather.CONDITION_SCATTERED_THUNDERSTORMS:
              text = "Scattered thunderstorms";
              rez = Rez.Drawables.thunder;
              break;
            case Weather.CONDITION_UNKNOWN_PRECIPITATION:
              text = "Unknown precipitation";
              rez = Rez.Drawables.small_clouds;
              break;
            case Weather.CONDITION_LIGHT_RAIN:
              text = "Light rain";
              rez = Rez.Drawables.rain;
              break;
            case Weather.CONDITION_HEAVY_RAIN:
              text = "Heavy rain";
              rez = Rez.Drawables.rain;
              break;

            case Weather.CONDITION_LIGHT_SNOW:
              text = "Light snow";
              rez = Rez.Drawables.snow;
              break;

            case Weather.CONDITION_HEAVY_SNOW:
              text = "Heavy snow";
              rez = Rez.Drawables.snow;
              break;
            case Weather.CONDITION_LIGHT_RAIN_SNOW:
              text = "Light rain snow";
              rez = Rez.Drawables.snow;
              break;
            case Weather.CONDITION_HEAVY_RAIN_SNOW:
              text = "Heavy rain snow";
              rez = Rez.Drawables.snow;
              break;
            case Weather.CONDITION_CLOUDY:
              text = "Cloudy";
              rez = Rez.Drawables.big_clouds;
              break;
            case Weather.CONDITION_RAIN_SNOW:
              text = "Rain snow";
              rez = Rez.Drawables.snow;
              break;
            case Weather.CONDITION_PARTLY_CLEAR:
              text = "Partly clear";
              rez = Rez.Drawables.suncloud;
              break;
            case Weather.CONDITION_MOSTLY_CLEAR:
              text = "Mostly clear";
              rez = Rez.Drawables.sunny;
              break;
            case Weather.CONDITION_LIGHT_SHOWERS:
              text = "Light showers";
              rez = Rez.Drawables.sunrain;
              break;
            case Weather.CONDITION_SHOWERS:
              text = "Showers";
              rez = Rez.Drawables.sunrain;
              break;
            case Weather.CONDITION_HEAVY_SHOWERS:
              text = "Heavy showers";
              break;
            case Weather.CONDITION_CHANCE_OF_SHOWERS:
              text = "Chance of showers";
              rez = Rez.Drawables.rain;
              break;
            case Weather.CONDITION_CHANCE_OF_THUNDERSTORMS:
              text = "Chance of thunderstorms";
              rez = Rez.Drawables.thunder;
              break;
            case Weather.CONDITION_MIST:
              text = "Mist";
              break;
            case Weather.CONDITION_DUST:
              text = "Dust";
              break;
            case Weather.CONDITION_DRIZZLE:
              text = "Drizzle";
              break;
            case Weather.CONDITION_TORNADO:
              text = "Tornado";
              break;
            case Weather.CONDITION_SMOKE:
              text = "Smoke";
              break;
            case Weather.CONDITION_ICE:
              text = "Ice";
              break;
            case Weather.CONDITION_SAND:
              text = "Sand";
              break;
            case Weather.CONDITION_SQUALL:
              text = "Squall";
              break;
            case Weather.CONDITION_SANDSTORM:
              text = "Sandstorm";
              break;
            case Weather.CONDITION_VOLCANIC_ASH:
              text = "Volcanic ash";
              break;
            case Weather.CONDITION_HAZE:
              text = "Haze";
              break;
            case Weather.CONDITION_FAIR:
              text = "Fair";
              break;
            case Weather.CONDITION_HURRICANE:
              text = "Hurricane";
              break;
            case Weather.CONDITION_TROPICAL_STORM:
              text = "Tropical storm";
              break;
            case Weather.CONDITION_CHANCE_OF_SNOW:
              text = "Chance of snow";
              break;
            case Weather.CONDITION_CHANCE_OF_RAIN_SNOW:
              text = "Chance of rain snow";
              rez = Rez.Drawables.snow;
              break;
            case Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN:
              text = "Cloudy chance of rain";
              rez = Rez.Drawables.sunrain;
              break;
            case Weather.CONDITION_CLOUDY_CHANCE_OF_SNOW:
              text = "Cloudy chance of snow";
              break;
            case Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN_SNOW:
              text = "Cloudy chance of rain snow";
              break;
            case Weather.CONDITION_FLURRIES:
              text = "Flurries";
              break;
            case Weather.CONDITION_FREEZING_RAIN:
              text = "Freezing rain";
              break;
            case Weather.CONDITION_SLEET:
              text = "Sleet";
              break;
            case Weather.CONDITION_ICE_SNOW:
              text = "Ice snow";
              break;
            case Weather.CONDITION_THIN_CLOUDS:
              text = "Thin clouds";
              break;
            case Weather.CONDITION_UNKNOWN:

            default:
              text = "N/A";
              break;
          }
        }
      }

      if (rez != null && self.rez != null && rez != self.rez){
        self.text= text;
        self.rez = rez;
        self.icon = lr(rez);
      }
    }


  }
}
