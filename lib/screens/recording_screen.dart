// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../bloc/recording/recording_bloc.dart';
import '../bloc/recording/recording_event.dart';
import '../bloc/recording/recording_state.dart';
import '../utils/permissions_helper.dart';
import 'playback_screen.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen>
    with WidgetsBindingObserver {
  static const durations = {
    '15 Seconds': Duration(seconds: 15),
    '30 Seconds': Duration(seconds: 30),
    '1 Minute': Duration(minutes: 1),
    '2 Minutes': Duration(minutes: 2),
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: BlocConsumer<RecordingBloc, RecordingState>(
            listener: (context, state) {
              if (state is RecordingError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is RecordingStopped) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Recording saved.")),
                );
              }
            },
            builder: (context, state) {
              final bloc = context.read<RecordingBloc>();

              // final selectedLabel = durations.entries
              //     .firstWhere((e) => e.value == bloc.selectedDuration,
              //         orElse: () => durations.entries.first)
              //     .key;

              // String? dropdownValue = selectedLabel;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(1.h),
                      ),
                      child: DropdownButtonFormField<String>(
                        //  value: dropdownValue,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.sp),
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Select Duration',
                            hintStyle:
                                TextStyle(fontSize: 18.sp, color: Colors.grey)),
                        icon: const Icon(Icons.arrow_drop_down),
                        dropdownColor: Colors.black,
                        items: durations.keys
                            .map((label) => DropdownMenuItem(
                                  value: label,
                                  child: Text(
                                    label,
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ))
                            .toList(),
                        onChanged: (val) {
                          bloc.add(SelectDuration(durations[val!]!));
                        },
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionButton(
                          context: context,
                          isDisabled: state is RecordingInProgress,
                          label: "Start Recording",
                          icon: Icons.fiber_manual_record,
                          color: Color(0xFF4A00E0),
                          onPressed: () async {
                            final granted = await PermissionsHelper
                                .requestRecordingPermissions();
                            if (granted) {
                              bloc.add(StartRecording());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Permissions denied")),
                              );
                            }
                          },
                        ),
                        _buildActionButton(
                          context: context,
                          isDisabled: state is! RecordingInProgress,
                          label: "Stop Recording",
                          icon: Icons.stop_circle,
                          color: Colors.redAccent.shade700,
                          onPressed: () {
                            bloc.add(StopRecording());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required bool isDisabled,
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: Opacity(
        opacity: isDisabled ? 0.6 : 1.0,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.h),
            ),
          ),
          icon: Icon(icon, size: 20.sp),
          label: Text(label, style: TextStyle(fontSize: 16.sp)),
          onPressed: isDisabled ? null : onPressed,
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text("Screen Recorder"),
      actions: [
        IconButton(
          icon: const Icon(Icons.video_library),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PlaybackScreen()),
            );
          },
        ),
      ],
    );
  }
}
