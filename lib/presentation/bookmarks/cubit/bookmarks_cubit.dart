import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/local/database_helper.dart';
import '../../../data/models/users_response_model.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  final DatabaseHelper _dbHelper;

  BookmarksCubit(this._dbHelper) : super(const BookmarksState());

  Future<void> loadBookmarkedUsers() async {
    emit(state.copyWith(status: BookmarksStatus.loading));
    try {
      final users = await _dbHelper.getBookmarkedUsers();
      emit(
        state.copyWith(status: BookmarksStatus.success, bookmarkedUsers: users),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookmarksStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> toggleBookmark(User user) async {
    try {
      final isBookmarked = await _dbHelper.isBookmarked(user.userId);
      if (isBookmarked) {
        await _dbHelper.unbookmarkUser(user.userId);
      } else {
        await _dbHelper.bookmarkUser(user);
      }
      await loadBookmarkedUsers();
    } catch (e) {
      emit(
        state.copyWith(
          status: BookmarksStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  bool isBookmarked(int? userId) {
    return state.bookmarkedUsers.any((user) => user.userId == userId);
  }
}
