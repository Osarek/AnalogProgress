import Toybox.Lang;

class Memory extends Datas {
    static const CODE=901;

  function initialize() {
    Datas.initialize(null, "MEMU","Mem Usage");
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
    Datas.initialize(null, "MEM","Mem Used");
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
    Datas.initialize(null, "MEM","Mem %");
  }

  function getString() as String {
     if (!(Toybox.System.Stats has :usedMemory)) {
      return "N/A";
    }
    return 100*System.getSystemStats().usedMemory  / System.getSystemStats().totalMemory +"%" ;
  }  
}
