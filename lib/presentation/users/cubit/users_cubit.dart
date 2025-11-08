import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/remote/network_service.dart';
import '../../../data/models/enums.dart';
import '../../../data/models/users_response_model.dart';
import '../../../data/repos/users_repo.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(const UsersState());

  final UsersRepo _repo = UsersRepo(NetworkService());

  void init() {
    getUsers();
  }

  Future<void> getUsers() async {
    if (state.isLoading || state.isLoadingMore) return;
    final isFirstPage = state.page == 1;
    if (isFirstPage) {
      emit(state.copyWith(fetchingUsersState: States.loading));
    } else {
      emit(state.copyWith(fetchingUsersState: States.loadingMore));
    }

    var result = await _repo.getUsers(
      page: state.page,
      order: state.order,
      sort: state.sort,
    );
    result.handle(
      onSuccess: (response) {
        emit(
          state.copyWith(
            users: [...state.users, ...response?.users ?? []],
            fetchingUsersState: States.success,
            hasMore: response?.hasMore ?? false,
            page: state.page + 1,
          ),
        );
      },
      onError: (error) => {
        emit(
          state.copyWith(
            fetchingUsersState: States.error,
            errorMessage: error.toString(),
          ),
        ),
      },
    );
  }

  void onOrderChanged(OrderOption order) {
    emit(state.copyWith(order: order, page: 1, users: []));
    getUsers();
  }

  void onSortChanged(SortOption sort) {
    emit(state.copyWith(sort: sort, page: 1, users: []));
    getUsers();
  }
}
