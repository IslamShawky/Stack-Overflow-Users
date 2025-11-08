part of 'users_cubit.dart';

enum States { initial, loading, success, error, loadingMore }

class UsersState extends Equatable {
  final List<User> users;
  final States fetchingUsersState;
  final String? errorMessage;
  final bool hasMore;
  final int page;
  final OrderOption order;
  final SortOption sort;

  const UsersState({
    this.users = const <User>[],
    this.fetchingUsersState = States.initial,
    this.errorMessage,
    this.hasMore = false,
    this.page = 1,
    this.order = OrderOption.desc,
    this.sort = SortOption.reputation,
  });

  bool get isLoading => fetchingUsersState == States.loading;

  bool get isLoadingMore => fetchingUsersState == States.loadingMore;

  bool get hasError => fetchingUsersState == States.error;

  UsersState copyWith({
    List<User>? users,
    States? fetchingUsersState,
    String? errorMessage,
    bool? hasMore,
    int? page,
    OrderOption? order,
    SortOption? sort,
  }) {
    return UsersState(
      users: users ?? this.users,
      fetchingUsersState: fetchingUsersState ?? this.fetchingUsersState,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      order: order ?? this.order,
      sort: sort ?? this.sort,
    );
  }

  @override
  List<Object?> get props => [
    users,
    fetchingUsersState,
    errorMessage,
    hasMore,
    page,
    order,
    sort,
  ];
}
