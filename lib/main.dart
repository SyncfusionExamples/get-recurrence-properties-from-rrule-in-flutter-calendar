import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false, home: new GetRecurrenceRule()));
}

class GetRecurrenceRule extends StatefulWidget {
  @override
  _GetRecurrenceRuleState createState() => new _GetRecurrenceRuleState();
}

class _GetRecurrenceRuleState extends State<GetRecurrenceRule> {
  String _recurrenceRule;
  DateTime _startTime = DateTime.now();

  @override
  void initState() {
    _startTime = DateTime.now();
    _recurrenceRule = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,WE;UNTIL=20210810';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: new RaisedButton(
                onPressed: _showDialog,
                child: new Text("Get recurrence rule"),
              ),
            ),
            Expanded(
                child: SfCalendar(
              view: CalendarView.month,
              dataSource: _getCalendarDataSource(),
            ))
          ],
        ),
      ),
    );
  }

  _showDialog() async {
    RecurrenceProperties _recurrenceProperties =
        SfCalendar.parseRRule(_recurrenceRule, _startTime);

    await showDialog(
      context: context,
      // ignore: deprecated_member_use
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type:' + _recurrenceProperties.recurrenceType.toString(),
            ),
            Text(
              'Count:' + _recurrenceProperties.recurrenceCount.toString(),
            ),
            Text(
              'StartDate:' + _recurrenceProperties.startDate.toString(),
            ),
            Text(
              'EndDate:' + _recurrenceProperties.endDate.toString(),
            ),
            Text(
              'Interval: ' + _recurrenceProperties.interval.toString(),
            ),
            Text(
              'Range:' + _recurrenceProperties.recurrenceRange.toString(),
            ),
            Text(
              'WeekDays:' + _recurrenceProperties.weekDays.toString(),
            ),
            Text(
              'Week:' + _recurrenceProperties.week.toString(),
            ),
            Text(
              'DayOfMonth:' + _recurrenceProperties.dayOfMonth.toString(),
            ),
            Text(
              'DayOfWeek:' + _recurrenceProperties.dayOfWeek.toString(),
            ),
            Text(
              'Month:' + _recurrenceProperties.month.toString(),
            ),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
        startTime: _startTime,
        endTime: _startTime.add(Duration(hours: 1)),
        subject: 'Meeting',
        color: Colors.blue,
        recurrenceRule: _recurrenceRule));

    return _AppointmentDataSource(appointments);
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
