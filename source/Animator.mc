import Toybox.Lang;

class Animator {
  var fps = 24;
  var currentTimerCounter = 0.0;
  // var totalTimerCounter = 50.0;
  var maxTimerCounter = 15.0;
  
  var myTimer = new Timer.Timer();
  var runned= false;
  var ended = false;




  function getTimerMs() {
    return 1000 / fps;
  }

  function getProgress() as Number{
    if (currentTimerCounter >= maxTimerCounter){
      return 100;
    }else{
    return currentTimerCounter * 100 / maxTimerCounter;
    }
  }
}