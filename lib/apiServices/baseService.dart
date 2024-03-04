abstract class BaseService {
  Future<dynamic> getResponse(String url, var headers);
  Future<dynamic> postResponse(String url, var body, var headers);
}
