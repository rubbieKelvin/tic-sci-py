/* QChart.qml ---
 *
 * Author: Julien Wintz
 * Created: Thu Feb 13 20:59:40 2014 (+0100)
 * Version:
 * Last-Updated: Thu Feb 13 23:57:44 2014 (+0100)
 *           By: Julien Wintz
 *     Update #: 68
 */

/* Change Log:
 *
 */

import QtQuick 2.2

import "../js/QChart.js" as Charts

Canvas {

  id: canvas;

// ///////////////////////////////////////////////////////////////

  property   var chart;
  property   var chartData;
  property   int chartType: 0;
  property  bool chartAnimated: true;
  property alias chartAnimationEasing: chartAnimator.easing.type;
  property alias chartAnimationDuration: chartAnimator.duration;
  property   int chartAnimationProgress: 0;

// /////////////////////////////////////////////////////////////////
// Callbacks
// /////////////////////////////////////////////////////////////////

  onPaint: {
      if(true) {

          switch(chartType) {
          case Charts.ChartType.BAR:
              chart = new Charts.Chart(this, this.getContext("2d")).Bar(chartData);
              break;
          case Charts.ChartType.DOUGHNUT:
              chart = new Charts.Chart(this, this.getContext("2d")).Doughnut(chartData);
              break;
          case Charts.ChartType.LINE:
              chart = new Charts.Chart(this, this.getContext("2d")).Line(chartData);
              break;
          case Charts.ChartType.PIE:
              chart = new Charts.Chart(this, this.getContext("2d")).Pie(chartData);
              break;
          case Charts.ChartType.POLAR:
              chart = new Charts.Chart(this, this.getContext("2d")).PolarArea(chartData);
              break;
          case Charts.ChartType.RADAR:
              chart = new Charts.Chart(this, this.getContext("2d")).Radar(chartData);
              break;
          default:
              console.log('Chart type should be specified.');
          }

          chart.init();

          if (chartAnimated)
              chartAnimator.start();
          else
              chartAnimationProgress = 100;
      }

      chart.draw(chartAnimationProgress/100);
  }

  onChartAnimationProgressChanged: {
      requestPaint();
  }

// /////////////////////////////////////////////////////////////////
// Functions
// /////////////////////////////////////////////////////////////////

  function repaint() {
      chartAnimationProgress = 0;
      chartAnimator.start();
  }

// /////////////////////////////////////////////////////////////////
// Internals
// /////////////////////////////////////////////////////////////////

  PropertyAnimation {
             id: chartAnimator;
         target: canvas;
       property: "chartAnimationProgress";
             to: 100;
       duration: 500;
    easing.type: Easing.InOutElastic;
  }
}
