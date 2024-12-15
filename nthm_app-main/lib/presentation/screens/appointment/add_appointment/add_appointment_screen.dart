import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/logic/cubit/appointment/add_appointment/add_appointment_cubit.dart';
import 'package:nthm_app/utils/responsive.dart';

class AddAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddAppointmentCubit>(context);
    final responsive = Responsive(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Add Medication Reminder',
          style: TextStyle(
            fontSize: responsive.getFontSize(22),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove AppBar shadow
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
          padding: EdgeInsets.symmetric(
            horizontal: responsive.getWidth(5),
            vertical: responsive.getHeight(2),
          ),
          child: Column(
            children: [
              SizedBox(height: responsive.getHeight(12)),
              _buildTextField(
                context,
                cubit.medicationController,
                'Medication Name',
              ),
              SizedBox(height: responsive.getHeight(2)),
              _buildTextField(
                context,
                cubit.dosesController,
                'Number of Doses',
                inputType: TextInputType.number,
              ),
              SizedBox(height: responsive.getHeight(2)),
              _buildDatePickers(context, cubit, responsive),
              SizedBox(height: responsive.getHeight(2)),
              _buildTimeField(context, cubit, responsive),
              SizedBox(height: responsive.getHeight(2)),
              Expanded(child: _buildTimesList(context, responsive)),
              _buildAddAppointmentButton(context, cubit, responsive),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController controller, String label, {TextInputType inputType = TextInputType.text}) {
    final responsive = Responsive(context);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(responsive.getWidth(2)),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: responsive.getWidth(4),
          vertical: responsive.getHeight(2),
        ),
      ),
      keyboardType: inputType,
    );
  }

  Widget _buildDatePickers(BuildContext context, AddAppointmentCubit cubit, Responsive responsive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDatePickerButton(
              context: context,
              label: 'Start Date',
              onTap: () async {
                final selectedDate = await _selectDate(context);
                if (selectedDate != null) cubit.selectStartDate(selectedDate);
              },
              responsive: responsive,
            ),
            SizedBox(height: responsive.getHeight(1)),
            BlocBuilder<AddAppointmentCubit, List<Map<String, dynamic>>>(
              builder: (context, state) {
                return Text(
                  cubit.startDate != null
                      ? 'Selected: ${cubit.startDate!.toLocal().toString().split(' ')[0]}'
                      : 'No Start Date',
                  style: TextStyle(fontSize: responsive.getFontSize(14)),
                );
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDatePickerButton(
              context: context,
              label: 'End Date',
              onTap: () async {
                final selectedDate = await _selectDate(context);
                if (selectedDate != null) cubit.selectEndDate(selectedDate);
              },
              responsive: responsive,
            ),
            SizedBox(height: responsive.getHeight(1)),
            BlocBuilder<AddAppointmentCubit, List<Map<String, dynamic>>>(
              builder: (context, state) {
                return Text(
                  cubit.endDate != null
                      ? 'Selected: ${cubit.endDate!.toLocal().toString().split(' ')[0]}'
                      : 'No End Date',
                  style: TextStyle(fontSize: responsive.getFontSize(14)),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePickerButton({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
    required Responsive responsive,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF368fd2),

        padding: EdgeInsets.symmetric(
          vertical: responsive.getHeight(2),
          horizontal: responsive.getWidth(4),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsive.getWidth(3)),
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: responsive.getFontSize(16),color: Colors.white)),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
  }

  Widget _buildTimeField(BuildContext context, AddAppointmentCubit cubit, Responsive responsive) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              final selectedTime = await _selectTime(context);
              if (selectedTime != null) {
                cubit.addTime(selectedTime);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF368fd2),
              padding: EdgeInsets.symmetric(
                vertical: responsive.getHeight(2),
                horizontal: responsive.getWidth(4),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(responsive.getWidth(3)),
              ),
            ),
            child: Text(
              'Select Medication Time',
              style: TextStyle(fontSize: responsive.getFontSize(16), color: Colors.white),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add, size: responsive.getFontSize(24)),
          onPressed: () async {
            final selectedTime = await _selectTime(context);
            if (selectedTime != null) {
              cubit.addTime(selectedTime);
            }
          },
        ),
      ],
    );
  }

  Future<String?> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final time = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    }
    return null;
  }


  Widget _buildTimesList(BuildContext context, Responsive responsive) {
    return BlocBuilder<AddAppointmentCubit, List<Map<String, dynamic>>>(
      builder: (context, times) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: times.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: responsive.getHeight(1)),
              child: ListTile(
                title: Text(
                  times[index]["time"],
                  style: TextStyle(fontSize: responsive.getFontSize(16)),
                ),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(responsive.getWidth(2)),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAddAppointmentButton(BuildContext context, AddAppointmentCubit cubit, Responsive responsive) {
    return ElevatedButton(
      onPressed: () {
        if (cubit.medicationController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a medication name')),
          );
          return;
        }

        if (cubit.dosesController.text.isEmpty || int.tryParse(cubit.dosesController.text) == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a valid number of doses')),
          );
          return;
        }

        if (cubit.startDate == null || cubit.endDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select start and end dates')),
          );
          return;
        }

        if (cubit.state.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please add at least one medication time')),
          );
          return;
        }

        // Now attempt to add the appointment
        cubit.addAppointment().then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Appointment added successfully!')),
          );

          // Pop the screen and pass a success result
          Navigator.pop(context, true);
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add appointment: $error')),
          );
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF368fd2),
        padding: EdgeInsets.symmetric(
          vertical: responsive.getHeight(2),
          horizontal: responsive.getWidth(6),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsive.getWidth(3)),
        ),
      ),
      child: Text(
        'Add Appointment',
        style: TextStyle(fontSize: responsive.getFontSize(18), color: Colors.white),
      ),
    );
  }
}

