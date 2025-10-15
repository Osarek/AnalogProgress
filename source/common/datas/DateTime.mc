import Toybox.Application;
import Toybox.Lang;
import Toybox.Time;

class Date extends Datas {
  static const DDMM = 0;
  static const MMDD = 1;

  function initialize() {
    Datas.initialize(null, "");
  }
  function prependIcon() {
    return false;
  }
}

class DateText extends Date {
  static const CODE = 20;

  function initialize() {
    Date.initialize();
  }

  function getString() as $.Toybox.Lang.String {
    // Icons and datas on left

    var now = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    var date;
    var sep = " ";

    if ((Properties.getValue("dateformat") as Number) == DDMM) {
      date = now.day_of_week + sep + now.day + " " + now.month;
    } else {
      date = now.day_of_week + sep + now.month + " " + now.day;
    }
    return date;
  }
}

class DateNumber extends Date {
  static const CODE = 21;

  function initialize() {
    Date.initialize();
  }

  function getString() as $.Toybox.Lang.String {
    // Icons and datas on left

    var now = Gregorian.info(Time.now(), Time.FORMAT_SHORT);

    if ((Properties.getValue("dateformat") as Number) == DDMM) {
      return now.day.format("%02d") + "/" + now.month.format("%02d");
    } else {
      return now.month.format("%02d") + "/" + now.day.format("%02d");
    }
  }
}


