import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/enums.dart';
import '../cubit/users_cubit.dart';
import 'custom_segmented_control.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order',
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        CustomSegmentedControl<OrderOption>(
          options: OrderOption.values,
          height: 42.h,
          selectedValue: context.watch<UsersCubit>().state.order,
          onChanged: (newValue) {
            context.read<UsersCubit>().onOrderChanged(newValue);
          },
        ),
        SizedBox(height: 16.h),
        Text(
          'Sort by',
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        CustomSegmentedControl<SortOption>(
          height: 60.h,
          options: SortOption.values,
          selectedValue: context.watch<UsersCubit>().state.sort,
          onChanged: (newValue) {
            context.read<UsersCubit>().onSortChanged(newValue);
          },
        ),
      ],
    );
  }
}
