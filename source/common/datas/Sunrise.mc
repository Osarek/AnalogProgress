class Sunrise extends Datas {
  static const CODE = 52;
  function initialize() {
    Datas.initialize(Rez.Drawables.sunrise, "SRISE","Sunrise");
  }

  function getString() as $.Toybox.Lang.String {
    if (!(Toybox has :Weather)) {
      return "N/A";
    }
    return MyWeather.getTodaySunriseString();
  }
}
