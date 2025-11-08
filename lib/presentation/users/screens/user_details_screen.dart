import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/users_response_model.dart';
import '../../bookmarks/cubit/bookmarks_cubit.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName ?? 'User Details'),
        actions: [
          BlocBuilder<BookmarksCubit, BookmarksState>(
            builder: (context, state) {
              final isBookmarked = context.read<BookmarksCubit>().isBookmarked(
                    user.userId,
                  );
              return IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: colorScheme.primary,
                ),
                onPressed: () {
                  context.read<BookmarksCubit>().toggleBookmark(user);
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80.r,
                backgroundImage: NetworkImage(user.profileImage ?? ''),
                backgroundColor: colorScheme.surfaceVariant,
              ),
            ),
            SizedBox(height: 24.h),
            Center(
              child: Text(
                user.displayName ?? 'No Name',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            _buildDetailRow(
              theme,
              icon: Icons.star_border,
              label: 'Reputation',
              value: user.reputation?.toString() ?? 'N/A',
            ),
            _buildDetailRow(
              theme,
              icon: Icons.person_outline,
              label: 'User Type',
              value: user.userType ?? 'N/A',
            ),
            _buildDetailRow(
              theme,
              icon: Icons.location_on_outlined,
              label: 'Location',
              value: user.location ?? 'Not specified',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24.w),
          SizedBox(width: 16.w),
          Text(label, style: theme.textTheme.titleMedium),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
