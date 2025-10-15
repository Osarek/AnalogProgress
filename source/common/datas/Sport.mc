import Toybox.UserProfile;
import Toybox.System;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Activity;
import Toybox.Application;

class Sport extends Datas {
  // var refreshDuration = new Time.Duration(Gregorian.SECONDS_PER_HOUR);
  var refreshDuration = new Time.Duration(2 * Gregorian.SECONDS_PER_HOUR);
  var refreshTime = null;
  var lastValue = "N/A";
  var sportType = Activity.SPORT_INVALID;
  var dataType = 0;
  static var activities = null;
  var initialized = false;
  function initialize(
    rez as $.Toybox.Lang.ResourceId?,
    label as String,
    sportType as Activity.Sport,
    dataType as Number
  ) {
    Datas.initialize(rez, label);
    self.sportType = sportType;
    self.dataType = dataType;

    if (activities == null && UserProfile has :getUserActivityHistory) {
      var userActivityIterator = UserProfile.getUserActivityHistory();
      var sample = userActivityIterator.next(); // get the user activity data
      var from = getFirstDayOfMonth();
      activities = [];
      while (sample != null) {
        if (sample.startTime.greaterThan(from)) {
          activities.add(sample);
        }
        sample = userActivityIterator.next();
      }
    }
  }

  function getSportData(from as Time.Moment) as Number {
    var result = 0;
    // get a UserActivityHistoryIterator object
    if (activities == null) {
      // no right for activities
      return -1;
    }

    // System.println("getSportData from:" + from.value());

    Common.additionalDebug = 0;
    var count = 0;

    // var clockTime = System.getClockTime();
    // var start = System.getTimer();
    // System.println(("from" + from.value()));
    // while (sample != null) {

    for (var i = 0; i < activities.size(); i++) {
      var sample = activities[i];
      // count++;
      // System.println(("Sample startime" + sample.startTime.value()));

      // System.println(
      //   "start: " +
      //     sample.startTime.value() +
      //     " distance: " +
      //     sample.distance +
      //     " duration: " +
      //     sample.duration.value()
      // );
      if (sample.type == self.sportType && sample.startTime.greaterThan(from)) {
        if (isDistance()) {
          result += sample.distance;
        } else if (isDuration() && sample.duration != null) {
          result += sample.duration.value();
        }
      }
      // sample = userActivityIterator.next();
    }

    // Common.additionalDebug =
    //   "____" + count + ":" + (System.getTimer() - start) + "ms";
    return result;
  }

  // function doRefresh() as Boolean {
  //   if (
  //     (UserProfile has :getUserActivityHistory && refreshTime == null) ||
  //     refreshTime.add(refreshDuration).lessThan(Time.now())
  //   ) {
  //     refreshTime = Time.now();
  //     return true;
  //   }
  //   return false;
  // }

  function distanceToString(distance as Number, withUnit as Boolean) as String {
    var unit;
    var ratio;
    var limitNoFormat = null;
    var format = null;
    var formatDecimal = "%0.1f";
    switch (self.dataType) {
      case 1: //km / miles
        if (System.getDeviceSettings().distanceUnits == System.UNIT_METRIC) {
          ratio = 0.001;
          unit = "km";
          limitNoFormat = 10;
          format = formatDecimal;
        } else {
          ratio = 0.00062136;
          unit = "mi";
          limitNoFormat = 10;
          format = formatDecimal;
        }

        break;

      case 2: //m
        if (System.getDeviceSettings().distanceUnits == System.UNIT_METRIC) {
          ratio = 1;
          unit = "m";
        } else {
          ratio = 1.09361;
          unit = "yds";
        }
        break;

      default:
        ratio = 1;
        unit = "m";
        break;
    }

    distance = distance * ratio;
    var result = "N/A";
    if (
      format != null &&
      limitNoFormat != null &&
      distance < limitNoFormat &&
      distance - distance.toNumber().toLong() != 0
    ) {
      result = distance.format(format) + (withUnit ? unit : "");
    } else {
      result = distance.toNumber() + (withUnit ? unit : "");
    }

    return result;
  }

  function durationToString(duration as Number, withUnit as Boolean) as String {
    if (self.dataType == 3) {
      return (
        (duration / Gregorian.SECONDS_PER_HOUR).toNumber() +
        (withUnit ? "h" : "")
      );
    } else if (self.dataType == 4) {
      return (
        (duration / Gregorian.SECONDS_PER_MINUTE).toNumber() +
        +(withUnit ? "min" : "")
      );
    }
    return "N/A";
  }

  function getFirstDayOfWeek() as Time.Moment {
    var now = Gregorian.info(Time.today(), Time.FORMAT_SHORT);
    var dow = now.day_of_week;
    if (
      System.getDeviceSettings().firstDayOfWeek == Time.Gregorian.DAY_SUNDAY
    ) {
      dow -= 0;
    } else if (
      System.getDeviceSettings().firstDayOfWeek == Time.Gregorian.DAY_SATURDAY
    ) {
      dow += 1;
    } else if (
      System.getDeviceSettings().firstDayOfWeek == Time.Gregorian.DAY_MONDAY
    ) {
      dow -= 1;
      if (dow == 0) {
        dow = 7;
      }
    }

    var duration = new Time.Duration(Gregorian.SECONDS_PER_DAY * (dow - 1));
    return Time.today().subtract(duration);
  }

  function getFirstDayOfMonth() as Time.Moment {
    var now = Gregorian.info(Time.today(), Time.FORMAT_SHORT);
    var duration = new Time.Duration(Gregorian.SECONDS_PER_DAY * (now.day - 1));

    return Time.today().subtract(duration);
  }

  function getSportFromInt(s as Number) as Activity.Sport {
    switch (s) {
      case Activity.SPORT_GENERIC:
        return Activity.SPORT_GENERIC;
      case Activity.SPORT_RUNNING:
        return Activity.SPORT_RUNNING;
      case Activity.SPORT_CYCLING:
        return Activity.SPORT_CYCLING;
      case Activity.SPORT_TRANSITION:
        return Activity.SPORT_TRANSITION;
      case Activity.SPORT_FITNESS_EQUIPMENT:
        return Activity.SPORT_FITNESS_EQUIPMENT;
      case Activity.SPORT_SWIMMING:
        return Activity.SPORT_SWIMMING;
      case Activity.SPORT_BASKETBALL:
        return Activity.SPORT_BASKETBALL;
      case Activity.SPORT_SOCCER:
        return Activity.SPORT_SOCCER;
      case Activity.SPORT_TENNIS:
        return Activity.SPORT_TENNIS;
      case Activity.SPORT_AMERICAN_FOOTBALL:
        return Activity.SPORT_AMERICAN_FOOTBALL;
      case Activity.SPORT_TRAINING:
        return Activity.SPORT_TRAINING;
      case Activity.SPORT_WALKING:
        return Activity.SPORT_WALKING;
      case Activity.SPORT_CROSS_COUNTRY_SKIING:
        return Activity.SPORT_CROSS_COUNTRY_SKIING;
      case Activity.SPORT_ALPINE_SKIING:
        return Activity.SPORT_ALPINE_SKIING;
      case Activity.SPORT_SNOWBOARDING:
        return Activity.SPORT_SNOWBOARDING;
      case Activity.SPORT_ROWING:
        return Activity.SPORT_ROWING;
      case Activity.SPORT_MOUNTAINEERING:
        return Activity.SPORT_MOUNTAINEERING;
      case Activity.SPORT_HIKING:
        return Activity.SPORT_HIKING;
      case Activity.SPORT_MULTISPORT:
        return Activity.SPORT_MULTISPORT;
      case Activity.SPORT_PADDLING:
        return Activity.SPORT_PADDLING;
      case Activity.SPORT_FLYING:
        return Activity.SPORT_FLYING;
      case Activity.SPORT_E_BIKING:
        return Activity.SPORT_E_BIKING;
      case Activity.SPORT_MOTORCYCLING:
        return Activity.SPORT_MOTORCYCLING;
      case Activity.SPORT_BOATING:
        return Activity.SPORT_BOATING;
      case Activity.SPORT_DRIVING:
        return Activity.SPORT_DRIVING;
      case Activity.SPORT_GOLF:
        return Activity.SPORT_GOLF;
      case Activity.SPORT_HANG_GLIDING:
        return Activity.SPORT_HANG_GLIDING;
      case Activity.SPORT_HORSEBACK_RIDING:
        return Activity.SPORT_HORSEBACK_RIDING;
      case Activity.SPORT_HUNTING:
        return Activity.SPORT_HUNTING;
      case Activity.SPORT_FISHING:
        return Activity.SPORT_FISHING;
      case Activity.SPORT_INLINE_SKATING:
        return Activity.SPORT_INLINE_SKATING;
      case Activity.SPORT_ROCK_CLIMBING:
        return Activity.SPORT_ROCK_CLIMBING;
      case Activity.SPORT_SAILING:
        return Activity.SPORT_SAILING;
      case Activity.SPORT_ICE_SKATING:
        return Activity.SPORT_ICE_SKATING;
      case Activity.SPORT_SKY_DIVING:
        return Activity.SPORT_SKY_DIVING;
      default:
        // a fallback in case of unknown integer
        return Activity.SPORT_GENERIC;
    }
  }

  function isDuration() as Boolean {
    return self.dataType == 3 || self.dataType == 4;
  }
  function isDistance() as Boolean {
    return self.dataType == 1 || self.dataType == 2;
  }
  function getRezFromSport(
    sport as Activity.Sport,
    sportNo as Number
  ) as $.Toybox.Lang.ResourceId {
    switch (sport) {
      case Activity.SPORT_RUNNING:
        return Rez.Drawables.running;
      case Activity.SPORT_SWIMMING:
        return Rez.Drawables.swimming;
      case Activity.SPORT_CYCLING:
        return Rez.Drawables.cycling;

      default:
        return sportNo == 1 ? Rez.Drawables.sport1 : Rez.Drawables.sport2;
    }
  }
}

class SportThisWeek extends Sport {
  function initialize(
    rez as $.Toybox.Lang.ResourceId?,
    label as String,
    sportType as Activity.Sport,
    dataType as Number
  ) {
    Sport.initialize(rez, label, sportType, dataType);
  }

  function getString() as String {
     if (initialized) {
      return lastValue;
    }

    // if (doRefresh()) {
    var total = getSportData(getFirstDayOfWeek());
        initialized = true;

    if (total == -1 ) {

      return lastValue;
    }
    if (self.isDistance()) {
      lastValue = distanceToString(total as Number, true);
    } else if (self.isDuration()) {
      lastValue = durationToString(total as Number, true);
    }
    // }
    return lastValue;
  }
}

class SportThisMonth extends Sport {
  function initialize(
    rez as $.Toybox.Lang.ResourceId?,
    label as String,
    sportType as Activity.Sport,
    dataType as Number
  ) {
    Sport.initialize(rez, label, sportType, dataType);
  }

  function getString() as String {

     if (initialized) {
      return lastValue;
    }

    // if (doRefresh()) {
    System.println(refreshTime == null ? "" : refreshTime.value());

    var total = getSportData(getFirstDayOfMonth());
        initialized = true;
    if (total == -1 || initialized) {
      

      return lastValue;
    }

    if (self.isDistance()) {
      lastValue = distanceToString(total, true);
    } else if (self.isDuration()) {
      lastValue = durationToString(total, true);
    }
    
    // }
    return lastValue;
  }
}

class SportThisWeekMonth extends Sport {
  var week, month;
  function initialize(
    rez as $.Toybox.Lang.ResourceId?,
    label as String,
    sportType as Activity.Sport,
    dataType as Number
  ) {
    Sport.initialize(rez, label, sportType, dataType);
    week = new SportThisWeek(rez, label, sportType, dataType);
    month = new SportThisMonth(null, "", sportType, dataType);
  }

  function getString() as String {
    // if (doRefresh()) {
    if (initialized) {
      return lastValue;
    }

    var totalW = week.getSportData(getFirstDayOfWeek());
    var totalM = month.getSportData(getFirstDayOfMonth());
    initialized = true;

    if (totalW == -1) {
      return lastValue;
    }

    if (self.isDistance()) {
      lastValue = distanceToString(totalW, false);
      lastValue = lastValue + "/" + distanceToString(totalM, true);
    } else if (self.isDuration()) {
      lastValue = durationToString(totalW, false);
      lastValue = lastValue + "/" + durationToString(totalM, true);
    }
    initialized = true;
    // }
    return lastValue;
  }
}

class RunningThisWeek extends SportThisWeek {
  static const CODE = 201;
  function initialize() {
    SportThisWeek.initialize(
      Rez.Drawables.running,
      "R",
      Activity.SPORT_RUNNING,
      1
    );
  }
}

class RunningThisMonth extends SportThisMonth {
  static const CODE = 202;
  function initialize() {
    SportThisMonth.initialize(
      Rez.Drawables.running,
      "R",
      Activity.SPORT_RUNNING,
      1
    );
  }
}

class RunningThisWeekMonth extends SportThisWeekMonth {
  static const CODE = 203;

  function initialize() {
    SportThisWeekMonth.initialize(
      Rez.Drawables.running,
      "R",
      Activity.SPORT_RUNNING,
      1
    );
  }
}

class CustoSport1ThisWeek extends SportThisWeek {
  static const CODE = 291;
  function initialize() {
    var sport = getSportFromInt(Properties.getValue("custoSport1"));

    SportThisWeek.initialize(
      getRezFromSport(sport, 1),
      "",

      sport,
      Properties.getValue("custoSport1Data") as Number
    );
  }
}

class CustoSport1ThisMonth extends SportThisMonth {
  static const CODE = 292;
  function initialize() {
    var sport = getSportFromInt(Properties.getValue("custoSport1"));
    SportThisMonth.initialize(
      getRezFromSport(sport, 1),
      "",
      sport,
      Properties.getValue("custoSport1Data") as Number
    );
  }
}

class CustoSport1ThisWeekMonth extends SportThisWeekMonth {
  static const CODE = 293;

  function initialize() {
    var sport = getSportFromInt(Properties.getValue("custoSport1"));

    SportThisWeekMonth.initialize(
      getRezFromSport(sport, 1),
      "",
      sport,
      Properties.getValue("custoSport1Data") as Number
    );
  }
}

class CustoSport2ThisWeek extends SportThisWeek {
  static const CODE = 281;
  function initialize() {
    var sport = getSportFromInt(Properties.getValue("custoSport2"));

    SportThisWeek.initialize(
      getRezFromSport(sport, 2),
      "",
      sport,
      Properties.getValue("custoSport2Data") as Number
    );
  }
}

class CustoSport2ThisMonth extends SportThisMonth {
  static const CODE = 282;
  function initialize() {
    var sport = getSportFromInt(Properties.getValue("custoSport2"));

    SportThisMonth.initialize(
      getRezFromSport(sport, 2),
      "",
      sport,
      Properties.getValue("custoSport2Data") as Number
    );
  }
}

class CustoSport2ThisWeekMonth extends SportThisWeekMonth {
  static const CODE = 283;

  function initialize() {
    var sport = getSportFromInt(Properties.getValue("custoSport2"));

    SportThisWeekMonth.initialize(
      getRezFromSport(sport, 2),
      "",
      sport,
      Properties.getValue("custoSport2Data") as Number
    );
  }
}
