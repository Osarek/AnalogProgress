import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class Datas {
  const CODE=0;
  hidden var icon as BitmapResource?;
  hidden var rez as $.Toybox.Lang.ResourceId?;
  hidden var label as String?;
  hidden var longLabel as String?;

  function initialize(rez as $.Toybox.Lang.ResourceId?, label as String, longLabel as String) {
    self.rez = rez;
    if (rez != null) {
      self.icon = lr(rez);
    }
    self.label = label;
    self.longLabel = longLabel;
  }

  function canBeBuffered() as Boolean{
    return true;
  }
  function hasIcons(){
    return self.icon != null;
  }

  function prependIcon() {
    return true;
  }

  function hasProgress(){
    return false;
  }
  function getMax(){
    return 100;
  }
  function getMin(){
    return 0;
  }

  function getNumber(){
    return 100;
  }

   

  function refreshData() {}

  function getString() as String {
    return "TODO";
  }

  function getLabel() as String? {
    return label;
  }
    function getLongLabel() as String? {
    return longLabel;
  }
  function getIcon() as BitmapResource {
    return icon;
  }

  function lr(
    rez as $.Toybox.Lang.ResourceId
  ) as $.Toybox.Application.ResourceType or
    $.Toybox.Application.ResourceReferenceType {
    return Application.loadResource(rez);
  }

  
}
