import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: GetRecurrenceRule()));
}

class GetRecurrenceRule extends StatefulWidget {
  const GetRecurrenceRule({super.key});

  @override
  _GetRecurrenceRuleState createState() => _GetRecurrenceRuleState();
}

class _GetRecurrenceRuleState extends State<GetRecurrenceRule> {
  final String _recurrenceRule = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,WE;UNTIL=20250810';
  final DateTime _startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: TextButton(
                onPressed: _showDialog,
                child: const Text("Get recurrence rule"),
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
    RecurrenceProperties recurrenceProperties =
    SfCalendar.parseRRule(_recurrenceRule, _startTime);

    await showDialog(
      context: context,
      // ignore: deprecated_member_use

      builder: (BuildContext context) {return AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type:${recurrenceProperties.recurrenceType}',
            ),
            Text(
              'Count:${recurrenceProperties.recurrenceCount}',
            ),
            Text(
              'StartDate:${recurrenceProperties.startDate}',
            ),
            Text(
              'EndDate:${recurrenceProperties.endDate}',
            ),
            Text(
              'Interval: ${recurrenceProperties.interval}',
            ),
            Text(
              'Range:${recurrenceProperties.recurrenceRange}',
            ),
            Text(
              'WeekDays:${recurrenceProperties.weekDays}',
            ),
            Text(
              'Week:${recurrenceProperties.week}',
            ),
            Text(
              'DayOfMonth:${recurrenceProperties.dayOfMonth}',
            ),
            Text(
              'DayOfWeek:${recurrenceProperties.dayOfWeek}',
            ),
            Text(
              'Month:${recurrenceProperties.month}',
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      );},
    );
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
        startTime: _startTime,
        endTime: _startTime.add(const Duration(hours: 1)),
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