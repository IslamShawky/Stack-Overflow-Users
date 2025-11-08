import '../datasources/remote/models/endpoint.dart';
import '../datasources/remote/models/result.dart';
import '../datasources/remote/network_service.dart';
import '../models/enums.dart';
import '../models/users_response_model.dart';

class UsersRepo {
  final NetworkService _networkService;

  UsersRepo(NetworkService networkService) : _networkService = networkService;

  Future<Result<UsersResponseModel?>> getUsers({
    int page = 1,
    int pageSize = 10,
    OrderOption order = OrderOption.desc,
    SortOption sort = SortOption.reputation,
  }) async {
    return _networkService.sendRequest<UsersResponseModel>(
      endpoint: Endpoint(
        path: '/users',
        httpMethod: HttpMethod.GET,
        queryParameters: {
          'page': page,
          'pagesize': pageSize,
          'order': order.value,
          'sort': sort.value,
          'site': 'stackoverflow',
        },
      ),
      responseParser: (responseJson) =>
          UsersResponseModel.fromJson(responseJson),
    );
  }
}
