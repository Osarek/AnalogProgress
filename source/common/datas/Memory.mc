import Toybox.Lang;

class Memory extends Datas {
    static const CODE=901;

  function initialize() {
    Datas.initialize(null, "MEMU");
  }

  function getString() as String {
     if (!(Toybox.System.Stats has :usedMemory)) {
      return "N/A";
    }
    return System.getSystemStats().usedMemory/1024 +"k" ;
  }  
}

class MemoryUsed extends Datas {
    static const CODE=903;

  function initialize() {
    Datas.initialize(null, "MEM");
  }

  function getString() as String {
      if (!(Toybox.System.Stats has :usedMemory)) {
      return "N/A";
    }
    return System.getSystemStats().usedMemory/1024  + "/"+ System.getSystemStats().totalMemory/1024  ;
  }  
}


class MemoryUsedPercent extends Datas {
    static const CODE=902;

  function initialize() {
    Datas.initialize(null, "MEM");
  }

  function getString() as String {
     if (!(Toybox.System.Stats has :usedMemory)) {
      return "N/A";
    }
    return 100*System.getSystemStats().usedMemory  / System.getSystemStats().totalMemory +"%" ;
  }  
}
