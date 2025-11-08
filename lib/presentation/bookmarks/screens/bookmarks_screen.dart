import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../users/widgets/user_card.dart';
import '../cubit/bookmarks_cubit.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookmarksCubit>().loadBookmarkedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: BlocBuilder<BookmarksCubit, BookmarksState>(
        builder: (context, state) {
          if (state.status == BookmarksStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == BookmarksStatus.error) {
            return Center(
              child: Text(state.errorMessage ?? 'An error occurred.'),
            );
          } else if (state.bookmarkedUsers.isEmpty) {
            return const Center(child: Text('No bookmarks yet.'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(top: 10.h),
              itemCount: state.bookmarkedUsers.length,
              itemBuilder: (context, index) {
                return UserCard(
                  user: state.bookmarkedUsers[index],
                  margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                );
              },
            );
          }
        },
      ),
    );
  }
}
