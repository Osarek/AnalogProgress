class Status extends Datas {
  static const CODE = 6;
  function initialize() {
    Datas.initialize(Rez.Drawables.phone_off, "STAT","Status");
  }

  function prependIcon() {
    return false;
  }

  function refreshData() {
    var rez = null;

    if (System.getDeviceSettings().phoneConnected) {
      rez = Rez.Drawables.phone_on;
    } else {
      rez = Rez.Drawables.phone_off;
    }

    if (self.rez != null && rez != self.rez) {
      self.rez = rez;
      self.icon = lr(rez);
    }
  }

  function getString() as $.Toybox.Lang.String {
    return "# ";
  }
}
