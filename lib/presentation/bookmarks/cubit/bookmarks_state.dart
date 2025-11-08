part of 'bookmarks_cubit.dart';

enum BookmarksStatus { initial, loading, success, error }

class BookmarksState extends Equatable {
  final List<User> bookmarkedUsers;
  final BookmarksStatus status;
  final String? errorMessage;

  const BookmarksState({
    this.bookmarkedUsers = const [],
    this.status = BookmarksStatus.initial,
    this.errorMessage,
  });

  BookmarksState copyWith({
    List<User>? bookmarkedUsers,
    BookmarksStatus? status,
    String? errorMessage,
  }) {
    return BookmarksState(
      bookmarkedUsers: bookmarkedUsers ?? this.bookmarkedUsers,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [bookmarkedUsers, status, errorMessage];
}
