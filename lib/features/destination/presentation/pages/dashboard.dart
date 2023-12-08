import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_course/features/destination/presentation/cubit/dashboard_cubit_cubit.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: context.read<DashboardCubit>().menuDashboard.map((e) {
          return NavigationDestination(
            icon: Icon(
              e[1],
              color: Colors.grey[500],
            ),
            label: e[0],
            tooltip: e[0],
            selectedIcon: Icon(
              e[1],
              color: Theme.of(context).primaryColor,
            ),
          );
        }).toList(),
      ),
    );
  }
}
