import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/logic/cubit/appointment/medication_reminders_cubit.dart';
import 'package:nthm_app/presentation/screens/appointment/add_appointment/add_appointment_screen.dart';
import 'package:nthm_app/utils/responsive.dart';

class MedicationRemindersScreen extends StatelessWidget {
  const MedicationRemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Medication Reminders',
          style: TextStyle(
            fontSize: responsive.getFontSize(22),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: responsive.getWidth(4)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
              color: const Color(0xFF368fd2),
            ),
            child: IconButton(
              icon: Icon(Icons.add, size: responsive.getFontSize(24), color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAppointmentScreen()),
                );
              },
            ),
          ),
        ],

      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF368fd2),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive.getWidth(5)),
          child: BlocProvider(
            create: (context) => MedicationRemindersCubit()..fetchReminders(),
            child: BlocBuilder<MedicationRemindersCubit, List<Map<String, dynamic>>>(
              builder: (context, reminders) {
                if (reminders.isEmpty) {
                  return Center(
                    child: Text(
                      'No medication reminders found.',
                      style: TextStyle(fontSize: responsive.getFontSize(18), color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = reminders[index];
                    return Card(
                      margin: EdgeInsets.symmetric(
                        vertical: responsive.getHeight(1),
                        horizontal: responsive.getWidth(2),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black54,
                      child: Padding(
                        padding: EdgeInsets.all(responsive.getWidth(4)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.medication, color: Color(0xFF368fd2), size: responsive.getFontSize(22)),
                                SizedBox(width: responsive.getWidth(2)),
                                Text(
                                  reminder['medicationName'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: responsive.getFontSize(18),
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: responsive.getHeight(2),
                              color: Colors.grey[300],
                              thickness: 1,
                            ),
                            SizedBox(height: responsive.getHeight(1)),
                            Text(
                              'Doses: ${reminder['doses']}',
                              style: TextStyle(
                                fontSize: responsive.getFontSize(16),
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: responsive.getHeight(1)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Start Date: ${reminder['startDate'].toString().split(' ')[0]}',
                                  style: TextStyle(fontSize: responsive.getFontSize(14), color: Colors.grey[600]),
                                ),
                                Text(
                                  'End Date: ${reminder['endDate'].toString().split(' ')[0]}',
                                  style: TextStyle(fontSize: responsive.getFontSize(14), color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            SizedBox(height: responsive.getHeight(1)),
                            Text(
                              'Times: ${reminder['times'].join(", ")}',
                              style: TextStyle(
                                fontSize: responsive.getFontSize(16),
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
