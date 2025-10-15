import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Math;
using Toybox.Time.Gregorian;

class Common {
  static const charBaseWidth = 24;
  static const charBaseHeight = 24;

  static var elaspedTimeOnUpdate = 0;
  static var additionalDebug = "";

  var inLowPower = false;
  var canBurnIn = false;
  var doBuffer = false;
  static var isFirstDraw = true;
  var lastExitSleep = System.getTimer();
  var lastEnterSleep = System.getTimer();

  function initialize() {
    canBurnIn = false;
    if (Toybox.System.DeviceSettings has :requiresBurnInProtection) {
      canBurnIn = System.getDeviceSettings().requiresBurnInProtection;
    }
    // System.println("canBurnIn :" + canBurnIn);
  }

  function loadProperties() {
  

    cachedArcText = ({}) as Dictionary;
  }

  var r = 0 as Number;
  var xCenter = 0 as Number;
  var yCenter = 0 as Number;

  // var fonts = {} as Dictionary;
  var images = ({}) as Dictionary<BitmapResource>;

  function onLayout(dc as Dc) {
    // System.println("common.onlayout");
    r = (0.8 * dc.getWidth()) / 2;
    xCenter = dc.getWidth() / 2;
    yCenter = dc.getHeight() / 2;

    loadIconsBitmaps();
  }

  function clearIconsBitmals() {
    images = {};
  }

  function loadIconsBitmaps() {
    // System.println("common.loadIconsBitmaps");

    images = {};
  }
  var dataKey = [
    "___",
    "toprightsmall",
    "topright",
    "rightsmall",
    "bottomright",
    "bottomrightsmall",
    "bottom",
    "bottomleftsmall",
    "bottomleft",
    "leftsmall",
    "topleft",
    "topleftsmall",
    "top",
  ];

  var cachedArcText = ({}) as Dictionary;
  function onUpdate(dc) {
    // System.println("common.onUpdate");

    if (
      !Properties.getValue("ShowSideText") ||
      (inLowPower && canBurnIn) || delayExit != 0
    ) {
      return;
    }

    if (delay != 0) {
      delay--;
      return;
    }

    // System.println("done delayExit " + System.getTimer());

    var backgroundColor =
      Properties.getValue("SideTextBackgroundColor") as Number;

    if (backgroundColor == 0x000002) {
      backgroundColor =
        Properties.getValue("SideTextBackgroundColorTinted") as Number;
    }

    // if ((Properties.getValue("screen") as Number) == 2) {
    //   backgroundColor =
    //     Properties.getValue("SideTextBackgroundColor2") as Number;
    // }

    var isRound = dc.getWidth() == dc.getHeight();

    var ratio =
      (dc.getWidth() * (Properties.getValue("SideTextSize") as Number)) /
      100.0 /
      charBaseHeight;

    if (backgroundColor != 0x000001) {
      dc.setColor(backgroundColor, Graphics.COLOR_TRANSPARENT);

      dc.setPenWidth(charBaseHeight * ratio * 2);

      if (isRound) {
        if (Properties.getValue("SideTextBackgroundShape") == 1) {
          dc.drawArc(
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            dc.getWidth() / 2 - (charBaseHeight * ratio) / 2 + 1,
            Graphics.ARC_CLOCKWISE,
            0,
            0
          );
        }
      } else {
        dc.drawRectangle(
          (charBaseHeight * ratio) / 2 + 1,
          (charBaseHeight * ratio) / 2 + 1,
          dc.getWidth() - (2 * (charBaseHeight * ratio)) / 2 + 1,
          dc.getHeight() - (2 * (charBaseHeight * ratio)) / 2 + 1
        );
      }
      dc.setPenWidth(2);
    }

    var charBase = getBitmap('A');

    var offsetTop = (charBase.getHeight() * ratio * 3) / 4;

    var offsetSide = 45;
   
    isFirstDraw = false;
  }
  function getBitmap(onchar as Char) as BitmapResource {
    if (!images.hasKey(onchar)) {
      loadKey(onchar);
    }

    // if (images[onchar] != null) {
    return images[onchar];
    // } else {
    //   return images['-'];
    // }
  }

  function loadKey(onchar as Char) {
    // switch (onchar) {
    //   case 'A':
    //     images['A'] =
    //       Application.loadResource(Rez.Drawables.A) as BitmapResource;
    //     break;
    //   case 'B':
    //     images['B'] =
    //       Application.loadResource(Rez.Drawables.B) as BitmapResource;
    //     break;
    //   case 'C':
    //     images['C'] =
    //       Application.loadResource(Rez.Drawables.C) as BitmapResource;
    //     break;
    //   case 'D':
    //     images['D'] =
    //       Application.loadResource(Rez.Drawables.D) as BitmapResource;
    //     break;
    //   case 'E':
    //     images['E'] =
    //       Application.loadResource(Rez.Drawables.E) as BitmapResource;
    //     break;
    //   case 'F':
    //     images['F'] =
    //       Application.loadResource(Rez.Drawables.F) as BitmapResource;
    //     break;
    //   case 'G':
    //     images['G'] =
    //       Application.loadResource(Rez.Drawables.G) as BitmapResource;
    //     break;
    //   case 'H':
    //     images['H'] =
    //       Application.loadResource(Rez.Drawables.H) as BitmapResource;
    //     break;
    //   case 'I':
    //     images['I'] =
    //       Application.loadResource(Rez.Drawables.I) as BitmapResource;
    //     break;
    //   case 'J':
    //     images['J'] =
    //       Application.loadResource(Rez.Drawables.J) as BitmapResource;
    //     break;
    //   case 'K':
    //     images['K'] =
    //       Application.loadResource(Rez.Drawables.K) as BitmapResource;
    //     break;
    //   case 'L':
    //     images['L'] =
    //       Application.loadResource(Rez.Drawables.L) as BitmapResource;
    //     break;
    //   case 'M':
    //     images['M'] =
    //       Application.loadResource(Rez.Drawables.M) as BitmapResource;
    //     break;
    //   case 'N':
    //     images['N'] =
    //       Application.loadResource(Rez.Drawables.N) as BitmapResource;
    //     break;
    //   case 'O':
    //     images['O'] =
    //       Application.loadResource(Rez.Drawables.O) as BitmapResource;
    //     break;
    //   case 'P':
    //     images['P'] =
    //       Application.loadResource(Rez.Drawables.P) as BitmapResource;
    //     break;
    //   case 'Q':
    //     images['Q'] =
    //       Application.loadResource(Rez.Drawables.Q) as BitmapResource;
    //     break;
    //   case 'R':
    //     images['R'] =
    //       Application.loadResource(Rez.Drawables.R) as BitmapResource;
    //     break;
    //   case 'S':
    //     images['S'] =
    //       Application.loadResource(Rez.Drawables.S) as BitmapResource;
    //     break;
    //   case 'T':
    //     images['T'] =
    //       Application.loadResource(Rez.Drawables.T) as BitmapResource;
    //     break;
    //   case 'U':
    //     images['U'] =
    //       Application.loadResource(Rez.Drawables.U) as BitmapResource;
    //     break;
    //   case 'V':
    //     images['V'] =
    //       Application.loadResource(Rez.Drawables.V) as BitmapResource;
    //     break;
    //   case 'W':
    //     images['W'] =
    //       Application.loadResource(Rez.Drawables.W) as BitmapResource;
    //     break;
    //   case 'X':
    //     images['X'] =
    //       Application.loadResource(Rez.Drawables.X) as BitmapResource;
    //     break;
    //   case 'Y':
    //     images['Y'] =
    //       Application.loadResource(Rez.Drawables.Y) as BitmapResource;
    //     break;
    //   case 'Z':
    //     images['Z'] =
    //       Application.loadResource(Rez.Drawables.Z) as BitmapResource;
    //     break;
    //   // Digits
    //   case '0':
    //     images['0'] =
    //       Application.loadResource(Rez.Drawables._0) as BitmapResource;
    //     break;
    //   case '1':
    //     images['1'] =
    //       Application.loadResource(Rez.Drawables._1) as BitmapResource;
    //     break;
    //   case '2':
    //     images['2'] =
    //       Application.loadResource(Rez.Drawables._2) as BitmapResource;
    //     break;
    //   case '3':
    //     images['3'] =
    //       Application.loadResource(Rez.Drawables._3) as BitmapResource;
    //     break;
    //   case '4':
    //     images['4'] =
    //       Application.loadResource(Rez.Drawables._4) as BitmapResource;
    //     break;
    //   case '5':
    //     images['5'] =
    //       Application.loadResource(Rez.Drawables._5) as BitmapResource;
    //     break;
    //   case '6':
    //     images['6'] =
    //       Application.loadResource(Rez.Drawables._6) as BitmapResource;
    //     break;
    //   case '7':
    //     images['7'] =
    //       Application.loadResource(Rez.Drawables._7) as BitmapResource;
    //     break;
    //   case '8':
    //     images['8'] =
    //       Application.loadResource(Rez.Drawables._8) as BitmapResource;
    //     break;
    //   case '9':
    //     images['9'] =
    //       Application.loadResource(Rez.Drawables._9) as BitmapResource;
    //     break;

    //   case '%':
    //     images['%'] =
    //       Application.loadResource(Rez.Drawables.PERCENT) as BitmapResource;
    //     break;
    //   case '-':
    //     images['-'] =
    //       Application.loadResource(Rez.Drawables.DASH) as BitmapResource;
    //     break;
    //   case '+':
    //     images['+'] =
    //       Application.loadResource(Rez.Drawables.DASH) as BitmapResource; // (check: maybe should be PLUS instead of DASH?)
    //     break;
    //   case '°':
    //     images['°'] =
    //       Application.loadResource(Rez.Drawables.DEGREE) as BitmapResource;
    //     break;
    //   case '.':
    //     images['.'] =
    //       Application.loadResource(Rez.Drawables.POINT) as BitmapResource;
    //     break;
    //   case ':':
    //     images[':'] =
    //       Application.loadResource(Rez.Drawables.DEUXPOINTS) as BitmapResource;
    //     break;
    //   case '/':
    //     images['/'] =
    //       Application.loadResource(Rez.Drawables.SLASH) as BitmapResource;
    //     break;
    //   case ' ':
    //     images[' '] =
    //       Application.loadResource(Rez.Drawables.SPACE) as BitmapResource;
    //   case ' ':
    //     break;
    //   case '#':
    //     images['#'] =
    //       Application.loadResource(Rez.Drawables.SPACE) as BitmapResource;
    //     break;
    // }
  }

  var delay = 0;
  var delayExit = 0;
  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onExitSleep() as Void {
    lastExitSleep = Toybox.Time.now();

   

    inLowPower = false;
    onShow();
  }

  // onShow() is called when this View is brought to the foreground
  function onShow() {
    
  }
  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {
    lastEnterSleep = System.getTimer();
  }

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {
    onHide();
    inLowPower = true;
  }

  function darkenHex(hexColor as Number, factor as Float) as Number {
    // Extract RGB
    var r = (hexColor >> 16) & 0xff;
    var g = (hexColor >> 8) & 0xff;
    var b = hexColor & 0xff;

    // Calculate brightness (simple average, could also use weighted luminance)
    var brightness = (r + g + b) / 3.0;

    // Threshold: don’t darken if already too dark
    if (brightness < 40) {
      // tweak 40 → higher = more protective
      return hexColor; // already dark enough
    }

    // Apply factor
    r = (r * factor).toNumber();
    g = (g * factor).toNumber();
    b = (b * factor).toNumber();

    return (r << 16) | (g << 8) | b;
  }

  var bufferedDiags;
  function onAOD(
    dc as Dc,
    x as Number,
    y as Number,
    width as Number,
    height as Number
  ) {
    if ((canBurnIn && inLowPower) || delayExit != 0) {
      if (bufferedDiags == null) {
        bufferedDiags = Graphics.createBufferedBitmap({
          // create an off-screen buffer with a palette of four colors
          :width => width + 7,
          :height => height + 7,
        }).get();

        bufferedDiags
          .getDc()
          .setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        bufferedDiags.getDc().clear();

        drawDiagonalLines(
          bufferedDiags.getDc(),
          0,
          0,
          width + 7,
          height + 7,
          3,
          true
        );
      }

      var mod = System.getClockTime().min % 3;
      dc.drawBitmap2(x - 2 - mod, y - 2, bufferedDiags, {});
    }
  }

  function min(a as Number, b as Number) {
    return a < b ? a : b;
  }

  function max(a as Number, b as Number) {
    return a > b ? b : a;
  }

  // Draw diagonal hatch lines inside a rectangle.
  // dc            - drawing context
  // x, y          - top-left of rectangle
  // width, height - rectangle size
  // spacing       - spacing between adjacent diagonals (pixels)
  // downRight     - true => '\' (slope +1), false => '/' (slope -1)
  function drawDiagonalLines(
    dc,
    x as Number,
    y as Number,
    width as Number,
    height as Number,
    spacing as Number,
    downRight as Boolean
  ) {
    bufferedDiags
      .getDc()
      .setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

    bufferedDiags.getDc().setPenWidth(1);
    if (spacing <= 0) {
      return;
    }

    var x2 = x + width;
    var y2 = y + height;

    if (downRight) {
      // Parameter s goes from -height to width (covers all starting offsets)
      for (var s = -height; s <= width; s += spacing) {
        // compute raw start point on top/left edge
        var sx = s < 0 ? x : x + s;
        var sy = s < 0 ? y - s : y;

        // raw end point by moving down-right by `height` (max)
        var ex = sx + height;
        var ey = sy + height;

        // clip end to rectangle
        if (ex > x2) {
          var dx = x2 - sx;
          ex = x2;
          ey = sy + dx;
        }
        if (ey > y2) {
          var dy = y2 - sy;
          ey = y2;
          ex = sx + dy;
        }

        // also make sure start is inside rect (should be by construction)
        if (sy < y) {
          sy = y;
        }
        if (sx < x) {
          sx = x;
        }

        dc.drawLine(sx, sy, ex, ey);
      }
    } else {
      // slope -1: parameter s goes from 0..(width + height)
      // we'll shift start along top (0..width) then right edge (width..width+height)
      for (var s = -height; s <= width; s += spacing) {
        // compute raw start point on top or right boundary
        var sx = s < 0 ? x : x + s;
        var sy = s < 0 ? y + -s : y;

        // For slope -1 we want to go down-left from start:
        var ex = sx - height;
        var ey = sy + height;

        // clip end to rectangle
        if (ex < x) {
          var dx = sx - x;
          ex = x;
          ey = sy + dx;
        }
        if (ey > y2) {
          var dy = y2 - sy;
          ey = y2;
          ex = sx - dy;
        }

        // ensure start is inside rect
        if (sy < y) {
          sy = y;
        }
        if (sx > x2) {
          sx = x2;
        }

        dc.drawLine(sx, sy, ex, ey);
      }
    }
  }

  function getRotatedXY(
    x as Float,
    y as Float,
    xCenter as Number,
    yCenter as Number,
    angleDeg as Number
  ) as Array<Float> {
    var angleRad = Math.toRadians(angleDeg);
    var cos = Math.cos(angleRad);
    var sin = Math.sin(angleRad);

    var xResult = xCenter + (x - xCenter) * cos - (y - yCenter) * sin;
    var yResult = yCenter + (x - xCenter) * sin + (y - yCenter) * cos;
    return [xResult, yResult];
  }

  function overlay(dc as Dc) as Void {
    if (Properties.getValue("overlayComputation")) {
      dc.setColor(0xffffff, Graphics.COLOR_TRANSPARENT);
      dc.drawText(
        dc.getWidth() / 2,
        dc.getHeight() / 2,
        Graphics.FONT_XTINY,
        "compute" +
          elaspedTimeOnUpdate +
          "ms\n" +
          "mem:" +
          System.getSystemStats().usedMemory / 1024 +
          "/" +
          System.getSystemStats().totalMemory / 1024 +
          "\n" +
          "delayExit:" +
          delayExit,
        Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
      );
    }
  }
}
