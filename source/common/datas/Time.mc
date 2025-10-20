import Toybox.Application;

class Time extends Datas {
  function initialize() {
    Datas.initialize(null, "","");
  }

  function prependIcon() {
    return false;
  }
}

class HourMin extends Time {
  static const CODE = 30;
  function initialize() {
    Time.initialize();
  }

  function getString() as $.Toybox.Lang.String {
    // Icons and datas on left

    var timeFormat = "$1$:$2$";
    var clockTime = System.getClockTime();
    var hours = clockTime.hour;
    var am = hours >= 12 ? "PM" : "AM";
    if (!System.getDeviceSettings().is24Hour) {
      if (hours > 12) {
        hours = hours - 12;
      } else if (hours == 0) {
        hours = 12;
      }
    }

    var timeString = Lang.format(timeFormat, [
      hours,
      clockTime.min.format("%02d"),
    ]);

    if (!System.getDeviceSettings().is24Hour) {
      timeString += "" + am;
    }

    return timeString;
  }
}

class Seconds extends Time {
  static const CODE = 31;
  function initialize() {
    Time.initialize();
    label = "SEC";
  }

  function canBeBuffered() as $.Toybox.Lang.Boolean {
    return false;
  }

  function getString() as $.Toybox.Lang.String {
    // Icons and datas on left
    return "" + System.getClockTime().sec;
  }

  function hasProgress() {
    return true;
  }
  function getMax() {
    return 60;
  }

  function getNumber() {
    return System.getClockTime().sec;
  }
}

class SecondsLeadingZero extends Seconds {
  static const CODE = 32;
  function initialize() {
    Seconds.initialize();
  }

  function getString() as $.Toybox.Lang.String {
    // Icons and datas on left
    return "" + System.getClockTime().sec.format("%02d");
  }
}

class Minute extends Time {
  static const CODE = 33;
  function initialize() {
    Time.initialize();
    label = "MIN";
  }

  function canBeBuffered() as $.Toybox.Lang.Boolean {
    return false;
  }

  function getString() as $.Toybox.Lang.String {
    // Icons and datas on left
    return "" + System.getClockTime().min;
  }

  function hasProgress() {
    return true;
  }
  function getMax() {
    return 60;
  }

  function getNumber() {
    return System.getClockTime().min;
  }
}

class Hour12 extends Time {
  static const CODE = 34;
  function initialize() {
    Time.initialize();
    label = "HOUR";
  }

  function canBeBuffered() as $.Toybox.Lang.Boolean {
    return false;
  }

  function getString() as $.Toybox.Lang.String {
    // Icons and datas on left
    return "" + System.getClockTime().hour;
  }

  function hasProgress() {
    return true;
  }
  function getMax() {
    return 12;
  }

  function getNumber() {
     var hours = System.getClockTime().hour;
    if (hours > 12) {
      hours = hours - 12;
    } else if (hours == 0) {
      hours = 12;
    }

    return hours;
  }
}

class Hour24 extends Hour12 {
  static const CODE = 35;
  function initialize() {
    Hour12.initialize();
  }
  function hasProgress() {
    return true;
  }
  function getMax() {
    return 24;
  }

  function getNumber() {
       return System.getClockTime().hour;

  }
}
