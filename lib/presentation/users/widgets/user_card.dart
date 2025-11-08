import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/users_response_model.dart';
import '../../bookmarks/cubit/bookmarks_cubit.dart';
import '../screens/user_details_screen.dart';

class UserCard extends StatelessWidget {
  final User user;
  final EdgeInsetsGeometry? margin;

  const UserCard({super.key, required this.user, this.margin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsScreen(user: user),
          ),
        );
      },
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundImage: NetworkImage(user.profileImage ?? ''),
                onBackgroundImageError: (exception, stackTrace) {},
                backgroundColor: colorScheme.surfaceVariant,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  user.displayName ?? 'No Name',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${user.reputation}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primaryContainer,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Reputation',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              BlocBuilder<BookmarksCubit, BookmarksState>(
                builder: (context, state) {
                  final isBookmarked =
                      context.read<BookmarksCubit>().isBookmarked(user.userId);
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
        ),
      ),
    );
  }
}
