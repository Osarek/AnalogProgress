import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class AsapView extends WatchUi.WatchFace {
  function initialize() {
    WatchFace.initialize();
    // animator = new Animator();
    MyWeather.registerCurrent = true;
    common = new Common();

    // Radius: all = baseRadius at progress = 0
    // At 100, each gets a different final radius
  }

  //bitmaps
  // var hour;

  // var minute,
  // var sec;
  var mark;
  var fonts = {};

  var hourbuf, minutebuf, secondbuf, hourBuffText, minuteBuffText;
  var lastHourData, lastMinuteData, lastSecondData;
  //
  const DDMM = 0;
  const MMDD = 1;

  var common;

  function loadProperties() as Void {
    mark = null;
    minutebuf = null;
    minuteBuffText = null;
    hourbuf = null;
    hourBuffText = null;
    secondbuf = null;

    //    sec = Application.loadResource(Rez.Drawables.sec_white) as BitmapResource;

    // hour = Application.loadResource(Rez.Drawables.hour_white) as BitmapResource;

    // minute =
    //   Application.loadResource(Rez.Drawables.minute_white) as BitmapResource;

    dataMin = Factory.CreateData(Properties.getValue("mindata") as Number);
    dataHour = Factory.CreateData(Properties.getValue("hourdata") as Number);
    dataSec = Factory.CreateData(Properties.getValue("secdata") as Number);
    fonts[10] = Application.loadResource(Rez.Fonts.courier_10);
    fonts[16] = Application.loadResource(Rez.Fonts.courier_16);
    fonts[20] = Application.loadResource(Rez.Fonts.courier_20);
    fonts[22] = Application.loadResource(Rez.Fonts.courier_22);
    fonts[24] = Application.loadResource(Rez.Fonts.courier_24);

    // dataMin = new Seconds();
    // dataHour = new Seconds();
    // dataSec = new Seconds();

    // common.sideTextColor = config[:sidetextColor];
    // common.backgroundColor = config[:backgroundColor];
    // common.sideTextBackgroundColor = config[:sidetextBackgroundColor];

    hourThickness = Properties.getValue("hourThickness");
    minuteThickness = Properties.getValue("minuteThickness");
    hourBorderThickness = Properties.getValue("hourBorderThickness");
    minuteBorderThickness = Properties.getValue("minuteBorderThickness");

    secThickness = Properties.getValue("secThickness");
    baseThickness = Properties.getValue("baseThickness");
    squareTick = Properties.getValue("squareTick");
    squareFive = Properties.getValue("squareFive");

    common.loadProperties();
  }

  var xCenter, yCenter;
  var xform, xformMin, xformSec;
  var xMark, yMark;

  var screenWidth = Toybox.System.getDeviceSettings().screenWidth;
  var padding = (screenWidth / 30).toNumber();
  var dataMin;
  var dataHour;
  var dataSec;
  var hourThickness = 8;
  var minuteThickness = 8;
  var hourBorderThickness = 2;
  var minuteBorderThickness = 2;
  var secThickness = 3;
  var baseThickness = 2;
  var squareTick = 2;
  var squareFive = 4;
  var handLength = (screenWidth / 2 - 3 * padding) / (2).toNumber();
  var startHour = screenWidth / 2 + padding;
  var startMinute = startHour + handLength + padding;
  var startSeconds = screenWidth / 2 - padding;
  var secondsLength = screenWidth / 2;

  var lastHourFlip = false;
  var lastMinuteFlip = false;

  var tickModeHour = false;
  var tickModeMin = false;

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));

    common.onLayout(dc);
    xCenter = dc.getWidth() / 2;
    yCenter = dc.getHeight() / 2;
  }

  function onUpdate(dc as Dc) as Void {
    if (mark == null) {
      // mark = Application.loadResource(Rez.Drawables.mark_mix) as BitmapResource;
      // if (Properties.getValue("calcMark")) {
      mark = createMark(dc);
      // }
    }
    var start = System.getTimer();

    // System.println(fib);
    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);

    // MARKS

    dc.drawBitmap2(0, 0, mark, {
      :tintColor => Properties.getValue("MarkColor"),
      //:transform => markform,
    });

    // HANDS

    var minuteFlip = false;
    var hourFlip = false;

    var angleHour =
      -90 +
      ((System.getClockTime().hour % 12) * 360) / 12 +
      (System.getClockTime().min * 360) / (60 * 12); //+ clockTime.sec * maxSlot;

    var angleMin =
      -90 +
      (System.getClockTime().min * 360) / 60 +
      (System.getClockTime().sec * 360) / (60 * 60); //+ clockTime.sec * maxSlot;

    xform = new AffineTransform();
    if (
      (System.getClockTime().hour < 12 && System.getClockTime().hour >= 6) ||
      System.getClockTime().hour >= 18
    ) {
      hourFlip = true;
      angleHour -= 180;
    }
    xform.rotate(Math.toRadians(angleHour));

    xformMin = new AffineTransform();
    if (System.getClockTime().min >= 30) {
      minuteFlip = true;
      angleMin -= 180;
    }

    xformMin.rotate(Math.toRadians(angleMin));

    var AltModHour = 0;
    var AltModMin = 0;
    if (
      Properties.getValue("SwitchMode") != 0 &&
      System.getClockTime().sec % Properties.getValue("SwitchMode") == 0
    ) {
      minuteBuffText = null;
      hourBuffText = null;

      tickModeMin = !tickModeMin;
      tickModeHour = !tickModeHour;

      if (Properties.getValue("dataHourLabelMode") == 1) {
        if (tickModeHour) {
          AltModHour = 1;
        }
      } else if (Properties.getValue("dataHourLabelMode") == 2) {
        if (tickModeHour) {
          AltModHour = -1;
        }
      }

      if (Properties.getValue("dataMinLabelMode") == 1) {
        if (tickModeMin) {
          AltModMin = 1;
        }
      } else if (Properties.getValue("dataMinLabelMode") == 2) {
        if (tickModeMin) {
          AltModMin = -1;
        }
      }
    }

    //MINUTES

    var minuteHandColor = Properties.getValue("minuteHandColor");

    var hourHandColor = Properties.getValue("hourHandColor");
    var secHandColor = Properties.getValue("secHandColor");

    if (minuteHandColor != 0x000001) {
      if (dataMin != null && lastMinuteData != dataMin.getNumber()) {
        minutebuf = null;
        lastMinuteData = dataMin.getNumber();
      }

      var xMinuteZero = xCenter - dc.getWidth() / 2;
      var yMinuteZero = yCenter - minuteThickness / 2;
      var minXY = common.getRotatedXY(
        xMinuteZero.toFloat(),
        yMinuteZero.toFloat(),
        xCenter,
        yCenter,
        angleMin
      );

      if (minutebuf == null || lastMinuteFlip != minuteFlip) {
        minutebuf = createBuffedHand(
          dc,
          minuteThickness,
          dataMin,
          startMinute,
          handLength,
          minuteBorderThickness,
          lastMinuteData,
          minuteFlip
        );
      }

      if (minuteBuffText == null || lastMinuteFlip != minuteFlip) {
        var mode =
          (Properties.getValue("dataMinLabelMode") as Number) + AltModMin;
        System.println("min:" + mode);
        minuteBuffText = createBuffedText(
          dc,
          minuteThickness,
          dataMin,
          startMinute,
          handLength,
          minuteBorderThickness,
          lastMinuteData,
          fonts[Properties.getValue("minuteFontSize")],
          minuteFlip,
          mode,
          Properties.getValue("dataMinLabelCusto")
        );
      }
      lastMinuteFlip = minuteFlip;

      dc.drawBitmap2(minXY[0], minXY[1], minutebuf, {
        :tintColor => minuteHandColor,
        :transform => xformMin,
      });
      dc.drawBitmap2(minXY[0], minXY[1], minuteBuffText, {
        :tintColor => minuteHandColor,
        :transform => xformMin,
      });
    }

    //HANDS
    if (hourHandColor != 0x000001) {
      if (dataHour != null && lastHourData != dataHour.getNumber()) {
        hourbuf = null;
        lastHourData = dataHour.getNumber();
      }

      var xImage = xCenter - dc.getWidth() / 2;
      var yImage = yCenter - hourThickness / 2;
      var hourXY = common.getRotatedXY(
        xImage.toFloat(),
        yImage.toFloat(),
        xCenter,
        yCenter,
        angleHour
      );

      if (hourbuf == null || lastHourFlip != hourFlip) {
        hourbuf = createBuffedHand(
          dc,
          hourThickness,
          dataHour,
          startHour,
          handLength,
          hourBorderThickness,
          lastHourData,
          hourFlip
        );
      }

      if (hourBuffText == null || lastHourFlip != hourFlip) {
        var mode =
          (Properties.getValue("dataHourLabelMode") as Number) + AltModHour;
        System.println("hour:" + mode);

        hourBuffText = createBuffedText(
          dc,
          hourThickness,
          dataHour,
          startHour,
          handLength,
          hourBorderThickness,
          lastHourData,
          fonts[Properties.getValue("hourFontSize")],
          hourFlip,
          mode,
          Properties.getValue("dataHourLabelCusto")
        );
      }

      lastHourFlip = hourFlip;

      dc.drawBitmap2(hourXY[0], hourXY[1], hourbuf, {
        :tintColor => hourHandColor,
        :transform => xform,
      });

      dc.drawBitmap2(hourXY[0], hourXY[1], hourBuffText, {
        :tintColor => hourHandColor,
        :transform => xform,
      });
    }

    var xSecZero = xCenter - dc.getWidth() / 2;
    var ySecZero = yCenter - secThickness / 2;
    if (
      (secHandColor != 0x000001 && !(common.inLowPower && common.canBurnIn)) ||
      !common.canBurnIn
    ) {
      var angleSec = -90 + (System.getClockTime().sec * 360) / 60;
      xformSec = new AffineTransform();
      xformSec.rotate(Math.toRadians(angleSec));
      var secXY = common.getRotatedXY(
        xSecZero.toFloat(),
        ySecZero.toFloat(),
        xCenter,
        yCenter,
        angleSec
      );

      if (dataSec != null && lastSecondData != dataSec.getNumber()) {
        secondbuf = null;
        lastSecondData = dataSec.getNumber();
      }

      if (secondbuf == null) {
        secondbuf = createBuffedHand(
          dc,
          secThickness,
          dataSec,
          startSeconds,
          secondsLength,
          0,
          lastSecondData,
          false
        );
      }

      dc.drawBitmap2(secXY[0], secXY[1], secondbuf, {
        :tintColor => secHandColor,
        :transform => xformSec,
      });

      dc.setColor(secHandColor, Graphics.COLOR_TRANSPARENT);
      dc.fillRoundedRectangle(
        dc.getWidth() / 2 - secThickness,
        dc.getHeight() / 2 - secThickness,
        secThickness * 2,
        secThickness * 2,
        secThickness
      );
    }
    Common.elaspedTimeOnUpdate = System.getTimer() - start;

    if (Properties.getValue("overlayComputation")) {
      dc.setColor(0xffffff, Graphics.COLOR_TRANSPARENT);
      dc.drawText(
        dc.getWidth() / 2,
        dc.getHeight() / 2,
        Graphics.FONT_XTINY,
        "H-" + common.elaspedTimeOnUpdate + "\n" + common.additionalDebug,
        Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
      );
    }
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  var myTimer = new Timer.Timer();

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {
    common.onExitSleep();
  }

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {
    common.onEnterSleep();
  }

  function getCross(
    pixForMax as Number,
    current as Number,
    data as Datas
  ) as Number {
    return (current * pixForMax) / (data.getMax() - data.getMin());
  }

  function createMark(dc as Dc) {
    var mark = Graphics.createBufferedBitmap({
      // create an off-screen buffer with a palette of four colors
      :width => dc.getWidth(),
      :height => dc.getHeight(),
    }).get();

    var big = null;
    if (squareFive != 0) {
      big = Graphics.createBufferedBitmap({
        // create an off-screen buffer with a palette of four colors
        :width => dc.getWidth(),
        :height => squareFive,
      }).get();
      var bigdc = big.getDc();

      bigdc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
      bigdc.clear();

      bigdc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

      bigdc.fillRectangle(0, 0, squareFive, squareFive);
    }
    var tick = null;
    if (squareTick != 0) {
      tick = Graphics.createBufferedBitmap({
        // create an off-screen buffer with a palette of four colors
        :width => dc.getWidth(),
        :height => squareTick,
      }).get();
      var tickdc = tick.getDc();
      tickdc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
      tickdc.clear();

      tickdc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

      tickdc.fillRectangle(0, 0, squareTick, squareTick);
    }
    for (var i = 0; i < 60; i++) {
      System.println(i);
      var angle = (i * 360) / 60;
      var form = new AffineTransform();
      form.rotate(Math.toRadians(angle));

      var xZero = 1;

      if (i % 5 == 0) {
        if (big != null) {
          var yZero = dc.getHeight() / 2 - squareFive / 2;
          var XY = common.getRotatedXY(
            xZero.toFloat(),
            yZero.toFloat(),
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            angle
          );
          mark.getDc().drawBitmap2(XY[0], XY[1], big, {
            :transform => form,
          });
        }
      } else {
        if (tick != null) {
          var yZero = dc.getHeight() / 2 - squareTick / 2;
          var XY = common.getRotatedXY(
            xZero.toFloat(),
            yZero.toFloat(),
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            angle
          );
          mark.getDc().drawBitmap2(XY[0], XY[1], tick, {
            :transform => form,
          });
        }
      }
    }
    return mark;
  }

  function createBuffedText(
    dc as Dc,
    buffHeight as Number,
    data as Datas?,
    startHand as Number,
    handLength as Number,
    borderThickness as Number,
    lastData as Number,
    font,
    flip as Boolean,
    labelMode as Number,
    labelCusto as String
  ) {
    var progress = handLength;
    if (data != null) {
      progress = getCross(handLength, lastData, data);
      System.println("progress " + progress);
    }
    var buff = Graphics.createBufferedBitmap({
      // create an off-screen buffer with a palette of four colors
      :width => dc.getWidth(),
      :height => buffHeight,
    }).get();

    var dcb = buff.getDc();
    dcb.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
    dcb.clear();
    dcb.setPenWidth(1);

    if (data != null && labelMode != 0) {
      var text = labelCusto;
      if (labelMode == 1 && labelCusto.length() == 0) {
        text = data.getLabel();
      } else if (labelMode == 2) {
        text = data.getNumber();
      }
      dcb.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      dcb.drawText(
        flipX(dc, startHand + handLength / 2, flip),
        buffHeight / 2,
        font,
        text,
        Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
      );
      dcb.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);

      var buffTextProgress = Graphics.createBufferedBitmap({
        // create an off-screen buffer with a palette of four colors
        :width => startHand + progress,
        :height => buffHeight,
      }).get();
      var dcbText = buffTextProgress.getDc();
      dcbText.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
      dcbText.clear();
      dcbText.setColor(
        Properties.getValue("BackgroundColor"),
        Graphics.COLOR_TRANSPARENT
      );
      dcbText.drawText(
        flip ? -handLength / 2 + progress : startHand + handLength / 2,
        buffHeight / 2,
        font,
        text,
        Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
      );

      dcb.drawBitmap(
        flip ? flipX(dc, startHand + progress, flip) : 0,
        0,
        buffTextProgress
      );
    }
    return buff;
  }

  function createBuffedHand(
    dc as Dc,
    buffHeight as Number,
    data as Datas?,
    startHand as Number,
    handLength as Number,
    borderThickness as Number,
    lastData as Number,
    flip as Boolean
  ) {
    var handThickness = buffHeight;
    //progress bar
    var progress = handLength;
    if (data != null) {
      progress = getCross(handLength, lastData, data);
      System.println("progress " + progress);
    }

    var buff = Graphics.createBufferedBitmap({
      // create an off-screen buffer with a palette of four colors
      :width => dc.getWidth(),
      :height => buffHeight,
    }).get();

    var dcb = buff.getDc();
    dcb.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
    dcb.clear();
    dcb.setPenWidth(1);

    //this is the bar from the center to the hand
    dcb.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
    if (startHand > dc.getHeight() / 2) {
      dcb.fillRectangle(
        dc.getWidth() / 2,
        dcb.getHeight() / 2 - baseThickness / 2,
        (flip ? -1 : 1) * (startHand - dc.getHeight() / 2 + 2),
        baseThickness
      );
    }

    dcb.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);

    drawProgress(dcb, startHand, handLength, handLength, handThickness, flip);
    dcb.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

    drawProgress(dcb, startHand, handLength, progress, handThickness, flip);

    return buff;
  }

  function flipX(dc as Dc, x as Number, flip as Boolean) {
    if (flip) {
      var res = dc.getWidth() - x;
      return res;
    }
    return x;
  }

  function drawProgress(
    dc as Dc,
    startHand as Number,
    handLength as Number,
    progress as Number,
    handThickness as Number,
    flip as Boolean
  ) {
    dc.setAntiAlias(true);
    // draw Half Circle

    var points = getCirclePoints(
      flipX(dc, startHand + handThickness / 2, flip),
      dc.getHeight() / 2,
      handThickness / 2,
      40,
      flip
        ? flipX(
            dc,
            min(startHand + progress, startHand + handThickness / 2),
            true
          )
        : 0,
      flip
        ? flipX(dc, 0, true)
        : min(startHand + progress, startHand + handThickness / 2)
    );
    if (points.size() > 0) {
      dc.fillPolygon(points as Array);
    }

    if (startHand + progress > startHand + handThickness / 2) {
      dc.fillRectangle(
        flipX(dc, startHand + handThickness / 2, flip),
        0,
        (flip ? -1 : 1) *
          min(progress - handThickness / 2, handLength - handThickness),
        handThickness
      );
    }

    if (startHand + handLength - handThickness / 2 < startHand + progress) {
      points = getCirclePoints(
        flipX(dc, startHand + handLength - handThickness / 2, flip),
        dc.getHeight() / 2,
        handThickness / 2,
        40,
        flip
          ? flipX(dc, startHand + progress, true)
          : startHand + handLength - handThickness / 2,
        flip
          ? flipX(dc, startHand + handLength - handThickness / 2, true)
          : startHand + progress
      );
      if (points.size() > 0) {
        dc.fillPolygon(points as Array);
      }
    }
  }
  function getCirclePoints(
    x as Number,
    y as Number,
    r as Number,
    numPoints as Number,
    minX as Number,
    maxX as Number
  ) as Lang.Array<Graphics.Point2D> {
    var points = [];
    var step = (2 * Math.PI) / numPoints;

    for (var i = 0; i < numPoints; i += 1) {
      var angle = i * step;
      var px = x + r * Math.cos(angle);
      var py = y + r * Math.sin(angle);

      // Create a pair [px, py]
      if (minX <= px.toNumber() && px.toNumber() <= maxX) {
        points.add([px.toNumber(), py.toNumber()]);
      }
    }

    return points;
  }

  function max(number1 as Number, number2 as Number) {
    if (number1 > number2) {
      return number1;
    } else {
      return number2;
    }
  }
  function min(number1 as Number, number2 as Number) {
    if (number1 < number2) {
      return number1;
    } else {
      return number2;
    }
  }
}
