import Toybox.Lang;
import Toybox.System;

class Factory {
  static var classes = [
    Datas,
    // Data time
    DateText,
    DateNumber,
    HourMin,
    Seconds,
    Hour12,
    Hour24,
    Minute,
    SecondsLeadingZero,

    // Activity info Garmin connect
    Steps,
    HeartRate,
    SPO2,
    FloorClimbedDay,
    FloorClimbedDayGoal,
    StressScore,
    TimeToRecovery,
    ActiveMinuteDay,
    ActiveMinuteWeek,
    ActiveMinuteWeekGoal,
    Calories,
    BodyBat,

    //SPort

    RunningThisWeek,
    RunningThisMonth,
    RunningThisWeekMonth,

    CustoSport1ThisWeekMonth,
    CustoSport1ThisMonth,
    CustoSport1ThisWeek,

     CustoSport2ThisWeekMonth,
    CustoSport2ThisMonth,
    CustoSport2ThisWeek,

    // SYSTEOM
    Battery,
    BatteryDays,
    BatteryPercentDays,
    Status,

    //weather

    Sunrise,
    SunriseSunset,
    Sunset,
    Temperature,

    WeatherData,
    WeatherTemperature,

    //DEbuge

    Debug,
    MemoryUsedPercent,
    MemoryUsed,
    Memory,
    ElapseTime

  ];

  static function CreateData(code as Number) as Datas? {
    if (code >0){
    for (var i = 0; i < classes.size(); i++) {
      if (code == classes[i].CODE) {
        return new classes[i]();
      }
    }
    }

    System.println("!!!  No data for code " + code);
    return null; // Or throw an error if preferred
  }
}
