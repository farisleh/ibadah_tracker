import 'package:flutter/material.dart';
import 'package:ibadah_tracker/daily_list.dart';
import 'package:ibadah_tracker/monthly_list.dart';
import 'package:ibadah_tracker/specific_list.dart';
import 'package:ibadah_tracker/weekly_list.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'model/user.dart';

class PerformancePage extends StatefulWidget {
  final UserInformation user;

  const PerformancePage({Key key, this.user}) : super(key: key);
  @override
  _PerformancePageState createState() => new _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/2.jpeg"),
          fit: BoxFit.fill,
        ),
      ),
      height: MediaQuery.of(context).size.height / 1,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(children: [
          _buildChart(),
          _buildDaily(),
          _buildWeekly(),
          _buildMonthly(),
          _buildSpecific()
        ]),
      ),
    ));
  }

  Widget _buildChart() {
    List<_SalesData> data = [
      _SalesData('Daily', double.parse(widget.user.daily)),
      _SalesData('Weekly', double.parse(widget.user.weekly)),
      _SalesData('Monthly', double.parse(widget.user.monthly)),
    ];
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Ibadah routines performance'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_SalesData, String>>[
              ColumnSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Percentage %',
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaily() {
    final List<ChartDaily> chartDaily = [
      ChartDaily('Achieved', int.parse(widget.user.daily_achieve)),
      ChartDaily('Not Achieve', int.parse(widget.user.daily_not_achieve)),
    ];
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            child: Column(
              children: [
                SfCircularChart(
                    title: ChartTitle(text: 'Daily Overview'),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CircularSeries>[
                      // Render pie chart
                      PieSeries<ChartDaily, String>(
                          dataSource: chartDaily,
                          pointColorMapper: (ChartDaily data, _) => data.color,
                          xValueMapper: (ChartDaily data, _) => data.x,
                          yValueMapper: (ChartDaily data, _) => data.y,
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                    ]),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                        height: 35,
                        width: 250, // specific value
                        child: RaisedButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DailyView(user: widget.user),
                                ),
                              );
                            },
                            color: Colors.green,
                            textColor: Colors.white,
                            icon: Icon(Icons.list),
                            label: Text("Daily's Ibadah List"))))
              ],
            ),
          )),
    );
  }

  Widget _buildWeekly() {
    final List<ChartWeekly> chartWeekly = [
      ChartWeekly('Achieved', int.parse(widget.user.weekly_achieve)),
      ChartWeekly('Not Achieve', int.parse(widget.user.weekly_not_achieve)),
    ];
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Column(
          children: [
            SfCircularChart(
                title: ChartTitle(text: 'Weekly Overview'),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CircularSeries>[
                  // Render pie chart
                  PieSeries<ChartWeekly, String>(
                      dataSource: chartWeekly,
                      pointColorMapper: (ChartWeekly data, _) => data.color,
                      xValueMapper: (ChartWeekly data, _) => data.x,
                      yValueMapper: (ChartWeekly data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                    height: 35,
                    width: 250, // specific value
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WeeklyView(user: widget.user),
                            ),
                          );
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        icon: Icon(Icons.list),
                        label: Text("Weekly's Ibadah List"))))
          ],
        )),
      ),
    );
  }

  Widget _buildMonthly() {
    final List<ChartMonthly> chartMonthly = [
      ChartMonthly('Achieved', int.parse(widget.user.monthly_achieve)),
      ChartMonthly('Not Achieve', int.parse(widget.user.monthly_not_achieve)),
    ];
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Column(
          children: [
            SfCircularChart(
                title: ChartTitle(text: 'Montly Overview'),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CircularSeries>[
                  // Render pie chart
                  PieSeries<ChartMonthly, String>(
                      dataSource: chartMonthly,
                      pointColorMapper: (ChartMonthly data, _) => data.color,
                      xValueMapper: (ChartMonthly data, _) => data.x,
                      yValueMapper: (ChartMonthly data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                    height: 35,
                    width: 250, // specific value
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MonthlyView(user: widget.user),
                            ),
                          );
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        icon: Icon(Icons.list),
                        label: Text("Monthly's Ibadah List"))))
          ],
        )),
      ),
    );
  }

  Widget _buildSpecific() {
    final List<ChartSpecific> chartSpecific = [
      ChartSpecific('Achieved', int.parse(widget.user.specific_achieve)),
      ChartSpecific('Not Achieve', int.parse(widget.user.specific_not_achieve)),
    ];
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Column(
          children: [
            SfCircularChart(
                title: ChartTitle(text: 'Specific Date Overview'),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CircularSeries>[
                  // Render pie chart
                  PieSeries<ChartSpecific, String>(
                      dataSource: chartSpecific,
                      pointColorMapper: (ChartSpecific data, _) => data.color,
                      xValueMapper: (ChartSpecific data, _) => data.x,
                      yValueMapper: (ChartSpecific data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                    height: 35,
                    width: 250, // specific value
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SpecificView(user: widget.user),
                            ),
                          );
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        icon: Icon(Icons.list),
                        label: Text("Specific Date's Ibadah List"))))
          ],
        )),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class ChartDaily {
  ChartDaily(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color color;
}

class ChartWeekly {
  ChartWeekly(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color color;
}

class ChartMonthly {
  ChartMonthly(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color color;
}

class ChartSpecific {
  ChartSpecific(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color color;
}
