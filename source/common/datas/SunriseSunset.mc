class SunriseSunset extends Datas {
  static const CODE = 54;
  function initialize() {
    Datas.initialize(Rez.Drawables.sunrise_sunset, "SUN","SunRise/Set");
  }
  function prependIcon() {
    return false;
  }

  function getString() as $.Toybox.Lang.String {
     if (!(Toybox has :Weather)) {
      return "N/A";
    }
    return (
      MyWeather.getTodaySunriseString() +
      " # " +
      MyWeather.getTodaySunsetString()
    );
  }
}
