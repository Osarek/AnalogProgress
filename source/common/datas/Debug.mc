import Toybox.Lang;

class Debug extends Datas {
    static const CODE=999;

  function initialize() {
    Datas.initialize(null, "");
  }

  function getString() as String {
    return "DEBUG";
  }

  
}

class ElapseTime extends Datas {
    static const CODE=998;

  function initialize() {
    Datas.initialize(null, "");
  }

  function getString() as String {
    return Common.elaspedTimeOnUpdate+"ms";
  }

  
}



