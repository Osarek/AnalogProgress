class Steps extends Datas {
  static const CODE = 1;
  function initialize() {
    Datas.initialize(Rez.Drawables.step, "STP","STEPS");
  }

  function getString() as $.Toybox.Lang.String {
    var number = getNumber();
    if (number != -1) {
      return "N/A";
    }
    if (number < 1000) {
      number = "" + number;
    } else {
      number = "" + number / 1000 + "." + (number % 1000) / 100 + "k";
    }
    return number;
  }

  function hasProgress() {
    return true;
  }
  function getMax() {
    if (!(ActivityMonitor.Info has :stepGoal)) {
      return 0;
    }
    return Toybox.ActivityMonitor.getInfo().stepGoal;
  }

  function getNumber() {
    if (
      ActivityMonitor.Info has :steps &&
      Toybox.ActivityMonitor.getInfo().steps != null
    ) {
      return Toybox.ActivityMonitor.getInfo().steps;
    }
    return -1;
  }
}

class HeartRate extends Datas {
  static const CODE = 2;
  function initialize() {
    Datas.initialize(Rez.Drawables.heart, "HR","Heart Rate");
  }

  function canBeBuffered() as $.Toybox.Lang.Boolean {
    return false;
  }

  function getString() as $.Toybox.Lang.String {
    var number = getNumber();
    if (number != -1) {
      return "N/A";
    }
    return number + "";
  }

  function hasProgress() {
    return true;
  }
  function getMax() {
    return 180;
  }
  function getMin() {
    return 50;
  }

  function getNumber() {
    if (
      Toybox.Activity.Info has :currentHeartRate &&
      Toybox.Activity.getActivityInfo().currentHeartRate != null
    ) {
      return Toybox.Activity.getActivityInfo().currentHeartRate;
    } else {
      return -1;
    }
  }
}
class SPO2 extends Datas {
  static const CODE = 4;
  function initialize() {
    Datas.initialize(Rez.Drawables.o2, "Ox","Pulse Ox");
  }

  function getString() as $.Toybox.Lang.String {
    var number = getNumber();
    if (number != -1) {
      return "N/A";
    }
    return number + "%";
  }

  function hasProgress() {
    return true;
  }
  function getMax() {
    return 180;
  }
  function getMin() {
    return 70;
  }

  function getNumber() {
    if (
      !(Toybox.Activity.Info has :currentOxygenSaturation) &&
      Toybox.Activity.getActivityInfo().currentOxygenSaturation != null
    ) {
      return Toybox.Activity.getActivityInfo().currentOxygenSaturation;
    } else {
      return -1;
    }
  }
}

class FloorClimbedDay extends Datas {
  static const CODE = 100;
  function initialize() {
    Datas.initialize(Rez.Drawables.stair_up, "FL UP","Floors Up");
  }

  function getString() as $.Toybox.Lang.String {
    if (!(ActivityMonitor.Info has :floorsClimbed)) {
      return "N/A";
    }
    return "" + Toybox.ActivityMonitor.getInfo().floorsClimbed;
  }
}
class FloorClimbedDayGoal extends Datas {
  static const CODE = 101;
  function initialize() {
    Datas.initialize(Rez.Drawables.stair_up, "FL UP","Floors Up");
  }

  function getString() as $.Toybox.Lang.String {
    if (!(ActivityMonitor.Info has :floorsClimbed)) {
      return "N/A";
    }

    return (
      Toybox.ActivityMonitor.getInfo().floorsClimbed +
      "/" +
      Toybox.ActivityMonitor.getInfo().floorsClimbedGoal
    );
  }
}

class StressScore extends Datas {
  static const CODE = 102;
  function initialize() {
    Datas.initialize(Rez.Drawables.stress, "STRS","Stress");
  }

  function getString() as $.Toybox.Lang.String {
    var number = getNumber();
    if (number != -1) {
      return "N/A";
    }
    return number + "";
  }

  function hasProgress() {
    return true;
  }

  function getNumber() {
    if (
      ActivityMonitor.Info has :stressScore &&
      ActivityMonitor.getInfo().stressScore != null
    ) {
      return ActivityMonitor.getInfo().stressScore;
    } else {
      return -1;
    }
  }
}

class TimeToRecovery extends Datas {
  static const CODE = 103;
  function initialize() {
    Datas.initialize(Rez.Drawables.recoverytime, "RECTIME","Rec time");
  }

  function getString() as $.Toybox.Lang.String {
    var number = getNumber();
    if (number != -1) {
      return "N/A";
    }
    return number + "h";
  }

  function getMax() {
    return 30;
  }
  function getMin() {
    return 0;
  }

  function getNumber() {
    if (
      ActivityMonitor.Info has :timeToRecovery &&
      Toybox.ActivityMonitor.getInfo().timeToRecovery != null
    ) {
      if (Toybox.ActivityMonitor.getInfo().timeToRecovery > 30) {
        return 30;
      } else {
        return Toybox.ActivityMonitor.getInfo().timeToRecovery;
      }
    } else {
      return -1;
    }
  }
}

class ActiveMinuteDay extends Datas {
  static const CODE = 105;
  function initialize() {
    Datas.initialize(Rez.Drawables.activeminutes, "AMD","Int. Min. Day");
  }

  function getString() as $.Toybox.Lang.String {
    if (ActivityMonitor.Info has :activeMinutesDay) {
      return "D " + Toybox.ActivityMonitor.getInfo().activeMinutesDay.total;
    } else {
      return "N/A";
    }
  }
}
class ActiveMinuteWeek extends Datas {
  static const CODE = 106;
  function initialize() {
    Datas.initialize(Rez.Drawables.activeminutes, "AMW","Int. Min. Wk");
  }

  function getString() as $.Toybox.Lang.String {
    if (!(ActivityMonitor.Info has :activeMinutesWeek)) {
      return "N/A";
    }
    return "" + Toybox.ActivityMonitor.getInfo().activeMinutesWeek.total;
  }
}
class ActiveMinuteWeekGoal extends Datas {
  static const CODE = 107;
  function initialize() {
    Datas.initialize(Rez.Drawables.activeminutes, "AMW","Int. Min. Goal");
  }

  function getString() as $.Toybox.Lang.String {
    if (!(ActivityMonitor.Info has :activeMinutesWeek)) {
      return "N/A";
    }
    return (
      "" +
      Toybox.ActivityMonitor.getInfo().activeMinutesWeek.total +
      "/" +
      Toybox.ActivityMonitor.getInfo().activeMinutesWeekGoal
    );
  }
}

class Calories extends Datas {
  static const CODE = 108;
  function initialize() {
    Datas.initialize(Rez.Drawables.calories, "CAL","Calories");
  }

  function getString() as $.Toybox.Lang.String {
    if (!(ActivityMonitor.Info has :calories)) {
      return "N/A";
    }
    return "" + Toybox.ActivityMonitor.getInfo().calories;
  }
}

class BodyBat extends Datas {
  static const CODE = 109;
  function initialize() {
    Datas.initialize(Rez.Drawables.bodybat, "bbat" , "Body Bat");
  }

  function getString() as $.Toybox.Lang.String {
    var number = getNumber();
    if (number != -1) {
      return "N/A";
    }
    return number + "%";
  }

  function getNumber() {
    if (
      Toybox has :SensorHistory &&
      Toybox.SensorHistory has :getBodyBatteryHistory != null &&
      Toybox.ActivityMonitor.getInfo().timeToRecovery != null
    ) {
      var next = Toybox.SensorHistory.getBodyBatteryHistory({
        :period => 1,
      }).next();
      if (next != null) {
        if (next.data != null) {
          return next.data.toNumber();
        }
      }
    }
    return -1;
  }
}
