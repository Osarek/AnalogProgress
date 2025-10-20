

class Sunset extends Datas{
    static const CODE=53;
    function initialize() {
        Datas.initialize(Rez.Drawables.sunset,"SSET","Sunset");        
    }

    function getString() as $.Toybox.Lang.String { 
         if (!(Toybox has :Weather)) {
      return "N/A";
    }        
        return  MyWeather.getTodaySunsetString();
    }
}